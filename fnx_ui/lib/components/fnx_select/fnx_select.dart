import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/api/input_component.dart';
import 'package:fnx_ui/api/ui.dart' as ui;
import 'package:fnx_ui/components/fnx_dropdown/fnx_dropdown.dart';
import 'package:fnx_ui/components/fnx_text/fnx_text.dart';
import 'package:fnx_ui/directives/fnx_focus/fnx_focus.dart';
import 'package:fnx_ui/fnx_ui.dart';

typedef String ValueDescriptionRenderer();

const CUSTOM_SELECT_VALUE_ACCESSOR = const Provider(ngValueAccessor, useExisting: FnxSelect, multi: true);

@Component(
  selector: 'fnx-select',
  templateUrl: 'fnx_select.html',
  providers: const [
    CUSTOM_SELECT_VALUE_ACCESSOR,
    const Provider(Focusable, useExisting: FnxSelect, multi: false),
    const Provider(FnxBaseComponent, useExisting: FnxSelect, multi: false),
  ],
  preserveWhitespace: false,
  directives: [coreDirectives, formDirectives, AutoFocus, FnxDropdown, FnxText],
)
class FnxSelect extends FnxInputComponent implements ControlValueAccessor, OnInit, OnDestroy, Focusable {
  @HostBinding('class.item')
  @HostBinding('class.border')
  @HostBinding('class.embossed')
  static const bool hostIsItem = true;

  @Input()
  bool neverShowFilter = false;

  @Input()
  bool alwaysShowFilter = false;

  @Input()
  bool nullable = false;

  @Input()
  String maxHeight = "400px";

  @Input()
  String maxWidth = "400px";

  @Input()
  ValueDescriptionRenderer valueDescriptionRenderer;

  List<FnxOptionValue> options = [];

  @Input()
  String selectionEmptyLabel = fnxUiConfig.messages.input.selectionEmptyLabel;

  @Input()
  String optionsEmptyLabel = fnxUiConfig.messages.input.optionsEmptyLabel;

  @Input()
  String optionsEmptySearchLabel = fnxUiConfig.messages.input.optionsEmptySearchLabel;

  @Input()
  String filterPlaceholder = fnxUiConfig.messages.input.filterPlaceholder;

  bool open = false;

  bool get dropDownVisible => open && !isReadonly;

  bool _multi = false;

  FnxOptionValue _highlighted;

  String _filter = null;
  List<FnxOptionValue> _cachedFilteredOptions = null;

  @ContentChild(NgFormControl)
  NgFormControl state;

  StreamSubscription<String> navigationActionsSubscription;

  @ViewChild("select")
  HtmlElement select;

  HtmlElement host;

  FnxSelect(@SkipSelf() @Optional() FnxBaseComponent parent, this.host) : super(parent) {}

  void toggleDropdown() {
    markAsTouched();
    if (open) {
      if (!multi) {
        hideOptions();
      }
    } else {
      showOptions();
    }
  }

  void hideOptions() {
    open = false;
    filter = null;
  }

  void showOptions() {
    open = true;
  }

  bool get showFilter {
    if (neverShowFilter) return false;
    if (alwaysShowFilter) return true;
    if (options != null && options.length > 10) return true;
    return false;
  }

  @Input()
  set multi(bool flag) {
    if (flag) {
      if (value == null) {
        value = [];
      } else if (!(value is List)) {
        value = [value];
      }
    } else {
      if ((value is List) && (value as List).isNotEmpty) {
        value = value[0];
      }
    }
    _multi = flag;
  }

  bool get multi => _multi;

  bool isSelected(dynamic v) {
    if (value == null) return v == null;
    if (v == null) return false;
    if (value is List) {
      return (value as List).contains(v);
    } else {
      return value == v;
    }
  }

  bool isHighlighted(FnxOptionValue opt) {
    return _highlighted == opt;
  }

  /// returns label constructed from all selected option labels joined by ','
  /// in the order they were defined in the options collection
  ///
  /// Pluggable using valueDescriptionRenderer attribute.
  ///
  /// See [ValueDescriptionRenderer].
  ///
  String renderValueDescription() {
    if (valueDescriptionRenderer == null) {
      return _renderValueDescription();
    } else {
      return valueDescriptionRenderer();
    }
  }

  String _renderValueDescription() {
    List<FnxOptionValue> allSelected;
    if (value == null) {
      allSelected = [];
    } else if (value is List) {
      Set selected = new Set.from(value as List);
      allSelected = options.where((opt) {
        return selected.contains(opt.value);
      }).toList();
    } else {
      FnxOptionValue found = options.firstWhere((opt) {
        return opt.value == value;
      }, orElse: () => null);
      if (found != null) {
        allSelected = [found];
      } else {
        allSelected = [];
      }
    }
    if (allSelected.isEmpty) {
      return selectionEmptyLabel;
    } else {
      return allSelected.map((opt) => opt.label).join(', ');
    }
  }

  void selectOption(dynamic value) {
    doSelectOption(value);
  }

  void doSelectOption(dynamic value) {
    if (multi) {
      toggleSelectedOption(value);
    } else {
      if (this.value == value) {
        if (nullable) this.value = null;
      } else {
        this.value = value;
      }
      hideOptions();
    }
  }

