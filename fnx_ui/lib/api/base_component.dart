import 'package:angular/angular.dart';
import 'package:fnx_ui/api/ui.dart' as ui;
import 'package:meta/meta.dart';

///
/// Base class for all components which support validation (extend or mix-in).
///
abstract class FnxBaseComponent implements OnInit, OnDestroy {
  bool _touched = false;

  final String _fallbackId = ui.generateId('comp');

  String _id;

  bool _required = false;

  bool _readonly = false;

  bool _disabled = false;

  int _tabindex = null;

  String get id => _id ?? _fallbackId;

  @nonVirtual
  @Input()
  set id(String value) {
    _id = value;
  }

  bool get required => _required;

  @nonVirtual
  @Input()
  set required(bool value) {
    _required = value;
  }

  bool get readonly => _readonly;

  @nonVirtual
  @Input()
  set readonly(bool value) {
    _readonly = value;
  }

  bool get disabled => _disabled;

  @nonVirtual
  @Input()
  set disabled(bool value) {
    _disabled = value;
  }

  @Input()
  set tabindex(int value) {
    _tabindex = value;
  }

  int get tabindex {
    return _tabindex ?? ((isReadonly || isDisabled) ? -1 : 0);
  }

  final List<FnxBaseComponent> _validatorChildren = [];

  final FnxBaseComponent _parent;
  FnxBaseComponent get parent => _parent;
  FnxBaseComponent(@SkipSelf() @Optional() this._parent);

  @override
  void ngOnInit() {
    _parent?.registerChild(this);
  }

  @override
  void ngOnDestroy() {
    _parent?.deregisterChild(this);
  }

  ///
  /// User interacted with this component.
  ///
  void markAsTouched() {
    if (isReadonly) return;
    _touched = true;
    _validatorChildren.forEach((FnxBaseComponent c) => c.markAsTouched());
  }

  ///
  /// Remove user interaction flag.
  ///
  void markAsNotTouched() {
    if (isReadonly) return;
    _touched = false;
    _validatorChildren.forEach((FnxBaseComponent c) => c.markAsNotTouched());
  }

  ///
  /// Component is valid, if it is valid itself (hasValidValue) and has valid children (recursively).
  ///
  bool get isValid {
    return hasValidValue && hasValidChildren;
  }

  ///
  /// Component is invalid, and also was in interaction with the user,
  /// someone (fnx-input) should display an error message.
  ///
  @HostBinding("class.error")
  bool get isTouchedAndInvalid {
    return isTouched && !isValid;
  }

  ///
  /// Component is considered touched, when it's touched itself, or some of
  /// it's children is touched (recursively).
  ///
  bool get isTouched {
    if (_touched) return true;
    if (_validatorChildren.isEmpty) return false;
    return _validatorChildren.any((val) => val.isTouched);
  }

  ///
  /// Implement this function.
  ///
  bool get hasValidValue;

  bool get hasValidChildren {
    if (_validatorChildren.isEmpty) return true;
    return _validatorChildren.firstWhere((val) => !val.isValid, orElse: () => null) == null;
  }

  bool get hasRequiredChildren {
    if (_validatorChildren.isEmpty) return false;
    return _validatorChildren.firstWhere((val) => val.required, orElse: () => null) != null;
  }

  @HostBinding("class.readonly")
  bool get isReadonly => (readonly ?? false) || (_parent?.isReadonly ?? false);

  @HostBinding("class.disabled")
  bool get isDisabled => (disabled ?? false) || (_parent?.isDisabled ?? false);

  /// This component has some children, which should be part of this component
  /// validation (i.e. fnx-form has a lot of children, fnx-input has typicaly one)
  void registerChild(FnxBaseComponent child) {
    if (!_validatorChildren.contains(child)) {
      _validatorChildren.add(child);
      if (_touched) {
        child.markAsTouched();
      }
    }
  }

  ///
  /// Remove children.
  ///
  void deregisterChild(FnxBaseComponent child) {
    child.markAsNotTouched();
    _validatorChildren.remove(child);
  }
}
