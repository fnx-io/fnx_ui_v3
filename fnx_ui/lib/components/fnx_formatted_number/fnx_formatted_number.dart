import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/api/base_number_input_component/base_number_input_component.dart';
import 'package:fnx_ui/directives/fnx_focus/fnx_focus.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:intl/intl.dart';

///
/// Uses https://pub.dev/documentation/intl/latest/intl/NumberFormat-class.html
///
///
@Component(
  selector: 'fnx-formatted-number',
  templateUrl:
      '../../api/base_number_input_component/base_number_input_component.html',
  providers: [
    Provider(Focusable, useExisting: FnxFormattedNumber),
    ExistingProvider.forToken(ngValueAccessor, FnxFormattedNumber),
    Provider(FnxBaseComponent, useExisting: FnxFormattedNumber),
  ],
  preserveWhitespace: false,
  directives: [coreDirectives, formDirectives],
)
class FnxFormattedNumber extends FnxBaseNumberInputComponent<double>
    implements OnInit, OnDestroy, Focusable {
  String _format;

  NumberFormat _numberFormat;

  @Input()
  set format(String value) {
    _format = value;
    _numberFormat = NumberFormat(_format, fnxUiConfig.locale);
  }

  FnxFormattedNumber(@SkipSelf() @Optional() FnxBaseComponent parent)
      : super(parent) {
    format = "#,##0.00";
  }

  @override
  double stringToValue(String rawValue) {
    print(rawValue);
    if (rawValue == null) return null;
    try {
      double tmp = _numberFormat.parse(rawValue).toDouble();
      print(tmp);
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
}
