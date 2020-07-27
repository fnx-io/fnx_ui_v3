// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:fnx_ui/api/base_closable_component/base_closable_component.dart';
import 'package:fnx_ui/api/base_component.dart';

///
/// Nice "fieldset". It should have a header, defined with attribute 'header'. Like this:
///
///       <fnx-panel>
///           <h3 header>Address</h1>
///           <p header>Please fill your address</p>
///           <div>Panel content ...</div>
///       </fnx-panel>
///
@Component(
    selector: 'fnx-panel',
    templateUrl: 'fnx_panel.html',
    styles: const [":host {display: block;}"],
    preserveWhitespace: false,
    directives: [
      coreDirectives,
    ],
    providers: const [
      const Provider(FnxBaseComponent, useExisting: FnxPanel, multi: false),
    ],
    visibility: Visibility.all)
class FnxPanel extends BaseClosableComponent implements OnInit, OnDestroy {
  @Input()
  bool noHeaderPadding = false;

  FnxPanel(@SkipSelf() @Optional() FnxBaseComponent parent) : super(parent);
}
