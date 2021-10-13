import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/ui.dart' as ui;
import 'package:fnx_ui/components/fnx_form/fnx_form.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/i69n/fnxUiMessages.i69n.dart';

///
/// Standardized set of buttons at the bottom of the `fnx-form`. Renders submit button which is enabled only if the
/// form is valid (= all components in the form are valid).
///
/// Use `[back]="true"` to enable standard back button.
///
/// Add custom buttons like this:
///
///         <fnx-submit-bar [back]="true">
///             <button class="btn" type="button" (click)="doSt($event)">Special action</button>
///         </fnx-submit-bar>
///
/// BUT don't forget to prevent $event from bubbling in you doSt method, otherwise the form would be submitted as well.
///
/// Custom buttons are aligned to left (next to back button).
///
@Component(
  selector: 'fnx-submit-bar',
  template: r'''
<div class="item-row" [class.opacity--07]="isDisabled">
  <a *ngIf="back" href="#" class="btn " (click)="goBack($event)" [attr.data-prefix]="'arrow_back'">{{ goBackLabel }}</a>
  <ng-content></ng-content>
  <span class="spacer"></span>
  <span *ngIf="isDisabledByWork" class="loader"></span>
  <button type="submit" 
          (click)="onSubmit($event)"
          class="btn accent" 
          attr.data-prefix="{{ formValid ? 'check' : 'not_interested' }}" 
          [disabled]="isDisabled"          
          [class.disabled]="isDisabled">
    {{ label }}
  </button>
</div>
''',
  preserveWhitespace: false,
  styles: [":host {display: block;}"],
  directives: [
    coreDirectives,
    formDirectives,
  ],
)
class FnxSubmitBar implements DoCheck {
  FnxUiMessages get messages => fnxUiConfig.messages;

  ///
  /// Input - use it to change label on submit button.
  ///
  String _label;

  ///
  /// Input - use it to change label on back button.
  ///
  String _goBackLabel;

  String get label => _label ?? messages.button.submit;

  @Input()
  set label(String value) {
    _label = value;
  }

  String get goBackLabel => _goBackLabel ?? messages.button.back;

  @Input()
  set goBackLabel(String value) {
    _goBackLabel = value;
  }

  ///
  /// Input - Is back button allowed
  ///
  @Input()
  bool back = false;

  static const int _visualWorkingTimeoutMilis = 300;

  DateTime _lastSubmit;
  static const int _doubleClickPreventionMilis = 400;

  ///
  /// Tell the submit bar if the form/app is working, so it can
  /// disable itself.
  ///
  @Input()
  set working(bool value) {
    if (value == true) {
      _startedWorking ??= DateTime.now();
    } else {
      _startedWorking = null;
    }
    _checkWorkingStatus();
    Timer(Duration(milliseconds: _visualWorkingTimeoutMilis + 1),
        _checkWorkingStatus);
  }

  bool get isDisabled =>
      form?.disabled == true || form?.readonly == true || _longWorking;
  bool get isDisabledByWork =>
      !(form?.disabled == true || form?.readonly == true) && _longWorking;

  FnxForm get form => _form;

  final FnxForm _form;

  bool _checkedFormValid = true;

  FnxSubmitBar(@Optional() this._form) {
    if (_form == null) {
      throw new Exception(
          "To use fnx-submit-bar, please wrap your form into <fnx-form></fnx-form> component!");
    }
  }

  bool get formValid {
    return _checkedFormValid;
  }

  void goBack(Event event) {
    ui.killEvent(event);
    window.history.back();
  }

  @override
  void ngDoCheck() {
    _checkedFormValid = _form.isValid ?? true;
  }

  DateTime _startedWorking = null;
  bool _longWorking = false;

  void _checkWorkingStatus() {
    if (_startedWorking == null) {
      _longWorking = false;
    } else {
      if (_startedWorking
          .add(Duration(milliseconds: _visualWorkingTimeoutMilis))
          .isBefore(DateTime.now())) {
        // it's working for a long time!
        _longWorking = true;
      }
    }
  }

  void onSubmit(Event e) {
    if (_startedWorking != null) {
      ui.killEvent(e);
      return;
    }
    if (isDisabled) {
      ui.killEvent(e);
      return;
    }
    if (_lastSubmit != null &&
        _lastSubmit
            .add(Duration(milliseconds: _doubleClickPreventionMilis))
            .isAfter(DateTime.now())) {
      // too soon
      ui.killEvent(e);
      return;
    }
    _lastSubmit = DateTime.now();
  }
}
