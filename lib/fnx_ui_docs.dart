import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:fnx_ui/src/docs/fnx_ui_docs_0010_usage.dart';

import 'package:fnx_ui/src/docs/fnx_ui_docs_0000_intro.template.dart' as c0000;
import 'package:fnx_ui/src/docs/fnx_ui_docs_0010_usage.template.dart' as c0010;
import 'package:fnx_ui/src/docs/fnx_ui_docs_0020_responsivity.template.dart' as c0020;
import 'package:fnx_ui/src/docs/fnx_ui_docs_0030_flex.template.dart' as c0030;
import 'package:fnx_ui/src/docs/fnx_ui_docs_0040_grid.template.dart' as c0040;
import 'package:fnx_ui/src/docs/fnx_ui_docs_0050_positioning.template.dart' as c0050;
import 'package:fnx_ui/src/docs/fnx_ui_docs_0060_padding.template.dart' as c0060;
import 'package:fnx_ui/src/docs/fnx_ui_docs_0070_margin.template.dart' as c0070;
import 'package:fnx_ui/src/docs/fnx_ui_docs_0080_border.template.dart' as c0080;
import 'package:fnx_ui/src/docs/fnx_ui_docs_0090_colors.template.dart' as c0090;

import 'package:fnx_ui/src/docs/fnx_ui_docs_0200_item.template.dart' as c0200;

import 'fnx_ui.dart';

// AngularDart info: https://angulardart.dev
// Components info: https://angulardart.dev/components

@Component(
  selector: 'fnx-ui-docs',
  templateUrl: 'fnx_ui_docs.html',
  directives: [fnxUiAllDirectives, coreDirectives, formDirectives, routerDirectives],
)
class FnxUiDocs {
  static List<Chapter> chapters = [
    Chapter("Introduction", c0000.FnxUiDocs0000IntroNgFactory),
    Chapter("Basic usage", c0010.FnxUiDocs0010UsageNgFactory),
    Chapter("Responsivity", c0020.FnxUiDocs0020ResponsivityNgFactory),
    Chapter("Flex", c0030.FnxUiDocs0030FlexNgFactory),
    Chapter("Grid", c0040.FnxUiDocs0040GridNgFactory),
    Chapter("Positioning", c0050.FnxUiDocs0050PositioningNgFactory),
    Chapter("Padding", c0060.FnxUiDocs0060PaddingNgFactory),
    Chapter("Margin", c0070.FnxUiDocs0070MarginNgFactory),
    Chapter("Border", c0080.FnxUiDocs0080BorderNgFactory),
    Chapter("Colors", c0090.FnxUiDocs0090ColorsNgFactory),
    Chapter("Item", c0200.FnxUiDocs0200ItemNgFactory),
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
