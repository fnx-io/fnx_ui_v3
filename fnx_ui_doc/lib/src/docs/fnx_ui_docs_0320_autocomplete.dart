import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/pair.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_test_bed.dart';
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_test_case.dart';

@Component(
  selector: 'fnx-ui-docs-0320-autocomplete',
  templateUrl: 'fnx_ui_docs_0320_autocomplete.html',
  directives: [fnxUiAllDirectives, coreDirectives, formDirectives, FnxUiDocsTestBed, FnxUiDocsTestCase],
)
class FnxUiDocs0320Autocomplete {
  int value;

  List<Pair<int>> allOptions = List.generate(100, (index) {
    var v = index * 17 + index ~/ 2;
    return Pair(v, v.toString());
  });

  Future<List<Pair<int>>> optionsProvider(String filledText) async {
    await Future.delayed(Duration(milliseconds: 300));
    if (filledText == null) return allOptions.take(20).toList();
    return allOptions.where((p) => p.label.contains(filledText)).take(20).toList();
  }

  Future<Pair<int>> defaultOptionProvider(dynamic value) async {
    await Future.delayed(Duration(milliseconds: 300));
    return allOptions.firstWhere((p) => p.value == value, orElse: () => null);
  }
}
