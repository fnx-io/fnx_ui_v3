import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/api/text_input_component.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/directives/fnx_focus/fnx_focus.dart';
import 'package:intl/intl.dart';

@Component(
  selector: 'fnx-double',
  templateUrl: '../fnx_int/fnx_int.html',
  providers: const [
    Provider(Focusable, useExisting: FnxDouble, multi: false),
    ExistingProvider.forToken(ngValueAccessor, FnxDouble),
    Provider(FnxBaseComponent, useExisting: FnxDouble),
  ],
  preserveWhitespace: false,
  directives: [coreDirectives, formDirectives],
)
class FnxDouble extends FnxTextInputComponent<double> implements OnInit, OnDestroy, Focusable {
  @Input()
  num min = null;

  @Input()
  num max = null;

  String _format;

  NumberFormat _numberFormat;

  @Input()
  set format(String value) {
    _format = value;
    _numberFormat = NumberFormat(_format, fnxUiConfig.locale);
  }

  @Input()
  String placeholder = null;

  @HostBinding('class.item-input')
  bool get hostIsItem => true;

  @ViewChild("input")
  HtmlElement element;

  FnxDouble(@SkipSelf() @Optional() FnxBaseComponent parent) : super(parent) {
    format = "#,##0.00";
  }

  @override
  double stringToValue(String rawValue) {
    if (rawValue == null) return null;
    try {
      double tmp = _numberFormat.parse(rawValue).toDouble();
      // veletoc zajistujici, ze se hodnota orizne na pozadovany pocet desetinnych mist
      return _numberFormat.parse(_numberFormat.format(tmp)).toDouble();
    } catch (e) {
      return null;
    }
  }

  @override
  String valueToString(double value) {
    if (value == null) return null;
    return _numberFormat.format(value);
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
