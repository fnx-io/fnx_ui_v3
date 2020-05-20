import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_test_bed.dart';
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_test_case.dart';

@Component(
  selector: 'fnx-ui-docs-0240-dropdown',
  templateUrl: 'fnx_ui_docs_0240_dropdown.html',
  directives: [fnxUiAllDirectives, coreDirectives, formDirectives, FnxUiDocsTestBed, FnxUiDocsTestCase],
)
class FnxUiDocs0240Dropdown {
  bool visible = true;
}
