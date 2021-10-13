import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';

@Component(
  selector: 'fnx-ui-docs-0090-colors',
  templateUrl: 'fnx_ui_docs_0090_colors.html',
  directives: [fnxUiAllDirectives, coreDirectives, formDirectives],
)
class FnxUiDocs0090Colors {
  List<String> colors = [
    'black',
    'white',
    'grey',
    'blue-grey',
    'fnx',
    'red',
    'pink',
    'purple',
    'deep-purple',
    'indigo',
    'blue',
    'light-blue',
    'cyan',
    'teal',
    'green',
    'light-green',
    'lime',
    'yellow',
    'amber',
    'orange',
    'deep-orange',
    'brown',
  ];

  final themeColors = [
    [
      'theme',
      'accent',
    ],
    [
      'hover',
      'selected',
    ]
  ];

  List<String> flavours = [
    ...List.generate(4, (i) => '-l${4 - i}'),
    '',
    ...List.generate(4, (i) => '-d${i + 1}')
  ];
}
