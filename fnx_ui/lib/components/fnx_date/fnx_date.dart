import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/api/input_component.dart';
import 'package:fnx_ui/api/ui.dart' as ui;
import 'package:fnx_ui/components/fnx_date/fnx_date_picker.dart';
import 'package:fnx_ui/components/fnx_dropdown/fnx_dropdown.dart';
import 'package:fnx_ui/directives/fnx_focus/fnx_focus.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:intl/intl.dart';

@Component(
  selector: 'fnx-date',
  providers: [
    Provider(Focusable, useExisting: FnxDate),
    ExistingProvider.forToken(ngValueAccessor, FnxDate),
    Provider(FnxBaseComponent, useExisting: FnxDate),
  ],
  directives: [coreDirectives, formDirectives, FnxDatePicker, FnxDropdown],
  templateUrl: 'fnx_date.html',
  preserveWhitespace: false,
)
class FnxDate extends FnxInputComponent<DateTime> {
  @Input()
  bool future = false;

  @Input()
  bool past = false;

  @Input()
  bool dateTime = false;

  bool get hasPrefix => host.dataset["prefix"] != null;

  @HostBinding('class.item-input')
  @HostBinding('class.bg-white')
  final bool hostIsItem = true;

  bool pickerVisible = false;

  Element host;

  FnxDate(@SkipSelf() @Optional() FnxBaseComponent parent, this.host) : super(parent) {
    //print("KOKOKOK");
  }

  String _rawValue = null;

  String get rawValue => _rawValue;

  @ViewChild("input")
  InputElement element;

  DateFormat get format => dateTime ? fnxUiConfig.dateTimeFormat : fnxUiConfig.dateFormat;

  List<DateTime> get valueAsList => (value == null) ? [] : [value];

  String _valueToString(DateTime value) {
    //print("Value to string $value");
    if (value == null) return null;
    return format.format(value.toLocal());
  }

  DateTime stringToValue(String rawValue) {
    if (rawValue == null) return null;
    //print("Parse: $rawValue");
    try {
      var d = format.parseLoose(rawValue.trim().replaceAll("  ", " ").replaceAll(". ", "."))?.toLocal();
      //print("result = $d");
      return d;
    } catch (e) {
      return null;
    }
  }

  bool get hasFocus => document.activeElement == element;

  set rawValue(String v) {
    //print("Setting rawValue = $v");
    _rawValue = v;
    var parsed = stringToValue(v);
    super.value = parsed;
  }

  @Input()
  set value(DateTime v) {
    //print("Setting value $v");
    super.value = v;
    _rawValue = v == null ? null : _valueToString(v);
  }

  @override
  void writeValue(Object obj) {
    //print("Write value $obj");
    super.writeValue(_toDate(obj));
    if (value == null) {
      _rawValue = null;
    } else {
      _rawValue = _valueToString(value);
    }
  }

  DateTime _toDate(Object obj) {
    //print("ToDate $obj");
    if (obj == null) return null;
    if (obj is DateTime) return obj.toLocal();
    return DateTime.parse(obj.toString()).toLocal();
  }

  void reformat() {
    //print("REformat $value");
    if (hasValidValue) {
      rawValue = _valueToString(value);
    }
  }

  @override
  void focus() {
    element?.focus();
  }

  void focusin() {
    reformat();
  }

  void datePicked(DateTime v) {
    //print("Date picked: $v");
    value = v;
    pickerVisible = false;
  }

  void clickOnIcon() {
    if (pickerVisible) {
      pickerVisible = false;
    } else {
      pickerVisible = true;
      ui.firstClickAbove(host).then((_) => pickerVisible = false);
    }
  }

  ///
  /// Is this a valid number within min/max limits?
  ///
  @override
  bool get hasValidValue {
    //print("VAlid ? $value");
    if (value == null) {
      if (required == true) return false;

      if (rawValue == null) return true;

      if (rawValue.trim().isEmpty) return true;

      // there is something written here, but value is null
      return false;
    }

    if (_valueToString(value) != rawValue) return false;

    return true;
  }
}
