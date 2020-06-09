import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:meta/meta.dart';

///
/// Ads support for "editable" components and ngModel binding.
///
abstract class FnxInputComponent<T> extends FnxBaseComponent implements OnInit, OnDestroy, ControlValueAccessor<T> {
  FnxInputComponent(FnxBaseComponent _parent) : super(_parent);

  @Input()
  String autocomplete = "on";

  @Input()
  String placeholder = null;

  T _value;

  T get value => _value;

  @mustCallSuper
  set value(T v) {
    if (v == '') v = null; // TODO: is it a good idea?
    if (v != _value) {
      _value = v;
      _valueChanged.add(v);
      notifyNgModel();
    }
  }

  final StreamController<T> _valueChanged = StreamController<T>();
  @Output()
  Stream<T> get valueChange => _valueChanged.stream;

  void notifyNgModel() {
    if (_onChange != null) {
      _onChange(_value);
    }
  }

  ChangeFunction<T> _onChange = (T t, {String rawValue}) {};
  TouchFunction _onTouched = () {};

  @override
  void registerOnChange(ChangeFunction<T> f) {
    _onChange = f;
  }

  @override
  void registerOnTouched(TouchFunction fn) {
    _onTouched = fn;
  }

  @override
  void onDisabledChanged(bool isDisabled) {
    disabled = isDisabled;
  }

  @override
  void writeValue(obj) {
    _value = obj;
  }
}
