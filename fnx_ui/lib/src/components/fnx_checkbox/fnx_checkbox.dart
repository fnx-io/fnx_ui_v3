import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/api/input_component.dart';
import 'package:fnx_ui/fnx_ui.dart';

@Component(
  selector: 'fnx-checkbox',
  templateUrl: 'fnx_checkbox.html',
  providers: [
    ExistingProvider.forToken(ngValueAccessor, FnxCheckbox),
    Provider(FnxBaseComponent, useExisting: FnxCheckbox),
  ],
  directives: [coreDirectives, formDirectives, fnxUiAllDirectives],
  preserveWhitespace: false,
)
class FnxCheckbox extends FnxInputComponent<bool> {
  @Input()
  String label;

  @HostBinding('class.item')
  bool get hostIsItem => label != null;

  @HostBinding('class.char')
  bool get hostIsChar => label == null;

  String get icon {
    return value == true ? "check_box_outline_blank" : "check_box";
  }

  FnxCheckbox(@SkipSelf() @Optional() FnxBaseComponent parent) : super(parent);

  @override
  bool get hasValidValue {
    if (required) {
      if (value == null) return false;
      if (value == false) return false;
    }
    return true;
  }
}
