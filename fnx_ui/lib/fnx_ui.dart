import 'package:fnx_ui/src/components/fnx_checkbox/fnx_checkbox.dart';
import 'package:fnx_ui/src/components/fnx_double/fnx_double.dart';
import 'package:fnx_ui/src/components/fnx_int/fnx_int.dart';
import 'package:fnx_ui/src/components/fnx_tooltip/fnx_tooltip.dart';

const fnxUiAllDirectives = [FnxTooltip, FnxCheckbox, FnxInt, FnxDouble];

final Configuration fnxUiConfig = Configuration();

class Configuration {
  String locale = "en_US";
}
