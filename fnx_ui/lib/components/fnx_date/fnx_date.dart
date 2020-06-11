import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/api/input_component.dart';
import 'package:fnx_ui/components/fnx_date/fnx_date_picker.dart';
import 'package:fnx_ui/components/fnx_dropdown/fnx_dropdown.dart';
import 'package:fnx_ui/directives/fnx_focus/fnx_focus.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/toolkit.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

@Component(
  selector: 'fnx-date',
  providers: const [
    Provider(Focusable, useExisting: FnxDate, multi: false),
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

  FnxDate(@SkipSelf() @Optional() FnxBaseComponent parent, this.host) : super(parent);

  String _rawValue = null;

  String get rawValue => _rawValue;

  @ViewChild("input")
  InputElement element;

  DateFormat get format => dateTime ? fnxUiConfig.dateTimeFormat : fnxUiConfig.dateFormat;

  List<DateTime> get valueAsList => value == null ? [] : [value];

  String valueToString(DateTime value) {
    if (value == null) return null;
    return format.format(value);
  }

  DateTime stringToValue(String rawValue) {
    if (rawValue == null) return null;
    try {
      return format.parseLoose(rawValue.trim());
    } catch (e) {
      return null;
    }
  }

  bool get hasFocus => document.activeElement == element;

  set rawValue(String v) {
    _rawValue = v;
    var parsed = stringToValue(v);
    super.value = parsed;
  }

  @Input()
  @mustCallSuper
  set value(DateTime v) {
    super.value = v;
    _rawValue = v == null ? null : valueToString(v);
  }

  @override
  void writeValue(obj) {
    super.writeValue(obj);
    if (obj == null) {
      _rawValue = null;
    } else {
      if (obj is DateTime) {
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

  void focusin() {
    reformat();
    pickerVisible = true;
    firstClickAbove(host).then((_) => pickerVisible = false);
  }

  void datePicked(DateTime v) {
    value = v;
    pickerVisible = false;
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

    if (valueToString(value) != rawValue) return false;

    return true;
  }
}
