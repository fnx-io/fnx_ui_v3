import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:fnx_ui/src/docs/fnx_ui_docs_0010_usage.dart';

import 'package:fnx_ui/src/docs/fnx_ui_docs_0000_intro.template.dart' as a;
import 'package:fnx_ui/src/docs/fnx_ui_docs_0010_usage.template.dart' as b;
import 'package:fnx_ui/src/docs/fnx_ui_docs_0020_responsivity.template.dart' as c0020;

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
    Chapter("Introduction", a.FnxUiDocs0000IntroNgFactory),
    Chapter("Basic usage", b.FnxUiDocs0010UsageNgFactory),
    Chapter("Responsivity", c0020.FnxUiDocs0020ResponsivityNgFactory)
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
