import 'dart:async';

import 'package:angular/angular.dart';

import '../base_component.dart';

class BaseClosableComponent extends FnxBaseComponent {
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
      _close.add(true);
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

  StreamController<bool> _close = StreamController();
  @Output()
  Stream<bool> get close => _close.stream;

  BaseClosableComponent(FnxBaseComponent parent) : super(parent);

  @override
  bool get hasValidValue => true;
}
