// ignore_for_file: unused_element, unused_field, camel_case_types, annotate_overrides, prefer_single_quotes
// GENERATED FILE, do not edit!
import 'package:i69n/i69n.dart' as i69n;
import 'fnxUiMessages.i69n.dart';

String get _languageCode => 'cs';
String get _localeName => 'cs';

String _plural(int count,
        {String zero,
        String one,
        String two,
        String few,
        String many,
        String other}) =>
    i69n.plural(count, _languageCode,
        zero: zero, one: one, two: two, few: few, many: many, other: other);
String _ordinal(int count,
        {String zero,
        String one,
        String two,
        String few,
        String many,
        String other}) =>
    i69n.ordinal(count, _languageCode,
        zero: zero, one: one, two: two, few: few, many: many, other: other);
String _cardinal(int count,
        {String zero,
        String one,
        String two,
        String few,
        String many,
        String other}) =>
    i69n.cardinal(count, _languageCode,
        zero: zero, one: one, two: two, few: few, many: many, other: other);

class FnxUiMessages_cs extends FnxUiMessages {
  const FnxUiMessages_cs();
  ButtonFnxUiMessages_cs get button => ButtonFnxUiMessages_cs(this);
  InputFnxUiMessages_cs get input => InputFnxUiMessages_cs(this);
  AlertsFnxUiMessages_cs get alerts => AlertsFnxUiMessages_cs(this);
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'button':
        return button;
      case 'input':
        return input;
      case 'alerts':
        return alerts;
      default:
        return super[key];
    }
  }
}

class ButtonFnxUiMessages_cs extends ButtonFnxUiMessages {
  final FnxUiMessages_cs _parent;
  const ButtonFnxUiMessages_cs(this._parent) : super(_parent);
  String get ok => "OK";
  String get yes => "Ano";
  String get no => "Ne";
  String get cancel => "Zrušit";
  String get submit => "Odeslat";
  String get back => "Zpět";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'ok':
        return ok;
      case 'yes':
        return yes;
      case 'no':
        return no;
      case 'cancel':
        return cancel;
      case 'submit':
        return submit;
      case 'back':
        return back;
      default:
        return super[key];
    }
  }
}

class InputFnxUiMessages_cs extends InputFnxUiMessages {
  final FnxUiMessages_cs _parent;
  const InputFnxUiMessages_cs(this._parent) : super(_parent);
  String get notValid => "Hodnota není platná";
  String get browse => "Procházet";
  String _files(int cnt) =>
      "${_plural(cnt, zero: 'souborů', one: 'soubor', few: 'soubory', many: 'souborů')}";
  String filesSelected(int cnt) => "Vybráno $cnt ${_files(cnt)}";
  String dropFileHere(bool multi) =>
      "${multi ? 'Soubory' : 'Soubor'} můžete přetáhnout sem ...";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'notValid':
        return notValid;
      case 'browse':
        return browse;
      case '_files':
        return _files;
      case 'filesSelected':
        return filesSelected;
      case 'dropFileHere':
        return dropFileHere;
      default:
        return super[key];
    }
  }
}

class AlertsFnxUiMessages_cs extends AlertsFnxUiMessages {
  final FnxUiMessages_cs _parent;
  const AlertsFnxUiMessages_cs(this._parent) : super(_parent);
  String get alertHeadline => "Upozornění";
  String get confirmHeadline => "Potvrďte";
  String get inputHeadline => "Zadejte";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'alertHeadline':
        return alertHeadline;
      case 'confirmHeadline':
        return confirmHeadline;
      case 'inputHeadline':
        return inputHeadline;
      default:
        return super[key];
    }
  }
}
