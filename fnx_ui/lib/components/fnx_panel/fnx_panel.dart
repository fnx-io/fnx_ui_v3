// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/api/mixins/closable_component.dart';
import 'package:fnx_ui/api/mixins/header.dart';

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
    styles: [":host {display: block;}"],
    styleUrls: ["fnx_panel.css"],
    preserveWhitespace: false,
    directives: [
      coreDirectives,
    ],
    providers: [
      Provider(FnxBaseComponent, useExisting: FnxPanel),
    ],
    visibility: Visibility.all)
class FnxPanel extends FnxBaseComponent
    with ClosableComponent, Header
    implements OnInit, OnDestroy {
  FnxPanel(@SkipSelf() @Optional() FnxBaseComponent parent) : super(parent);

  @override
  bool get hasValidValue => true;
}
