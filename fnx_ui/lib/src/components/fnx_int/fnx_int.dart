import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/api/text_input_component.dart';
import 'package:fnx_ui/src/directives/fnx_focus/fnx_focus.dart';

@Component(
  selector: 'fnx-int',
  templateUrl: 'fnx_int.html',
  providers: const [
    Provider(Focusable, useExisting: FnxInt, multi: false),
    ExistingProvider.forToken(ngValueAccessor, FnxInt),
    Provider(FnxBaseComponent, useExisting: FnxInt),
  ],
  preserveWhitespace: false,
  directives: [coreDirectives, formDirectives],
)
class FnxInt extends FnxTextInputComponent<int> implements OnInit, OnDestroy, Focusable {
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

  @override
  int stringToValue(String rawValue) {
    if (rawValue == null) return null;
    if (rawValue == null) return null;
    return int.tryParse(rawValue);
  }

  @override
  String valueToString(int value) {
    if (value == null) return null;
    return value.toString();
  }

  ///
  /// Is this a valid number within min/max limits?
  ///
  bool get hasValidValue {
    if (value == null) {
      if (required == true) return false;
      // nothing is written in the input
      if (rawValue == null) return true;
      if (rawValue.trim().isEmpty) return true;
      return true;
    }

    if (valueToString(value) != rawValue) return false;

    if (min == null && max == null) return true;
    if (min != null && value < min) return false;
    if (max != null && value > max) return false;
    return true;
  }

  @override
  void focus() {
    if (element != null) {
      element.focus();
    }
  }
}
