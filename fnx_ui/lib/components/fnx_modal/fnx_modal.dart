// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/mixins/closable_component.dart';
import 'package:fnx_ui/api/mixins/footer.dart';
import 'package:fnx_ui/api/mixins/header.dart';
import 'package:fnx_ui/api/mixins/modal_component.dart';
import 'package:fnx_ui/api/ui.dart' as ui;
import 'package:logging/logging.dart';

typedef bool _KeyListener(KeyboardEvent e);

///
/// Basic empty modal window. Show it with *ngIf="something". Window emits
/// (close) event, use it to set something=false.
///
/// Window content is ".layout--header", which you can fill using attributes: header, main, footer. Like this:
///
///      <fnx-modal *ngIf="showMyModal" (close)="showMyModal = false">
///          <h1 header>Window header</h1>
///          <p main>Window content</p>
///          <p footer>Window footer</p>
///      </fnx-modal>
///
///
@Component(
  selector: 'fnx-modal',
  templateUrl: 'fnx_modal.html',
  styleUrls: ["fnx_modal.css"],
  preserveWhitespace: false,
  directives: [
    coreDirectives,
    formDirectives,
  ],
)
class FnxModal with ClosableComponent, Header, Footer implements OnInit, OnDestroy, ModalComponent {
  Element host;

  FnxModal(this.host);

  static final List<ModalComponent> _stack = [];

  static final Logger _log = Logger("FnxModal");

  String id = ui.generateId('modal');

  ///
  /// Optional CSS width of this modal window. Possibly 90vw etc.
  @Input()
  String width = "";

  ///
  /// Optional CSS width of this modal window.
  @Input()
  String maxWidth = "90vw";

  @override
  void hideModalComponent() {
    emitClose();
  }

  @override
  ngOnInit() {
    addModalComponent(this);
  }

  @override
  ngOnDestroy() {
    removeModalComponent(this);
  }

  static StreamSubscription<KeyboardEvent> keyDownSubscription;

  static void addModalComponent(ModalComponent component) {
    _log.info("Adding modal to stack $component");
    _stack.add(component);
    if (keyDownSubscription != null) return;
    keyDownSubscription = ui.keyDownEvents().where((KeyboardEvent e) => e.keyCode == KeyCode.ESC).listen((event) {
      _log.info("Incomming ESC");
      // ESC events on document
      if (_stack.isEmpty) return;
      var c = _stack.last;
      if (c.canHide) {
        ui.killEvent(event);
        _log.info("Hiding modal component $c");
        c.hideModalComponent();
      }
    });
    document.onClick.where((event) => event.target is Element).listen((event) {
      // click on document
      _log.info("Incomming click");
      if (_stack.isEmpty) return;
      _stack.forEach((c) {
        if (ui.isAncestorOf(c.modalElement, event.target as Element)) {
          // this is my click
        } else {
          if (c.canHide) {
            _log.info("Hiding modal component $c");
            c.hideModalComponent();
          }
        }
      });
    });
  }

  static void removeModalComponent(ModalComponent component) {
    _log.info("Removing modal from stack $component");
    _stack.remove(component);
  }

  @override
  bool get canHide => closable ?? true;

  @override
  Element get modalElement => host;
}
