import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/dropdown_tracker.dart';
import 'package:fnx_ui/api/mixins/modal_component.dart';
import 'package:fnx_ui/components/fnx_modal/fnx_modal.dart';

@Component(
  selector: 'fnx-dropdown',
  template: r'''
   <ng-content select="[master]"></ng-content>
   <div #dropdown *ngIf="visible??false"
     class="fixed anim-dropdown" 
     style="z-index: 1"    
   ><ng-content></ng-content></div>
''',
  preserveWhitespace: false,
  visibility: Visibility.all,
  directives: [
    coreDirectives,
    formDirectives,
  ],
)
class FnxDropdown
    implements
        OnInit,
        OnDestroy,
        AfterChanges,
        AfterViewChecked,
        ModalComponent {
  DropdownTracker tracker;

  Element host;

  @ViewChild("dropdown")
  Element dropdown;

  bool _visible = false;

  bool get visible => _visible;

  @Input()
  set visible(bool value) {
    if (_visible != value) {
      if (value) {
        FnxModal.addModalComponent(this);
      } else {
        FnxModal.removeModalComponent(this);
      }
    }
    _visible = value;
  }

  @Input()
  bool downOnly = false;

  final StreamController _hide = StreamController.broadcast();
  @Output()
  Stream get hide => _hide.stream;

  FnxDropdown(this.host);

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
          tracker.init(host, dropdown, () => _hide.add(true));
        }
      }
    }
    tracker?.updatePosition();
  }

  @override
  bool get canHide => true;

  @override
  void hideModalComponent() {
    _hide.add(true);
  }

  @override
  Element get modalElement => host;
}
