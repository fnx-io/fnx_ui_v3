import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';

@Component(
  selector: 'fnx-ui-docs-test-bed',
  template: """

<div class='padding bg-white-d2 text-black border round shadow margin-big-top'>  
  <h3 class='margin-bottom'><span class='text-grey-d4'>Test cases for:</span>&nbsp;{{title}}</h3>
  
  <div class='row-gutter'>
    <ng-content></ng-content>
  </div>

</div>  
  
  """,
  directives: [fnxUiAllDirectives, coreDirectives, formDirectives],
)
class FnxUiDocsTestBed {
  @Input()
  String title;

  List<int> cases = [0, 1, 2, 3, 4, 10, 11, 12];

  String classFor(int c) {
    switch (c) {
      case 0:
        return "c12";
      case 1:
        return "c12";
      default:
        return "s:c12 c4";
    }
  }
}
