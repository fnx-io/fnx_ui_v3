import 'dart:html';

abstract class ModalComponent {
  Element get modalElement;

  void hideModalComponent();

  bool get canHide;
}
