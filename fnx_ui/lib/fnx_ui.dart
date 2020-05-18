import 'package:fnx_ui/components/fnx_checkbox/fnx_checkbox.dart';
import 'package:fnx_ui/components/fnx_double/fnx_double.dart';
import 'package:fnx_ui/components/fnx_formatted_number/fnx_formatted_number.dart';
import 'package:fnx_ui/components/fnx_int/fnx_int.dart';
import 'package:fnx_ui/components/fnx_label/fnx_label.dart';
import 'package:fnx_ui/components/fnx_tooltip/fnx_tooltip.dart';

import 'i69n/fnxUiMessages.i69n.dart';

const fnxUiAllDirectives = [FnxTooltip, FnxCheckbox, FnxInt, FnxDouble, FnxFormattedNumber, FnxLabel];

final Configuration fnxUiConfig = Configuration();

class Configuration {
  String locale = "en_US";
  FnxUiMessages messages = FnxUiMessages();
}
