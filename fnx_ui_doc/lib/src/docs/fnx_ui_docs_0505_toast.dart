import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/components/fnx_app/fnx_app.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_test_bed.dart';
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_test_case.dart';

@Component(
  selector: 'fnx-ui-docs-0505-toast',
  templateUrl: 'fnx_ui_docs_0505_toast.html',
  directives: [fnxUiAllDirectives, coreDirectives, formDirectives, FnxUiDocsTestBed, FnxUiDocsTestCase],
)
class FnxUiDocs0505Toast {
  FnxApp app;

  FnxUiDocs0505Toast(this.app);

  void toast(String toast) {
    app.toast(toast, duration: Duration(seconds: 3));
  }
}
