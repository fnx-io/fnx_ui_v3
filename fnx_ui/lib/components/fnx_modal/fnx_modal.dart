// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/mixins/closable_component.dart';
import 'package:fnx_ui/api/mixins/footer.dart';
import 'package:fnx_ui/api/mixins/header.dart';
import 'package:fnx_ui/api/ui.dart' as ui;

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
class FnxModal with ClosableComponent, Header, Footer implements OnInit, OnDestroy {
  static final List<Object> stack = [];

  String id = ui.generateId('modal');

  ///
  /// Optional CSS width of this modal window. Possibly 90vw etc.
  @Input()
  String width = "";

  StreamSubscription<KeyboardEvent> keyDownSubscription;

  @override
  ngOnInit() {
    stack.add(this);
    keyDownSubscription = ui.keyDownEvents.where((KeyboardEvent e) => e.keyCode == KeyCode.ESC).where((KeyboardEvent e) => this == stack.last).listen((KeyboardEvent e) {
      if (!closable) return;
      if (stack.isEmpty || stack.last == this) {
        ui.killEvent(e);
        emitClose();
      }
    });
  }

  @override
  ngOnDestroy() {
    keyDownSubscription.cancel();
    stack.remove(this);
  }
}
