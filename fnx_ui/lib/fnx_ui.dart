import 'package:fnx_ui/components/fnx_checkbox/fnx_checkbox.dart';
import 'package:fnx_ui/components/fnx_date/fnx_date.dart';
import 'package:fnx_ui/components/fnx_date/fnx_date_picker.dart';
import 'package:fnx_ui/components/fnx_double/fnx_double.dart';
import 'package:fnx_ui/components/fnx_dropdown/fnx_dropdown.dart';
import 'package:fnx_ui/components/fnx_dropdown_menu/fnx_dropdown_menu.dart';
import 'package:fnx_ui/components/fnx_formatted_number/fnx_formatted_number.dart';
import 'package:fnx_ui/components/fnx_int/fnx_int.dart';
import 'package:fnx_ui/components/fnx_label/fnx_label.dart';
import 'package:fnx_ui/components/fnx_text/fnx_text.dart';
import 'package:fnx_ui/components/fnx_tooltip/fnx_tooltip.dart';
import 'package:intl/intl.dart';

import 'i69n/fnxUiMessages.i69n.dart';

const fnxUiAllDirectives = [FnxTooltip, FnxCheckbox, FnxInt, FnxDouble, FnxFormattedNumber, FnxLabel, FnxDropdown, FnxDropdownMenu, FnxDatePicker, FnxDate, FnxText];

final Configuration fnxUiConfig = Configuration();

class Configuration {
  String locale = "en_US";
  FnxUiMessages messages = FnxUiMessages();
  DateFormat dateFormat = DateFormat("MM/dd/yyyy", "en_US");
  DateFormat dateTimeFormat = DateFormat("MM/dd/yyyy hh:mm a", "en_US");
}

setFnxUiToCzech() {
  fnxUiConfig.locale = "cs_CZ";
  fnxUiConfig.dateFormat = DateFormat("dd. MM. yyyy", "cs_CZ");
  fnxUiConfig.dateTimeFormat = DateFormat("dd. MM. yyyy HH:mm", "cs_CZ");
}
