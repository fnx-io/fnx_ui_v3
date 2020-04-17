import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:fnx_ui/fnx_ui_docs.template.dart' as ng;

import 'main.template.dart' as self;

@GenerateInjector(
  routerProvidersHash, // You can use routerProviders in production
)
final InjectorFactory injector = self.injector$Injector;

void main() {
  runApp(ng.FnxUiDocsNgFactory, createInjector: injector);
}