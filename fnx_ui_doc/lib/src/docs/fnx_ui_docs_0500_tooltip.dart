import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';

@Component(
  selector: 'fnx-ui-docs-0500-tooltip',
  templateUrl: 'fnx_ui_docs_0500_tooltip.html',
  directives: [fnxUiAllDirectives, coreDirectives, formDirectives],
)
class FnxUiDocs0500Tooltip {
  FnxUiDocs0500Tooltip();

  String tooltipProvider() {
    return "This is functional tooltip!";
  }

  Function tooltipClosure(int data) {
    return () {
      return "Dynamic tooltip from closure $data";
    };
  }

  Future delayedTooltip([int data = 0]) async {
    await new Future.delayed(new Duration(milliseconds: 1000));
    return "And here it comes = $data!";
  }

  Function delayedClosure(int data) {
    return () {
      return delayedTooltip(data);
    };
  }

  String htmlTooltip = """
    <h4>Yes, it's possible</h4>
    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusantium, consequuntur doloremque
     in incidunt nostrum quis reiciendis tempore voluptates? A aut beatae blanditiis debitis excepturi
      exercitationem incidunt modi obcaecati possimus ut!</p>
    <p class='text--red'>Or is it? Yes it is.</p>
  """;
}
