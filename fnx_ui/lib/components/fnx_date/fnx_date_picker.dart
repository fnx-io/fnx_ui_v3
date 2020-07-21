import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/components/fnx_int/fnx_int.dart';
import 'package:fnx_ui/api/date.dart';
import 'package:fnx_ui/api/ui.dart' as ui;
import 'package:intl/intl.dart';

@Component(
    selector: 'fnx-date-picker', templateUrl: 'fnx_date_picker.html', preserveWhitespace: false, directives: const [coreDirectives, formDirectives, FnxInt], styleUrls: const ['fnx_date_picker.css'])
class FnxDatePicker extends FnxBaseComponent implements OnInit, OnDestroy {
  @Input()
  bool dateTime = false;

  StreamController<DateTime> _picked = StreamController();

  List days;
  @Output()
  Stream<DateTime> get picked => _picked.stream;

  DateTime today = DateTime.now();

  DateTime _value;

  List<DateTime> _selected = [];

  bool hourFormat24 = false;

  @Input()
  set selected(List<DateTime> value) {
    _selected = value;
    if (_value == null && _selected != null && _selected.isNotEmpty) {
      _value = _selected.first;
      initPickerModel();
    }
  }

  /// Constructor used to create instance of Datepicker.
  FnxDatePicker(@SkipSelf() @Optional() FnxBaseComponent parent) : super(parent) {
    initPicker();
  }

  int get year => _value.year;
  int get month => _value.month;
  int get day => _value.day;

  int get hour => _value.hour;
  int get minute => _value.minute;

  String editingTime = null;

  String get timeToShow {
    if (editingTime != null) return editingTime;
    if (hourFormat24) {
      if (minute < 10) return "$hour:0$minute";
      return "$hour:$minute";
    } else {
      if (minute < 10) return "${hour24ToAmPm(hour)}:0$minute";
      return "${hour24ToAmPm(hour)}:$minute";
    }
  }

  /*
  void set timeToShow(String a) {
    if (_value == null) return;
    if (a == null) return;
    editingTime = a;
    try {
      List<String> p = a.trim().split(":");
      int h = int.tryParse(p[0]);
      int m = int.tryParse(p[1]);
      if (h == null) return;
      if (m == null) m = 0;
      valueInternal = DateTime(
        _value.year,
        _value.month,
        _value.day,
        h,
        m,
      );
      _datePicked.add(_value);
    } catch (e) {}
  }

   */

  AmPm get amPm => amOrPm(hour);

  void valueChanged() {
    initPicker();
  }

  initPicker() {
    if (_value == null) {
      _value = today;
    }
    initPickerModel();
  }

  initPickerModel() {
    DateTime ref = DateTime.utc(year, month, 1);
    List result = [];
    for (int a = 0; a < 6; a++) {
      result.add([]);
      for (int b = 0; b < 7; b++) {
        result[a].add(" ");
        if (ref.month == month) {
          if (ref.weekday - 1 == b) {
            result[a][b] = ref.day;
            ref = ref.add(Duration(days: 1));
          }
        }
      }
    }
    days = result;
  }

  bool isSelected(var year, var month, var day) {
    return _selected?.firstWhere((d) => d != null && d.year == year && d.month == month && d.day == day, orElse: () => null) != null;
  }

  bool isToday(var year, var month, var day) {
    return today.year == year && today.month == month && today.day == day;
  }

  bool isDay(dynamic day) => day is int;

  void pickDay(int year, int month, int day, Event e) {
    e.stopPropagation();
    e.preventDefault();
    if (dateTime) {
      _picked.add(DateTime(year, month, day, hour, minute));
    } else {
      _picked.add(DateTime(year, month, day));
    }
  }

  String formatNumber(int num) {
    if (num == null) return null;
    var formatter = NumberFormat('00');
    return formatter.format(num);
  }

  void incMinute() {
    addDurationToValue(Duration(minutes: 1));
  }

  void decMinute() {
    subtractDurationFromValue(Duration(minutes: 1));
  }

  void incHour() {
    addDurationToValue(Duration(hours: 1));
  }

  void decHour() {
    subtractDurationFromValue(Duration(hours: 1));
  }

  void incMonth() {
    changeValueMonth(1);
  }

  void decMonth() {
    changeValueMonth(-1);
  }

  void incYear() {
    changeValueMonth(12);
  }

  void decYear() {
    changeValueMonth(-12);
  }

  void showToday() {
    _value = DateTime.now();
    initPickerModel();
  }

  /*
  void showToday() {
    int h, m, s, ms = 0;
    bool utc = today.isUtc;
    if (value != null) {
      h = value.hour;
      m = value.minute;
      s = value.second;
      ms = value.millisecond;
      utc = value.isUtc;
    }
    valueInternal = dateFrom(today.year, today.month, today.day, h, m, s, ms, utc);
    _datePicked.add(value);
  }
   */

  void changeValueMonth(int by) {
    _value = DateTime(_value.year, _value.month + by, _value.day, _value.hour, _value.minute);
    initPickerModel();
  }

  void addDurationToValue(Duration dur) {
    _value = _value.add(dur);
    initPickerModel();
  }

  void subtractDurationFromValue(Duration dur) {
    _value = _value.subtract(dur);
    initPickerModel();
  }

  bool get isAm => AmPm.AM == amPm;
  bool get isPm => AmPm.PM == amPm;

  Function killEvent = ui.killEvent;

  /*
  void setPm() {
    var h = hour24ToAmPm(hour).hour;
    int convertedHour = hourAmPmTo24(AmPmHour(h, AmPm.PM));
    valueInternal = setHour(_value, convertedHour);
    _datePicked.add(_value);
  }

  void setAm() {
    var h = hour24ToAmPm(hour).hour;
    int convertedHour = hourAmPmTo24(AmPmHour(h, AmPm.AM));
    valueInternal = setHour(_value, convertedHour);
    _datePicked.add(_value);
  }

   */

  @override
  bool get hasValidValue => true;
}
