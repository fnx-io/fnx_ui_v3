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

Stream<KeyboardEvent> get keyDownEvents => document.on['keydown'].where((event) => event is KeyboardEvent).map((event) => event as KeyboardEvent);

StreamSubscription<Event> _resizeSubscription;

StreamController<Event> _resizeEvents = StreamController<Event>.broadcast(onListen: () {
  _resizeSubscription?.cancel();
  _resizeSubscription = StreamGroup.merge([window.onMouseWheel, window.onResize, window.onScroll, window.onMouseMove]).listen((Event e) {
    _resizeEvents.add(e);
  });
}, onCancel: () {
  _resizeSubscription.cancel();
  _resizeSubscription = null;
});

Stream<Event> get resizeEvents => _resizeEvents.stream;
