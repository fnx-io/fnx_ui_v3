import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/fnx_ui.dart';

@Component(
  selector: 'fnx-dropdown-menu',
  template: r'''
  <fnx-dropdown [visible]="visible" (hide)="visible = false" class="item" [class.padding-none-left]="hasPrefix">
    <label [innerHtml]="label" master></label>
    <div class="body border shadow">    
      <ng-content></ng-content>
    </div>
  </fnx-dropdown>      
''',
  preserveWhitespace: false,
  visibility: Visibility.all,
  providers: [
    ExistingProvider(FnxBaseComponent, FnxDropdownMenu),
  ],
  directives: [
    coreDirectives,
    formDirectives,
    fnxUiAllDirectives,
  ],
)
class FnxDropdownMenu extends FnxBaseComponent implements OnInit, OnDestroy {
  Element host;

  FnxDropdownMenu(@SkipSelf() @Optional() FnxBaseComponent parent, this.host) : super(parent);

  bool visible = false;

  bool get hasPrefix => host.dataset["prefix"] != null;

  @Input()
  String label;

  @override
  bool get hasValidValue => true;

  @HostBinding('class.item')
  @HostBinding('class.no-padding')
  bool get hostIsItem => true;

  @HostListener("mouseover")
  void mouseIn() => visible = true;

  @HostListener("mouseleave")
  void mouseOut() => visible = false;
}
