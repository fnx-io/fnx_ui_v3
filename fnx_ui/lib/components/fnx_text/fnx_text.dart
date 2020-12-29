import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/api/input_component.dart';
import 'package:fnx_ui/directives/fnx_focus/fnx_focus.dart';

// TODO: nenutit uzivatele psat http
@Component(
  selector: 'fnx-text',
  templateUrl: 'fnx_text.html',
  providers: [
    Provider(Focusable, useExisting: FnxText, multi: false),
    ExistingProvider.forToken(ngValueAccessor, FnxText),
    Provider(FnxBaseComponent, useExisting: FnxText),
  ],
  preserveWhitespace: false,
  directives: [coreDirectives, formDirectives],
)
class FnxText extends FnxInputComponent<String> implements OnInit, OnDestroy, Focusable {
  @HostBinding('class.item-input')
  @HostBinding('class.bg-white')
  final bool hostIsItem = true;

  @ViewChild("input")
  InputElement element;

  @Input()
  int minLength = null;

  @Input()
  int maxLength = null;

  @Input()
  String type = 'text';

  FnxText(@SkipSelf() @Optional() FnxBaseComponent parent) : super(parent);

  String get htmlType {
    switch (type) {
      case 'password':
        return type;
      default:
        return 'text';
    }
  }

  static final RegExp _EMAIL_REGEXP = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  static final RegExp _HOST = RegExp(r"[a-zA-Z0-9.]+[a-zA-Z0-9]{2,}$");

  @override
  ngOnInit() {
    super.ngOnInit();
    assertType();
  }

  @override
  void focus() {
    element?.focus();
  }

  @override
  bool get hasValidValue {
    assertType();

    if (required && value == null) return false;
    if (required && value.trim().isEmpty == null) return false;
    if (value == null) return true;
    if (minLength == null && maxLength == null && type == "text") return true;
    String v = (value is String) ? value : value.toString();

    if (required && v.length == 0) return false;
    if (minLength != null && v.length < minLength) return false;
    if (maxLength != null && v.length > maxLength) return false;

    if (type == "http" || type == "web") {
      // TODO: this parsing might be expensive, we should cache results
      try {
        if (type == "web" && v != null) {
          if (v.startsWith("http:") || v.startsWith("https:") || v.startsWith("//")) {
            // ok
          } else {
            v = "//$v";
          }
        }

        Uri u = Uri.parse(v);
        print(u);
        print(u.host);
        String scheme = u.scheme.toLowerCase();
        if (type == "http") {
          if (scheme != "http" && scheme != "https") return false;
          if (u.host == null || u.host.isEmpty) return false;
        }
        if (type == "web") {
          if (u.host == null || u.host.isEmpty) return false;
          if (!u.host.contains(".")) return false;
          return _HOST.hasMatch(u.host);
        }
        return true;
      } catch (e) {
        return false;
      }
    }

    if (type == "email") {
      return _EMAIL_REGEXP.hasMatch(v);
    }
    return true;
  }

  void assertType() {
    if (type != "text" && type != "number" && type != "email" && type != "http" && type != "password" && type != "web") {
      throw "The only possible types at this moment are 'text', 'email', 'http', 'web' and 'password'";
    }
  }
}
