import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_test_bed.dart';
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_test_case.dart';
import 'package:fnx_ui_doc/util.dart';

@Component(
  selector: 'fnx-ui-docs-0310-select',
  templateUrl: 'fnx_ui_docs_0310_select.html',
  directives: [
    fnxUiAllDirectives,
    coreDirectives,
    formDirectives,
    FnxUiDocsTestBed,
    FnxUiDocsTestCase
  ],
)
class FnxUiDocs0310Select {
  int value = 3;

  String valueLong;
  List<String> optionsLong = randomLongStrings;
}
