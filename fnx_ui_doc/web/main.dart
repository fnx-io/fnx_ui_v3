import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:fnx_ui_doc/fnx_ui_docs.template.dart' as ng;

import 'main.template.dart' as self;
import 'package:logging/logging.dart';

@GenerateInjector(
  routerProvidersHash, // You can use routerProviders in production
)
final InjectorFactory injector = self.injector$Injector;

void main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  runApp(ng.FnxUiDocsNgFactory, createInjector: injector);
}
