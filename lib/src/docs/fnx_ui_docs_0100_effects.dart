import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../fnx_ui.dart';

@Component(
  selector: 'fnx-ui-docs-0100-effects',
  templateUrl: 'fnx_ui_docs_0100_effects.html',
  directives: [fnxUiAllDirectives, coreDirectives, formDirectives],
)
class FnxUiDocs0100Effects {
  List<String> shadows = ["", "-big", "-huge"];
}
