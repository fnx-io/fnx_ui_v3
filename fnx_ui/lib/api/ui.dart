import 'dart:html';

import '../i69n/fnxUiMessages.i69n.dart';

int _sequence = 1;

String generateId(String prefix) {
  return '$prefix${++_sequence}';
}

void consume(Event e) {
  e?.stopPropagation();
  e?.preventDefault();
}
