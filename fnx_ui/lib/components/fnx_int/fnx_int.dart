import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/api/base_number_input_component/base_number_input_component.dart';
import 'package:fnx_ui/directives/fnx_focus/fnx_focus.dart';

@Component(
  selector: 'fnx-int',
  templateUrl: '../../api/base_number_input_component/base_number_input_component.html',
  providers: const [
    Provider(Focusable, useExisting: FnxInt, multi: false),
    ExistingProvider.forToken(ngValueAccessor, FnxInt),
    Provider(FnxBaseComponent, useExisting: FnxInt),
  ],
  preserveWhitespace: false,
  directives: [coreDirectives, formDirectives],
)
class FnxInt extends FnxBaseNumberInputComponent<int> implements OnInit, OnDestroy, Focusable {
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
}
