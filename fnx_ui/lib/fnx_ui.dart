import 'package:fnx_ui/components/fnx_app/fnx_app.dart';
import 'package:fnx_ui/components/fnx_autocomplete/fnx_autocomplete.dart';
import 'package:fnx_ui/components/fnx_checkbox/fnx_checkbox.dart';
import 'package:fnx_ui/components/fnx_date/fnx_date.dart';
import 'package:fnx_ui/components/fnx_date/fnx_date_picker.dart';
import 'package:fnx_ui/components/fnx_double/fnx_double.dart';
import 'package:fnx_ui/components/fnx_dropdown/fnx_dropdown.dart';
import 'package:fnx_ui/components/fnx_dropdown_menu/fnx_dropdown_menu.dart';
import 'package:fnx_ui/components/fnx_formatted_number/fnx_formatted_number.dart';
import 'package:fnx_ui/components/fnx_int/fnx_int.dart';
import 'package:fnx_ui/components/fnx_label/fnx_label.dart';
import 'package:fnx_ui/components/fnx_modal/fnx_modal.dart';
import 'package:fnx_ui/components/fnx_panel/fnx_panel.dart';
import 'package:fnx_ui/components/fnx_panel_small/fnx_panel_small.dart';
import 'package:fnx_ui/components/fnx_scroll_panel/fnx_scroll_panel.dart';
import 'package:fnx_ui/components/fnx_text/fnx_text.dart';
import 'package:fnx_ui/components/fnx_tooltip/fnx_tooltip.dart';
import 'package:fnx_ui/i69n/fnxUiMessages.i69n.dart';
import 'package:intl/intl.dart';

import 'components/fnx_file/fnx_file.dart';
import 'components/fnx_form/fnx_form.dart';
import 'components/fnx_image_crop/fnx_image_crop.dart';
import 'components/fnx_select/fnx_select.dart';
import 'components/fnx_submit_bar/fnx_submit_bar.dart';
import 'components/fnx_textarea/fnx_textarea.dart';
import 'i69n/fnxUiMessages_cs.i69n.dart';

const fnxUiAllDirectives = [
  FnxApp,
  FnxTooltip,
  FnxCheckbox,
  FnxInt,
  FnxDouble,
  FnxFormattedNumber,
  FnxLabel,
  FnxForm,
  FnxDropdown,
  FnxDropdownMenu,
  FnxDatePicker,
  FnxDate,
  FnxText,
  FnxSelect,
  FnxOption,
  FnxSubmitBar,
  FnxTextarea,
  FnxFile,
  FnxModal,
  FnxPanel,
  FnxPanelSmall,
  FnxScrollPanel,
  FnxAutocomplete,
  FnxImageCrop
];

@Deprecated("Use fnxUiAllDirectives instead")
const fnxUiDirectives = fnxUiAllDirectives;

final Configuration fnxUiConfig = Configuration();

class Configuration {
  String locale = "en_US";
  FnxUiMessages messages = FnxUiMessages();
  DateFormat dateFormat = DateFormat("M/d/yyyy", "en_US");
  DateFormat dateTimeFormat = DateFormat("M/d/yyyy hh:mm a", "en_US");
}

setFnxUiToCzech() {
  fnxUiConfig.locale = "cs_CZ";
  fnxUiConfig.dateFormat = DateFormat("d.M.yyyy", "cs_CZ");
  fnxUiConfig.dateTimeFormat = DateFormat("d.M.yyyy HH:mm", "cs_CZ");
  fnxUiConfig.messages = FnxUiMessages_cs();
}

setFnxUiToEnglish() {
  fnxUiConfig.locale = "en_US";
  fnxUiConfig.messages = FnxUiMessages();
  fnxUiConfig.dateFormat = DateFormat("M/d/yyyy", "en_US");
  fnxUiConfig.dateTimeFormat = DateFormat("M/d/yyyy hh:mm a", "en_US");
}
