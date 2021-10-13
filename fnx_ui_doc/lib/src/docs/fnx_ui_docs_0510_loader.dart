import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';

import 'fnx_ui_docs_test_bed.dart';
import 'fnx_ui_docs_test_case.dart';

@Component(
  selector: 'fnx-ui-docs-0510-loader',
  templateUrl: 'fnx_ui_docs_0510_loader.html',
  directives: [
    fnxUiAllDirectives,
    coreDirectives,
    formDirectives,
    FnxUiDocsTestBed,
    FnxUiDocsTestCase
  ],
)
class FnxUiDocs0510Loader {}
