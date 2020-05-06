import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';

@Component(
  selector: 'fnx-ui-docs-0300-checkbox',
  templateUrl: 'fnx_ui_docs_0300_checkbox.html',
  directives: [fnxUiAllDirectives, coreDirectives, formDirectives],
)
class FnxUiDocs0300Checkbox {
  bool checked = false;
}
