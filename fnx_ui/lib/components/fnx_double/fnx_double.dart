import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/api/base_number_input_component/base_number_input_component.dart';
import 'package:fnx_ui/directives/fnx_focus/fnx_focus.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:intl/intl.dart';

@Component(
  selector: 'fnx-double',
  templateUrl: '../../api/base_number_input_component/base_number_input_component.html',
  providers: [
    ExistingProvider(Focusable, FnxDouble),
    ExistingProvider(FnxBaseComponent, FnxDouble),
    ExistingProvider.forToken(ngValueAccessor, FnxDouble),
  ],
  preserveWhitespace: false,
  directives: [coreDirectives, formDirectives],
)
class FnxDouble extends FnxBaseNumberInputComponent<double> implements OnInit, OnDestroy, Focusable {
  int _decimalPlaces;

  NumberFormat _printFormat;
  NumberFormat _editFormat;

  @Input()
  set decimalPlaces(int value) {
    _decimalPlaces = value;
    if (_decimalPlaces <= 0) {
      _printFormat = NumberFormat("#,##0", fnxUiConfig.locale);
      _editFormat = NumberFormat("0", fnxUiConfig.locale);
    } else {
      _printFormat = NumberFormat("#,##0.${'0' * _decimalPlaces}", fnxUiConfig.locale);
      _editFormat = NumberFormat("0.${'0' * _decimalPlaces}", fnxUiConfig.locale);
    }
  }

  FnxDouble(@SkipSelf() @Optional() FnxBaseComponent parent) : super(parent) {
    decimalPlaces = 2;
  }

  NumberFormat get _activeFormat => hasFocus ? _editFormat : _printFormat;

  @override
  double stringToValue(String rawValue) {
    if (rawValue == null) return null;
    try {
      double tmp = _activeFormat.parse(rawValue).toDouble();
      // veletoc zajistujici, ze se hodnota orizne na pozadovany pocet desetinnych mist
      return _activeFormat.parse(_activeFormat.format(tmp)).toDouble();
    } catch (e) {
      return null;
    }
  }

  @override
  String valueToString(double value) {
    if (value == null) return null;
    return _activeFormat.format(value);
  }
}
