import 'dart:html';

void killEvent(Event e) {
  e?.stopImmediatePropagation();
  e?.preventDefault();
}

Future firstClickAbove(Element e) {
  return document.onClick.where((clicked) => (clicked.target is Element) && !isAncestorOf(e, clicked.target as Element)).first;
}

bool isAncestorOf(Element ancestor, Element element) {
  if (ancestor == null) return false;
  if (element == null) return false;
  if (element == ancestor) return true;
  if (element == document.body) return false;
  return isAncestorOf(ancestor, element.parent);
}
