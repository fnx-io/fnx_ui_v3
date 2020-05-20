import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/dropdown_tracker.dart';

@Component(
  selector: 'fnx-dropdown',
  template: r'''
   <ng-content select="[master]"></ng-content>
   <div #dropdown *ngIf="visible??false"
     class="fixed" style="z-index: 1"    
   ><ng-content></ng-content></div>
''',
  preserveWhitespace: false,
  visibility: Visibility.all,
  directives: [
    coreDirectives,
    formDirectives,
  ],
)
class FnxDropdown implements OnInit, OnDestroy, AfterChanges, AfterViewChecked {
  DropdownTracker tracker;

  Element container;

  @ViewChild("dropdown")
  Element dropdown;

  @Input()
  bool visible = false;

  @Input()
  bool downOnly = false;

  StreamController _hide = new StreamController.broadcast();
  @Output()
  Stream get hide => _hide.stream;

  FnxDropdown(this.container);

  @override
  void ngAfterChanges() {
    updateState();
  }

  @override
  void ngOnDestroy() {
    tracker?.destroy();
    tracker = null;
  }

  @override
  void ngOnInit() {
    updateState();
  }

  @override
  void ngAfterViewChecked() {
    updateState();
  }

  void updateState() {
    if (!visible) {
      // should not be visible
      tracker?.destroy();
      tracker = null;
    } else {
      // should be visible
      if (tracker == null) {
        if (dropdown != null) {
          tracker = DropdownTracker(downOnly: downOnly);
          tracker.init(container, dropdown, () => _hide.add(true));
        }
      }
    }
    tracker?.updatePosition();
  }
}
