import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';

@Component(
  selector: 'fnx-ui-docs-test-case',
  template: """
  <div class='bg-white text-black padding border round debossed'>
  
    <template #content>
      <ng-content></ng-content>
    </template>
    
    <template [ngIf]='testCase==0'>
      <h4>Alone</h4>
      <ng-container *ngTemplateOutlet='content'></ng-container>
    </template>
    
    <template [ngIf]='testCase==1'>
      <h4>Inside a paragraph text</h4>
      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Autem, consequatur cum debitis dignissimos.
      <ng-container *ngTemplateOutlet='content'></ng-container>    
        Excepturi harum in iste modi molestiae necessitatibus odit placeat porro sequi soluta temporibus vel veniam voluptate, voluptatum.</p>        
    </template>  
    
    <template [ngIf]='testCase==2'>
      <ng-container *ngTemplateOutlet='content'></ng-container>
    </template>  
  
  </div>
  """,
  directives: [fnxUiAllDirectives, coreDirectives, formDirectives],
)
class FnxUiDocsTestCase {
  @Input()
  int testCase;
}