  void toggleSelectedOption(dynamic v) {
    if (value == null) {
      value = [];
    } else if (!(value is List)) {
      value = [value];
    }

    var vl = (value as List);
    if (vl.contains(v)) {
      value.remove(v);
      notifyNgModel();
    } else {
      value.add(v);
      notifyNgModel();
    }
  }

  @Input()
  set filter(String f) {
    if (f != null) {
      f = f.toLowerCase();
    }
    _cachedFilteredOptions = null;
    _filter = f;
  }

  String get filter => _filter;

  List<FnxOptionValue> get filteredOptions {
    if (_filter != null) {
      if (_cachedFilteredOptions != null) return _cachedFilteredOptions;
      var result = options.where((option) {
        return option.label != null && option.label.toLowerCase().contains(filter);
      }).toList();
      _cachedFilteredOptions = result;
      return result;
    } else {
      return options;
    }
  }

  void bindKeyHandler() {
    Map<int, String> actions = {KeyCode.ENTER: 'SELECT', KeyCode.UP: 'UP', KeyCode.DOWN: 'DOWN'};
    Set<int> supportedKeys = new Set.from(actions.keys);

    var actionsStream = ui.keyDownEvents(host).where((event) => supportedKeys.contains(event.keyCode)).map((event) {
      event.preventDefault();
      if (dropDownVisible) {
        event.stopPropagation();
      }
      return event;
    }).map((event) => actions[event.keyCode]);

    navigationActionsSubscription = actionsStream.listen((var action) {
      if (action == 'UP') {
        if (dropDownVisible) {
          selectNext(_highlighted, filteredOptions.reversed);
        }
      } else if (action == 'DOWN') {
        if (!dropDownVisible) {
          showOptions();
        } else {
          selectNext(_highlighted, filteredOptions);
        }
      } else if (action == 'SELECT') {
        if (!dropDownVisible) {
          showOptions();
        } else {
          if (_highlighted != null) doSelectOption(_highlighted.value);
        }
      }
    });
  }

  void selectNext(FnxOptionValue current, Iterable<FnxOptionValue> options) {
    FnxOptionValue next = findNext(current, options);
    _highlighted = next;
  }

  FnxOptionValue findNext(FnxOptionValue current, Iterable<FnxOptionValue> all) {
    // we have nowhere to navigate
    if (all == null || all.isEmpty) return null;
    // current is empty, return first option
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
  ngOnInit() {
    super.ngOnInit();
    var self = this;
    bindKeyHandler();
  }

  @override
  ngOnDestroy() {
    super.ngOnDestroy();
    navigationActionsSubscription?.cancel();
    navigationActionsSubscription = null;
  }

  @override
  bool get hasValidValue {
    if (required) {
      if (value == null) return false;
      if (multi && (value is List) && (value as List).isEmpty) return false;
    }
    return true;
  }

  @override
  void focus() {
    select.focus();
  }
}

class FnxOptionValue {
  final String id;
  String label;
  dynamic value;

  FnxOptionValue(this.id, this.value, this.label);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is FnxOptionValue && this.value == other.value;
  }

  @override
  int get hashCode {
    return value.hashCode;
  }

  @override
  String toString() {
    return 'FnxOptionValue{id: $id, value: $value, label: $label}';
  }
}

@Component(
  selector: 'fnx-option',
  templateUrl: 'fnx_option.html',
  preserveWhitespace: false,
  styles: [":host {transition: none}"],
  directives: [
    coreDirectives,
    formDirectives,
  ],
)
class FnxOption implements OnInit, OnDestroy, AfterChanges {
  final String id = ui.generateId('o');

  @HostBinding('class.selected')
  bool get hasClassSelected => selected && !highlighted;

  @HostBinding('class.hover')
  bool get hasClassHighlighted => highlighted;

  @HostBinding('class.pointer')
  @HostBinding('class.hover:hover')
  static const bool hasClassPointer = true;

  FnxSelect parent;

  @Input()
  dynamic value;

  @Input()
  String label;

  FnxOption(this.parent);

  bool _visibilityCache = null;
  int _cacheHashCode = null;

  bool get highlighted => parent.isHighlighted(_myValue);

  @HostBinding('style.display')
  String get display => visible ? 'inline-block' : 'none';

  bool get visible {
    List<FnxOptionValue> opts = parent?.filteredOptions;
    if (opts == null) return false;
    if (opts.isEmpty) return false;
    if (parent.options.length == opts.length) return true;
    if (opts.hashCode == _cacheHashCode && _visibilityCache != null) return _visibilityCache;
    _cacheHashCode = opts.hashCode;
    _visibilityCache = opts.contains(_myValue);
    return _visibilityCache;
  }

  FnxOptionValue _myValue;

  @override
  ngOnInit() {
    _myValue = FnxOptionValue(id, value, label);
    parent.options.add(_myValue);
  }

  @override
  ngOnDestroy() {
    parent.options.remove(_myValue);
  }

  void optionSelected(Event event) {
    event?.preventDefault();
    event?.stopPropagation();
    parent?.selectOption(value);
  }

  bool get selected => parent != null && parent.isSelected(value);

  @override
  void ngAfterChanges() {
    if (_myValue != null) {
      _myValue.value = value;
      _myValue.label = label;
    }
  }
}
