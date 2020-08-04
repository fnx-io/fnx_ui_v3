import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0000_intro.template.dart' as c0000;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0010_usage.template.dart' as c0010;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0020_responsivity.template.dart' as c0020;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0030_flex.template.dart' as c0030;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0040_grid.template.dart' as c0040;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0050_positioning.template.dart' as c0050;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0060_padding.template.dart' as c0060;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0070_margin.template.dart' as c0070;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0080_border.template.dart' as c0080;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0090_colors.template.dart' as c0090;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0100_effects.template.dart' as c0100;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0110_table.template.dart' as c0110;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0200_item.template.dart' as c0200;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0210_panel.template.dart' as c0210;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0240_dropdown.template.dart' as c0240;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0250_label.template.dart' as c0250;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0260_text.template.dart' as c0260;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0380_file.template.dart' as c0380;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0300_checkbox.template.dart' as c0300;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0350_integer.template.dart' as c0350;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0360_double.template.dart' as c0360;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0370_formatted_number.template.dart' as c0370;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0400_datepicker.template.dart' as c0400;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0410_date.template.dart' as c0410;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0500_tooltip.template.dart' as c0500;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0505_toast.template.dart' as c0505;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0507_modal.template.dart' as c0507;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0510_loader.template.dart' as c0510;
import 'package:fnx_ui_doc/src/docs/fnx_ui_docs_0520_tags.template.dart' as c0520;

// AngularDart info: https://angulardart.dev
// Components info: https://angulardart.dev/components

@Component(
  selector: 'fnx-ui-docs',
  templateUrl: 'fnx_ui_docs.html',
  directives: [fnxUiAllDirectives, coreDirectives, formDirectives, routerDirectives],
)
class FnxUiDocs {
  static List<Chapter> chapters = [
    Chapter('Introduction', c0000.FnxUiDocs0000IntroNgFactory),
    Chapter('Basic usage', c0010.FnxUiDocs0010UsageNgFactory),
    Chapter('Responsivity', c0020.FnxUiDocs0020ResponsivityNgFactory),
    Chapter('Flex', c0030.FnxUiDocs0030FlexNgFactory),
    Chapter('Grid', c0040.FnxUiDocs0040GridNgFactory),
    Chapter('Positioning', c0050.FnxUiDocs0050PositioningNgFactory),
    Chapter('Padding', c0060.FnxUiDocs0060PaddingNgFactory),
    Chapter('Margin', c0070.FnxUiDocs0070MarginNgFactory),
    Chapter('Border', c0080.FnxUiDocs0080BorderNgFactory),
    Chapter('Colors', c0090.FnxUiDocs0090ColorsNgFactory),
    Chapter('Effects', c0100.FnxUiDocs0100EffectsNgFactory),
    Chapter('Table', c0110.FnxUiDocs0110TableNgFactory),
    Chapter('Item', c0200.FnxUiDocs0200ItemNgFactory),
    Chapter('Panel', c0210.FnxUiDocs0210PanelNgFactory),
    Chapter('Dropdown', c0240.FnxUiDocs0240DropdownNgFactory),
    Chapter('Label', c0250.FnxUiDocs0250LabelNgFactory),
    Chapter('Text', c0260.FnxUiDocs0260TextNgFactory),
    Chapter('Checkbox', c0300.FnxUiDocs0300CheckboxNgFactory),
    Chapter('Integer', c0350.FnxUiDocs0350IntegerNgFactory),
    Chapter('Double', c0360.FnxUiDocs0360DoubleNgFactory),
    Chapter('File', c0380.FnxUiDocs0380FileNgFactory),
    Chapter('FormattedNumber', c0370.FnxUiDocs0370FormattedNumberNgFactory),
    Chapter('DatePicker', c0400.FnxUiDocs0400DatePickerNgFactory),
    Chapter('Date', c0410.FnxUiDocs0410DateNgFactory),
    Chapter('Tooltip', c0500.FnxUiDocs0500TooltipNgFactory),
    Chapter('Toasts', c0505.FnxUiDocs0505ToastNgFactory),
    Chapter('Modal', c0507.FnxUiDocs0507ModalNgFactory),
    Chapter('Loader', c0510.FnxUiDocs0510LoaderNgFactory),
    Chapter('Tags', c0520.FnxUiDocs0520TagsNgFactory),
  ];

  List<RouteDefinition> routes;
  FnxUiDocs() {
    var _first = true;
    routes = chapters.map((ch) {
      var _result = RouteDefinition(path: ch.selector, component: ch.factory, useAsDefault: _first);
      _first = false;
      return _result;
    }).toList();
  }
}

class Chapter {
  final String name;
  final ComponentFactory factory;
  final String selector;

  Chapter(this.name, this.factory) : selector = factory.selector;
}
