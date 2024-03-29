import 'dart:async';
import 'dart:html';

///
/// This element can request focus.
///

import 'package:angular/angular.dart';

///
/// This element can request focus.
///
abstract class Focusable {
  void focus();
}

@Directive(selector: "[autoFocus],[fnxAutofocus]")
class AutoFocus implements OnInit {
  HtmlElement element;
  Focusable focusable;

  @Input()
  dynamic autoFocus;

  AutoFocus(this.element, @Optional() this.focusable);

  @override
  ngOnInit() {
    doFocus();
    Future.delayed(Duration(milliseconds: 50)).then(doFocus);
  }

  void doFocus([_]) {
    if (autoFocus == false) return;
    if (focusable != null) {
      focusable.focus();
    } else {
      element.focus();
    }
  }
}
