import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/api/debouncer.dart';
import 'package:fnx_ui/api/input_component.dart';
import 'package:fnx_ui/api/pair.dart';
import 'package:fnx_ui/api/ui.dart' as ui;
import 'package:fnx_ui/components/fnx_dropdown/fnx_dropdown.dart';
import 'package:fnx_ui/components/fnx_text/fnx_text.dart';
import 'package:fnx_ui/directives/fnx_focus/fnx_focus.dart';
import 'package:logging/logging.dart';

typedef OptionsProvider<T> = Future<List<Pair<T>>> Function(String filledText);
typedef DefaultOptionProvider<T> = Future<Pair<T>> Function(
    dynamic initialValue);

const CUSTOM_AUTOCOMPLETE_VALUE_ACCESSOR =
    const Provider(ngValueAccessor, useExisting: FnxAutocomplete);

@Component(
  selector: 'fnx-autocomplete',
  templateUrl: 'fnx_autocomplete.html',
  providers: const [
    CUSTOM_AUTOCOMPLETE_VALUE_ACCESSOR,
    const Provider(Focusable, useExisting: FnxAutocomplete),
    const Provider(FnxBaseComponent, useExisting: FnxAutocomplete),
  ],
  preserveWhitespace: false,
  directives: [coreDirectives, formDirectives, AutoFocus, FnxDropdown, FnxText],
)
class FnxAutocomplete<T> extends FnxInputComponent<T>
    implements ControlValueAccessor<T>, OnInit, OnDestroy, Focusable {
  final Logger log = Logger("FnxScrollPanel");

  @HostBinding('class.no-padding')
  static const bool hostIsItem = true;

  HtmlElement host;

  @Input()
  bool required = false;

  @Input()
  bool readonly = false;

  @Input()
  bool nullable = false;

  @Input()
  String placeholder = null;

  @Input()
  String maxHeight = "400px";

  @Input()
  String maxWidth = "400px";

  String nothingFoundLabel = "Nenašel jsem nic";

  @Input()
  OptionsProvider<T> optionsProvider;

  @Input()
  DefaultOptionProvider<T> defaultOptionProvider;

  String _text;

  bool open = false;

  bool get dropDownVisible => open && !isReadonly && options.isNotEmpty;

  StreamSubscription<String> navigationActionsSubscription;

  StreamSubscription<String> filledTextChangedSubscription;
  StreamController<String> filledTextChanged = StreamController<String>();

  List<Pair<T>> options = [];

  List<Pair<T>> loadedOptions = [];

  Node container;

  String get text => _text;

  @Input()
  set text(String val) {
    _text = val;
    filledTextChanged.add(val);
    if (_text != null) {
      showOptions();
    }
  }

  FnxAutocomplete(@SkipSelf() @Optional() FnxBaseComponent parent, this.host)
      : super(parent) {
    filledTextChangedSubscription = filledTextChanged.stream
        .transform<String>(FnxStreamDebouncer(new Duration(milliseconds: 50)))
        .listen(loadFreshOptions);
  }

  void writeValue(obj) {
    // pricestovala nova hodnota z modelu
    super.writeValue(obj);
    _text = null;
    if (value == null) return;
    if (loadedOptions != null || loadedOptions.isNotEmpty) {
      Pair p = loadedOptions.firstWhere((Pair p) => p.value == obj,
          orElse: () => null);
      if (p != null) {
        _text = p.label;
      }
    }
    if (_text == null) {
      loadInitialOption();
    }
  }

  void hideOptions() {
    log.fine("Hiding options");
    open = false;
    if (value != null) {
      _text = options
          .firstWhere((Pair p) => p.value == value, orElse: () => null)
          ?.label;
    } else {
      _text = '';
    }
  }

  void showOptions() {
    open = true;
  }

  bool isSelected(Pair v) {
    return value == v.value;
  }

  bool isHighlighted(Pair<T> opt) {
    return _highlighted == opt;
  }

  void leaveText(_) {
    later(hideOptionsIfNoFocus);
  }

  hideOptionsIfNoFocus() {
    log.fine(document.activeElement);
    if (document.activeElement == null) {
      log.fine("No focus");
      hideOptions();
      return;
    }
    if (ui.isAncestorOf(host, document.activeElement)) {
      log.fine("We still have focus");
      return;
    }
    hideOptions();
  }

  void selectOption(Pair<T> pair) {
    log.fine("Selecting value ${pair.value}");
    value = pair?.value;
    _text = pair?.label ?? "";
    hideOptions();
  }

  Pair<T> _highlighted = null;

  void bindKeyHandler() {
    var actions = <int, String>{
      KeyCode.ENTER: 'SELECT',
      KeyCode.UP: 'UP',
      KeyCode.DOWN: 'DOWN'
    };
    var supportedKeys = Set<int>.from(actions.keys);

    var actionsStream = ui
        .keyDownEvents(host)
        .where((event) => supportedKeys.contains(event.keyCode))
        .map((event) {
      event.preventDefault();
      if (dropDownVisible) {
        event.stopPropagation();
      }
      return event;
    }).map((event) => actions[event.keyCode]);

    navigationActionsSubscription = actionsStream.listen((var action) {
      if (action == 'UP') {
        if (dropDownVisible) {
          highlightNext(_highlighted, loadedOptions.reversed);
        }
      } else if (action == 'DOWN') {
        if (!dropDownVisible) {
          showOptions();
        } else {
          highlightNext(_highlighted, loadedOptions);
        }
      } else if (action == 'SELECT') {
        if (!dropDownVisible) {
          showOptions();
        } else {
          if (_highlighted != null) selectOption(_highlighted);
        }
      }
    });
  }

  void highlightNext(Pair<T> current, Iterable<Pair<T>> options) {
    Pair<T> next = findNext(current, options);
    _highlighted = next;
    scrollToHighlighted();
  }

  Pair<T> findNext(Pair<T> current, Iterable<Pair<T>> all) {
    // we have nowhere to navigate
    if (all == null || all.isEmpty) return null;
    // current is empty, return first option
    if (current == null && options.isEmpty) return null;
    if (current == null) return options.first;
    // drop all items until we find current in the collection of all
    var currentAndRest = all.skipWhile((option) => option != current);
    // current has not been found in the collection of all options, return first
    if (currentAndRest.isEmpty) return all.first;
    // skip current and get rest of the options
    var rest = currentAndRest.skip(1);
    // if current has been the last, return first option
    if (rest.isEmpty) return all.first;
    // else return the next item
    return rest.first;
  }

  @override
  ngOnInit() async {
    super.ngOnInit();
    bindKeyHandler();
  }

  @override
  ngOnDestroy() {
    super.ngOnDestroy();
    navigationActionsSubscription?.cancel();
    filledTextChangedSubscription?.cancel();
    navigationActionsSubscription = null;
  }

  @override
  bool get hasValidValue {
    if (required) {
      if (value == null) return false;
    }
    return true;
  }

  int version = 0;

  Future<Null> loadInitialOption() async {
    if (defaultOptionProvider == null) return;
    version++;
    var loadingFor = version;
    var loaded = await defaultOptionProvider(value);
    if (loadingFor == version) {
      // we will use this
      if (loaded != null) {
        _text = loaded.label;
        loadedOptions = [loaded];
        updateOptionsFromSearch();
      }
    } else {
      // too old next batch is comming
    }
  }

  Future<Null> loadFreshOptions(String data) async {
    version++;
    var loadingFor = version;
    var loaded = await optionsProvider(data);
    if (loadingFor == version) {
      // we will use this
      loadedOptions = loaded ?? const [];
      updateOptionsFromSearch();
    } else {
      // too old next batch is comming
    }
  }

  void updateOptionsFromSearch() {
    options = null;
    if (loadedOptions == null || loadedOptions.isEmpty) {
      options = const [];
      value = null;
      return;
    }
/*
    options = loadedOptions.where((Pair p) {
      return p.label.contains(filledText) || p.value.contains(filledText);
    }).toList();
*/
    options = loadedOptions;
    if (options.isEmpty) {
      value = null;
      return;
    }
    if (options.length == 1) {
      value = options.first.value;
    }

    if (value != null) {
      if (options.firstWhere((p) => p.value == value, orElse: () => null) ==
          null) {
        value = null;
      }
    }
    if (value == null) {
      var p = options.firstWhere((p) => p.label == _text, orElse: () => null);
      if (p != null) {
        value = p.value;
      }
    }
  }

  @override
  void focus() {
    later(() {
      /*
      if (input != null && input.nativeElement != null) {
        input.nativeElement.focus();
      }

       */
    });
  }

  @override
  bool get disabled => false;

  void scrollToHighlighted() {
    new Future.delayed(new Duration(milliseconds: 100)).then((_) {
      Element e = (host as Element).querySelector(".item-column .hover");
      if (e != null) {
        e.scrollIntoView();
      }
    });
  }
}
