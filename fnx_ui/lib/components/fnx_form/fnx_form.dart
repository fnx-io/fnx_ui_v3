// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/api/ui.dart' as ui;
import 'package:logging/logging.dart';

typedef FutureOr<String> FormValidatorFunction();

@Component(
    selector: 'fnx-form',
    templateUrl: 'fnx_form.html',
    providers: [
      Provider(FnxBaseComponent, useExisting: FnxForm, multi: false),
    ],
    visibility: Visibility.all)
class FnxForm extends FnxBaseComponent {
  final Logger log = new Logger("FnxForm");

  FnxForm(@SkipSelf() @Optional() FnxBaseComponent parent) : super(parent);

  final StreamController<Event> _submit = StreamController();
  @Output()
  Stream<Event> get submit => _submit.stream;

  final StreamController<BeforeFormSubmitEvent> _beforeSubmit = StreamController();
  @Output()
  Stream<BeforeFormSubmitEvent> get beforeSubmit => _beforeSubmit.stream;

  List<FormValidatorFunction> _validators = [];

  List<String> errorMessages = [];

  /// Handles submitting the underlying form event.
  /// Only propagates the submit event when this form is valid.
  /// Forces validation of all components inside this form.
  void submitForm(Event event) async {
    _beforeSubmit.add(BeforeFormSubmitEvent());
    ui.killEvent(event);
    if (disabled) return;

    markAsTouched();
    errorMessages = [];

    for (FormValidatorFunction f in _validators) {
      String error = await f();
      if (error != null) {
        errorMessages.add(error);
      }
    }

    if (isValid && errorMessages.isEmpty) {
      _submit.add(Event("submit"));
    } else {
      // there are some complex validation errors
    }
  }

  void addValidator(FormValidatorFunction f) {
    _validators.add(f);
  }

  void removeValidator(FormValidatorFunction f) {
    _validators.remove(f);
  }

  @override
  bool get hasValidValue => true;
}

class BeforeFormSubmitEvent {}
