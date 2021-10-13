import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/api/input_component.dart';
import 'package:fnx_ui/directives/fnx_focus/fnx_focus.dart';

// TODO: nenutit uzivatele psat http
@Component(
  selector: 'fnx-textarea',
  templateUrl: 'fnx_textarea.html',
  providers: [
    Provider(Focusable, useExisting: FnxTextarea),
    ExistingProvider.forToken(ngValueAccessor, FnxTextarea),
    Provider(FnxBaseComponent, useExisting: FnxTextarea),
  ],
  preserveWhitespace: false,
  directives: [coreDirectives, formDirectives],
)
class FnxTextarea extends FnxInputComponent<String> implements OnInit, OnDestroy, Focusable {
  @HostBinding('class.item-input')
  @HostBinding('class.bg-white')
  final bool hostIsItem = true;

  @ViewChild("input")
  TextAreaElement element;

  @Input()
  int minLength = null;

  @Input()
  int maxLength = null;

  FnxTextarea(@SkipSelf() @Optional() FnxBaseComponent parent) : super(parent);

  @override
  ngOnInit() {
    super.ngOnInit();
  }

  @override
  void focus() {
    element?.focus();
  }

  @override
  bool get hasValidValue {
    if (required && value == null) return false;
    if (required && value.trim().isEmpty == null) return false;
    if (value == null) return true;
    if (minLength == null && maxLength == null) return true;

    String v = (value is String) ? value : value.toString();

    if (required && v.length == 0) return false;
    if (minLength != null && v.length < minLength) return false;
    if (maxLength != null && v.length > maxLength) return false;

    return true;
  }
}
