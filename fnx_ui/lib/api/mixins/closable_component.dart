import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

class ClosableComponent {
  bool _open = true;

  bool get open => _open ?? true;

  @Input()
  set open(bool value) {
    var _wasOpen = open;
    if (!closable) {
      _open = true;
      return;
    }
    _open = value ?? true;
    if (!open && _wasOpen) {
      emitClose();
    }
  }

  bool get closed => !open;

  @Input()
  set closed(bool value) {
    open = !(value ?? true);
  }

  bool _closable = true;

  bool get closable => _closable ?? true;

  @Input()
  set closable(bool value) {
    _closable = value;
    if (!closable && !open) {
      open = true;
    }
  }

  final StreamController<bool> _close = StreamController();
  @Output()
  Stream<bool> get close => _close.stream;

  void emitClose() {
    _close.add(true);
  }

  void toggleOpen(Event e) {
    e.stopImmediatePropagation();
    e.preventDefault();
    open = !open;
  }
}
