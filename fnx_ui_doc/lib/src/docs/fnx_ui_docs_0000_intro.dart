import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';

import 'fnx_ui_docs_test_bed.dart';

@Component(
  selector: 'fnx-ui-docs-0000-intro',
  templateUrl: 'fnx_ui_docs_0000_intro.html',
  directives: [fnxUiAllDirectives, coreDirectives, formDirectives, FnxUiDocsTestBed],
)
class FnxUiDocs0000Intro {}
