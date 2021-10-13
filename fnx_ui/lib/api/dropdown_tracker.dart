import 'dart:async';
import 'dart:html';

import 'package:fnx_ui/api/ui.dart';

class DropdownTracker {
  Element _container;
  Element _dropdown;
  Function _onHide;

  String dropdownHeight = "auto";
  bool downOnly;

  StreamSubscription<Event> subscription;

  DropdownTracker({this.downOnly: false}) {}

  void init(Element container, Element dropdown, Function onHide) {
    this._container = container;
    this._dropdown = dropdown;
    this._onHide = onHide;
    subscription = resizeEvents.listen(updatePosition);
    updatePosition();
  }

  void destroy() {
    this._container = null;
    subscription.cancel();
  }

  void updatePosition([_]) {
    num scrHeight = window.innerHeight;
    num dropdownH = _dropdown.getBoundingClientRect().height;

    Rectangle<num> _containerRect = _container.getBoundingClientRect();

    if (_containerRect.top < 0) {
      _onHide();
      return;
    }
    if (_containerRect.top > scrHeight) {
      _onHide();
      return;
    }
    String left = px(_containerRect.left);
    String top;

    if (downOnly ||
        dropdownH + _containerRect.top + _containerRect.height < scrHeight) {
      // vejde se dolu
      top = px(_containerRect.top + _containerRect.height);
    } else {
      if (_containerRect.top - dropdownH > 0) {
        // vejde se nahoru
        top = px(_containerRect.top - dropdownH);
      } else {
        top = px((scrHeight - dropdownH) / 2);
      }
    }
    if (_dropdown.style.left != left) {
      _dropdown.style.left = left;
    }
    if (_dropdown.style.top != top) {
      _dropdown.style.top = top;
    }
  }

  String px(num i) {
    return "${i.toStringAsFixed(2)}px";
  }
}
