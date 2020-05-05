import '../i69n/fnxUiMessages.i69n.dart';

int _sequence = 1;

String generateId(String prefix) {
  return '$prefix${++_sequence}';
}

FnxUiMessages _messages = FnxUiMessages();

FnxUiMessages get messages => _messages;
