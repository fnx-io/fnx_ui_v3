import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/api/input_component.dart';
import 'package:fnx_ui/src/directives/fnx_focus/fnx_focus.dart';

@Component(
  selector: 'fnx-int',
  templateUrl: 'fnx_int.html',
  providers: const [
    Provider(Focusable, useExisting: FnxInt, multi: false),
    ExistingProvider.forToken(ngValueAccessor, FnxInt),
    Provider(FnxBaseComponent, useExisting: FnxInt),
  ],
  styles: const [":host input { text-align: inherit;}"],
  preserveWhitespace: false,
  directives: [coreDirectives, formDirectives],
)
class FnxInt extends FnxInputComponent<int> implements OnInit, OnDestroy, Focusable {
  @Input()
  num min = null;

  @Input()
  num max = null;

  @Input()
  String placeholder = null;

  @HostBinding('class.item-input')
  bool get hostIsItem => true;

  @ViewChild("input")
  HtmlElement element;

  FnxInt(@SkipSelf() @Optional() FnxBaseComponent parent) : super(parent);

  String _rawValue;

  ///
  /// Is this a valid number within min/max limits?
  ///
  bool get hasValidValue {
    if (value == null) {
      if (required == true) return false;
      if (_rawValue != null) return false;
      return true;
    }

    if (value.toString() != _rawValue) return false;

    if (min == null && max == null) return true;
    if (min != null && value < min) return false;
    if (max != null && value > max) return false;
    return true;
  }

  static int parseInt(v) {
    if (v == null) return null;
    if (v is int) {
      return v;
    } else {
      return int.tryParse(v);
    }
  }

  @override
  void focus() {
    if (element != null) {
      element.focus();
    }
  }

  @override
  set value(dynamic v) {
    print("Setting value $v");
    _rawValue = (v?.toString() ?? null);
    super.value = parseInt(v);
    print("... value = $value");
  }
}
