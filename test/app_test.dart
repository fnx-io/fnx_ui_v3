@TestOn('browser')
import 'package:angular_test/angular_test.dart';
import 'package:test/test.dart';
import 'package:fnx_ui/fnx_ui_docs.dart';
import 'package:fnx_ui/fnx_ui_docs.template.dart' as ng;

void main() {
  final testBed = NgTestBed.forComponent<FnxUiDocs>(ng.FnxUiDocsNgFactory);
  NgTestFixture<FnxUiDocs> fixture;

  setUp(() async {
    fixture = await testBed.create();
  });

  tearDown(disposeAnyRunningTest);

  test('heading', () {
    expect(fixture.text, contains('My First AngularDart App'));
  });

  // Testing info: https://angulardart.dev/guide/testing
}
