import 'dart:html';

import 'package:angular/angular.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/api/input_component.dart';
import 'package:meta/meta.dart';

abstract class FnxBaseNumberInputComponent<T extends num> extends FnxInputComponent<T> {
  @Input()
  num min = null;

  @Input()
  num max = null;

  @HostBinding('class.item-input')
  @HostBinding('class.bg-white')
  final bool hostIsItem = true;

  FnxBaseNumberInputComponent(FnxBaseComponent parent) : super(parent);

  String _rawValue = null;

  String get rawValue => _rawValue;

  @ViewChild("input")
  InputElement element;

  String valueToString(T value);

  T stringToValue(String rawValue);

  bool get hasFocus => document.activeElement == element;

  set rawValue(String v) {
    _rawValue = v;
    var parsed = stringToValue(v);
    super.value = parsed;
  }

  @Input()
  @mustCallSuper
  set value(T v) {
    super.value = v;
    _rawValue = v == null ? null : valueToString(v);
  }

  @override
  void writeValue(obj) {
    super.writeValue(obj);
    if (obj == null) {
      _rawValue = null;
    } else {
      if (obj is T) {
        _rawValue = valueToString(obj);
      } else {
        _rawValue = obj?.toString();
      }
    }
  }

  void reformat() {
    if (hasValidValue) {
      rawValue = valueToString(value);
    }
  }

  @override
  void focus() {
    element?.focus();
  }

  ///
  /// Is this a valid number within min/max limits?
  ///
  bool get hasValidValue {
    if (value == null) {
      if (required == true) return false;

      if (rawValue == null) return true;

      if (rawValue.trim().isEmpty) return true;

      // there is something written here, but value is null
      return false;
    }

    if (min == null && max == null) return true;
    if (min != null && value < min) return false;
    if (max != null && value > max) return false;
    return true;
  }
}
