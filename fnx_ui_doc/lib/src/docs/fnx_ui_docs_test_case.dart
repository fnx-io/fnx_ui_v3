import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';

@Component(
  selector: 'fnx-ui-docs-test-case',
  template: """
  <div class='bg-white text-black padding border round debossed' style='overflow: hidden'>
  
    <template #content>
      <ng-content></ng-content>
    </template>
    
    <template [ngIf]='testCase==0'>
      <h4>Inside a text</h4>
      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Autem, consequatur cum debitis dignissimos.
      <ng-container *ngTemplateOutlet='content'></ng-container>    
        Excepturi harum in iste modi molestiae necessitatibus odit placeat porro sequi soluta temporibus vel veniam voluptate, voluptatum.</p>              
    </template>
    
    <template [ngIf]='testCase==1'>
      <h4>Inside an item-row</h4>
      <p class='item-row'>
        <span>Lorem</span>
        <button class='btn'>Ipsum</button>
        <ng-container *ngTemplateOutlet='content'></ng-container>
        <span>Lorem</span>
        <button class='btn'>Ipsum</button>    
      </p>        
    </template>  
    
    <template [ngIf]='testCase==2'>
      <h4>Inside an item-column</h4>
      <p class='item-column'>
        <span class='border-top border-bottom'>Lorem</span>
        <ng-container *ngTemplateOutlet='content'></ng-container>
        <span class='border-top border-bottom'>Lorem</span>
      </p>
    </template>
    
    <template [ngIf]='testCase==3'>
      <h4>Width 10em</h4>
      <div class='width10'>
        <ng-container *ngTemplateOutlet='content'></ng-container>
      </div>
    </template>     

    <template [ngIf]='testCase==4'>
      <h4>Width 100%</h4>
      <div class='width100'>
        <ng-container *ngTemplateOutlet='content'></ng-container>
      </div>
    </template>     
         
    
    <template [ngIf]='testCase==10'>
      <h4>Custom: --rem: 12px, --padding: 2px</h4>
      <div class='custom10'>
        <ng-container *ngTemplateOutlet='content'></ng-container>
      </div>
    </template>
    
    <template [ngIf]='testCase==11'>
      <h4>Custom: --rem: 20px, --padding: 10px</h4>
      <div class='custom11'>
        <ng-container *ngTemplateOutlet='content'></ng-container>
      </div>
    </template>          

    <template [ngIf]='testCase==12'>
      <h4>Custom:  --border-size: 2px, --border-radius: 10px </h4>
      <div class='custom12'>
        <ng-container *ngTemplateOutlet='content'></ng-container>
      </div>
    </template>          
          
  
  </div>
  """,
  styles: [
    ".width10 * { width: 10em; display: block; }",
    ".width100 * { width: 100%; display: block; }",
    ".width10 ::ng-deep > * { width: 10em; }",
    ".width100 ::ng-deep > * { width: 100%; }",
    ".custom10 { --rem: 12px; --padding: 2px }",
    ".custom11 { --rem: 20px; --padding: 10px }",
    ".custom12 { --border-size: 2px; --border-radius: 10px }",
  ],
  directives: [fnxUiAllDirectives, coreDirectives, formDirectives],
)
class FnxUiDocsTestCase {
  @Input()
  int testCase;
}
