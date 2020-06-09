
import 'dart:html';

void killEvent(Event e) {
  e?.stopImmediatePropagation();
  e?.preventDefault();
}
