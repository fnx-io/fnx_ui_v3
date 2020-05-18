import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_test_bed.dart';
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_test_case.dart';

@Component(
  selector: 'fnx-ui-docs-0250-label',
  templateUrl: 'fnx_ui_docs_0250_label.html',
  directives: [fnxUiAllDirectives, coreDirectives, formDirectives, FnxUiDocsTestBed, FnxUiDocsTestCase],
)
class FnxUiDocs0250Label {
  int value = 42;
}
