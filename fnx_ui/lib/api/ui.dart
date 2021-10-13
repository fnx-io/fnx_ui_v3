import 'dart:async';
import 'dart:html';

import 'package:async/async.dart';

int _sequence = 1;

String generateId(String prefix) {
  return '$prefix${++_sequence}';
}

void consume(Event e) {
  e?.stopPropagation();
  e?.preventDefault();
}

Stream<KeyboardEvent> keyDownEvents([Node e]) => (e ?? document)
    .on['keydown']
    .where((event) => event is KeyboardEvent)
    .map((event) => event as KeyboardEvent);

StreamSubscription<Event> _resizeSubscription;

StreamController<Event> _resizeEvents =
    StreamController<Event>.broadcast(onListen: () {
  _resizeSubscription?.cancel();
  _resizeSubscription = StreamGroup.merge([
    window.onMouseWheel,
    window.onResize,
    window.onScroll,
    window.onMouseMove
  ]).listen((Event e) {
    _resizeEvents.add(e);
  });
}, onCancel: () {
  _resizeSubscription.cancel();
  _resizeSubscription = null;
});

Stream<Event> get resizeEvents => _resizeEvents.stream;

void killEvent(Event e) {
  e?.stopImmediatePropagation();
  e?.preventDefault();
}

Future<MouseEvent> firstClickAbove(Element e) {
  return document.onClick
      .where((clicked) =>
          (clicked.target is Element) &&
          !isAncestorOf(e, clicked.target as Element))
      .first;
}

bool isAncestorOf(Element ancestor, Element element) {
  if (ancestor == null) return false;
  if (element == null) return false;
  if (element == ancestor) return true;
  if (element == document.body) return false;
  return isAncestorOf(ancestor, element.parent);
}
