// ignore_for_file: unused_element, unused_field, camel_case_types, annotate_overrides, prefer_single_quotes
// GENERATED FILE, do not edit!
import 'package:i69n/i69n.dart' as i69n;

String get _languageCode => 'en';
String get _localeName => 'en';

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

class FnxUiMessages implements i69n.I69nMessageBundle {
  const FnxUiMessages();
  ButtonFnxUiMessages get button => ButtonFnxUiMessages(this);
  InputFnxUiMessages get input => InputFnxUiMessages(this);
  AlertsFnxUiMessages get alerts => AlertsFnxUiMessages(this);
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
        throw Exception('Message $key doesn\'t exist in $this');
    }
  }
}

class ButtonFnxUiMessages implements i69n.I69nMessageBundle {
  final FnxUiMessages _parent;
  const ButtonFnxUiMessages(this._parent);
  String get ok => "OK";
  String get yes => "Yes";
  String get no => "No";
  String get cancel => "Cancel";
  String get submit => "Submit";
  String get back => "Back";
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
        throw Exception('Message $key doesn\'t exist in $this');
    }
  }
}

class InputFnxUiMessages implements i69n.I69nMessageBundle {
  final FnxUiMessages _parent;
  const InputFnxUiMessages(this._parent);
  String get notValid => "Value is not valid";
  String get browse => "Browse";
  String _files(int cnt) =>
      "${_plural(cnt, zero: 'files', one: 'file', many: 'files')}";
  String filesSelected(int cnt) => "$cnt ${_files(cnt)} selected";
  String dropFileHere(bool multi) =>
      "Drag and drop ${multi ? 'files' : 'a file'} here ...";
  String get selectionEmptyLabel => "Please choose";
  String get optionsEmptyLabel => "No options";
  String get optionsEmptySearchLabel => "No options match yor search";
  String get filterPlaceholder => "Search ...";
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
      case 'selectionEmptyLabel':
        return selectionEmptyLabel;
      case 'optionsEmptyLabel':
        return optionsEmptyLabel;
      case 'optionsEmptySearchLabel':
        return optionsEmptySearchLabel;
      case 'filterPlaceholder':
        return filterPlaceholder;
      default:
        throw Exception('Message $key doesn\'t exist in $this');
    }
  }
}

class AlertsFnxUiMessages implements i69n.I69nMessageBundle {
  final FnxUiMessages _parent;
  const AlertsFnxUiMessages(this._parent);
  String get alertHeadline => "Alert";
  String get confirmHeadline => "Confirm";
  String get inputHeadline => "Input";
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
        throw Exception('Message $key doesn\'t exist in $this');
    }
  }
}
