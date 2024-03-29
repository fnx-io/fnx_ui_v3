// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/errors.dart';
import 'package:fnx_ui/api/ui.dart' as ui;
import 'package:fnx_ui/components/fnx_form/fnx_form.dart';
import 'package:fnx_ui/components/fnx_label/fnx_label.dart';
import 'package:fnx_ui/components/fnx_modal/fnx_modal.dart';
import 'package:fnx_ui/components/fnx_text/fnx_text.dart';
import 'package:fnx_ui/components/fnx_tooltip/fnx_tooltip.dart';
import 'package:fnx_ui/directives/fnx_focus/fnx_focus.dart';
import 'package:fnx_ui/i69n/fnxUiMessages.i69n.dart';
import 'package:logging/logging.dart';

import '../../fnx_ui.dart';

///
/// Provides usefull methods for toast, simple 'alert' style dialogs, manages exceptions.
/// Wrap your whole app into this component and inject it into your components.
///
/// Demo: [http://demo.fnx.io/fnx_ui/ng2/#/Modals](http://demo.fnx.io/fnx_ui/ng2/#/Modals)
///
@Component(
  selector: 'fnx-app',
  templateUrl: 'fnx_app.html',
  preserveWhitespace: false,
  directives: [
    coreDirectives,
    formDirectives,
    FnxModal,
    FnxLabel,
    FnxText,
    FnxForm,
    AutoFocus,
    FnxTooltip
  ],
  visibility: Visibility.all,
)
class FnxApp implements OnInit {
  final Logger log = new Logger("FnxApp");

  Map<String, _ModalContent> modalWindows = {};
  List<_ToastContent> toasts = [];

  ChangeDetectorRef _changeDetector;

  FnxUiMessages get messages => fnxUiConfig.messages;

  FnxApp(@Optional() ExceptionHandler ex, this._changeDetector) {
    if (ex == null) {
      log.warning("There is no exception handler configured");
    }
    if (ex is! FnxExceptionHandler) {
      log.warning(
          "Configured exception handler is not FnxExceptionHandler, fnx_ui won't be able to show nice errors.\nConsider: provide(ExceptionHandler, useValue: new FnxExceptionHandler())");
    } else {
      (ex as FnxExceptionHandler).setShowErrorCallback(showError);
    }
  }

  ngOnInit() {
    log.fine("App started");
  }

  // TOASTS
  ///
  /// Shows simple 'flash message': 'User created', 'Record deleted', etc.
  ///
  void toast(String text,
      {Duration duration: const Duration(milliseconds: 4000),
      String cssClass: ""}) {
    _ToastContent t = new _ToastContent()
      ..cssClass = cssClass
      ..message = text;
    toasts.add(t);
    new Future.delayed(duration).then((_) {
      t.hide = true;
      _changeDetector.detectChanges();
    });
    new Future.delayed(duration + Duration(seconds: 1)).then((_) {
      if (toasts.firstWhere((_ToastContent t) => t.hide == false,
              orElse: () => null) ==
          null) {
        toasts.clear();
      }
    });
    _changeDetector.detectChanges();
  }

  // Exception handling

  FnxError errorToShow;

  void showError(FnxError error) {
    log.info("Showing error $error on UI");
    this.errorToShow = error;
    _changeDetector.detectChanges();
  }

  // MODAL WINDOWS
  ///
  /// Plain old window.alert style dialog. Nonblocking.
  ///
  Future alert(String message, {String headline: null}) {
    headline = headline ?? messages.alerts.alertHeadline;
    _ModalContent m = new _ModalContent()
      ..headline = headline
      ..message = message
      ..ok = messages.button.ok;
    return _modal(m);
  }

  ///
  /// Plain old window.confirm style dialog. Nonblocking.
  ///
  Future<bool> confirm(String message, {String headline: null}) {
    headline = headline ?? messages.alerts.confirmHeadline;
    _ModalContent m = new _ModalContent()
      ..headline = headline
      ..message = message
      ..ok = messages.button.yes
      ..cancel = messages.button.no;
    return _modal<bool>(m);
  }

  ///
  /// Plain old window.input style dialog. Nonblocking.
  ///
  Future<Object> input(String message,
      {String headline: null, String prefilledValue: null}) {
    headline = headline ?? messages.alerts.inputHeadline;
    _ModalContent m = new _ModalContent()
      ..headline = headline
      ..message = message
      ..input = "text"
      ..ok = messages.button.ok
      ..cancel = messages.button.cancel
      ..value = prefilledValue;
    return _modal(m);
  }

  Future<T> _modal<T>(_ModalContent mc) {
    Completer<T> c = new Completer<T>();
    mc._completer = c;
    modalWindows[mc.id] = mc;
    _changeDetector.detectChanges();
    return c.future;
  }

  void closeModal(String id, bool closingResult) {
    _ModalContent mc = modalWindows[id];
    if (mc == null) return;
    modalWindows.remove(id);

    if (mc.input != null) {
      // input mode
      if (closingResult) {
        // ok
        mc._completer.complete(mc.value);
      } else {
        // cancel
        mc._completer.complete(null);
      }
    } else {
      // common alert
      mc._completer.complete(closingResult);
    }
  }
}

class _ModalContent {
  String id = ui.generateId('modal');
  String headline;
  String message;
  String ok;
  String cancel;
  String input;
  var value;
  Completer _completer;
}

class _ToastContent {
  String message;
  bool hide = false;
  String cssClass = "";
}
