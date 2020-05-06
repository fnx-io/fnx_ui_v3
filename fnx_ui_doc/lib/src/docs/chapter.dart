import 'dart:io';

/*
Chapter component generator. Place output to fnx_ui_docs.dart

USAGE:

dart chapter.dart 0020 Responsivity

 */
void main(List<String> args) {
  var number = args[0];
  var name = args[1];

  var filename = 'fnx_ui_docs_${number}_${name.toLowerCase()}';

  File('$filename.dart').writeAsStringSync("""import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'fnx_ui_docs_test_bed.dart';
import 'package:fnx_ui/fnx_ui.dart';

@Component(
  selector: 'fnx-ui-docs-$number-${name.toLowerCase()}',
  templateUrl: '${filename}.html',
  directives: [fnxUiAllDirectives, coreDirectives, formDirectives, FnxUiDocsTestBed],
)
class FnxUiDocs${number}${name} {}
  
  """, flush: true);
  File('$filename.html').writeAsStringSync('<h1>${name}</h1>', flush: true);

  print("import 'package:fnx_ui_doc/src/docs/${filename}.template.dart' as c${number};");
  print('');
  print("Chapter('${name}', c${number}.FnxUiDocs${number}${name}NgFactory),");
}
