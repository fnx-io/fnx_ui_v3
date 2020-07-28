import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/fnx_ui.dart';

@Component(
  selector: 'fnx-label',
  template: r'''
  <label *ngIf="label != null"
        class="bolder"        
         [attr.for]="childId"
         [class.required]="hasRequiredChildren"
         [class.text-error]="isTouchedAndInvalid"
         (click)="markAsTouched()" [innerHtml]="label"></label>
  <ng-content></ng-content>
  <label *ngIf="isTouchedAndInvalid" class="text-error margin-small-top" [attr.for]="childId">{{ errorMessage }}</label>
''',
  preserveWhitespace: false,
  visibility: Visibility.all,
  providers: [
    ExistingProvider(FnxBaseComponent, FnxLabel),
  ],
  directives: [
    coreDirectives,
    formDirectives,
  ],
)
class FnxLabel extends FnxBaseComponent implements OnInit, OnDestroy {
  FnxLabel(@SkipSelf() @Optional() FnxBaseComponent parent) : super(parent);

  @Input()
  String label;

  String _errorMessage;
  String get errorMessage => _errorMessage ?? fnxUiConfig.messages.input.notValid;

  @Input()
  set errorMessage(String value) {
    _errorMessage = value;
  }

  String get childId => child?.id;

  @override
  bool get hasValidValue => true;

  @HostBinding("class.flex-column")
  @HostBinding("class.margin-bottom")
  bool isVertical = true;

  @Input()
  bool horizontal = false;
}
