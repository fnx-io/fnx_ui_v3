import 'package:angular/angular.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/api/input_component.dart';
import 'package:meta/meta.dart';

abstract class FnxTextInputComponent<T> extends FnxInputComponent<T> {
  FnxTextInputComponent(FnxBaseComponent parent) : super(parent);

  String _rawValue = null;

  String get rawValue => _rawValue;

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
    rawValue = valueToString(value);
  }

  String valueToString(T value);

  T stringToValue(String rawValue);
}
