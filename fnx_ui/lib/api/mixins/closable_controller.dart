import 'dart:async';

///
/// Use this class to control modals, panel and other ClosableComponents:
///
///
///
///
///
///
///
class ClosableController {
  Completer _dialogFuture;

  bool _isOpen = false;

  bool get isOpen => _isOpen;

  Future open() {
    if (!_isOpen) {
      _isOpen = true;
      _dialogFuture = Completer();
    }
    return _dialogFuture.future;
  }

  void close() {
    if (_isOpen) {
      _dialogFuture.complete();
      _dialogFuture = null;
      _isOpen = false;
    }
  }
}
