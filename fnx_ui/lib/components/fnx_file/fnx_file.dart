import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/api/input_component.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:logging/logging.dart';

const CUSTOM_INPUT_FILE_VALUE_ACCESSOR = const Provider(ngValueAccessor, useExisting: FnxFile);

@Component(
  selector: 'fnx-file',
  templateUrl: "fnx_file.html",
  styleUrls: ["fnx_file.css"],
  providers: const [
    CUSTOM_INPUT_FILE_VALUE_ACCESSOR,
    const Provider(FnxBaseComponent, useExisting: FnxFile),
  ],
  directives: [coreDirectives, formDirectives, fnxUiAllDirectives],
  preserveWhitespace: false,
)
class FnxFile extends FnxInputComponent<List<File>> implements OnInit, OnDestroy {
  final Logger log = Logger("FnxFile");

  /// Is it possible to drag and drop multiple files?
  @Input()
  bool multi = false;

  @Input()
  bool withDelete = false;

  /// Optional:
  /// If there is already a selected file in the model, use this attribute to provide file name or description.
  ///
  @Input()
  String fileName;

  @HostBinding('class.item-row')
  final bool hostIsItemRow = true;

  StreamController<List<File>> _files = StreamController<List<File>>();
  @Output()
  Stream<List<File>> get files => _files.stream;

  @Input()
  String browseLabel = fnxUiConfig.messages.input.browse;

  FnxFile(@SkipSelf() @Optional() FnxBaseComponent parent) : super(parent);

  @override
  bool get hasValidValue {
    if (required && isEmpty) return false;
    return true;
  }

  bool draggingOver = false;

  bool get possibleDrop => draggingOver;

  void onFileSelected(Event event) {
    if (isReadonly) return;
    processFiles(((event.target as InputElement).files as List).cast<File>());
  }

  void onDrag(MouseEvent event, bool enter) {
    if (isReadonly) return;
    draggingOver = enter && isCompatibleDataTransfer(event);
  }

  bool isCompatibleDataTransfer(MouseEvent event) {
    if (isReadonly) return false;
    return true; //event.dataTransfer.files != null && event.dataTransfer.files.isNotEmpty;
  }

  void onDragOver(Event event) {
    event.preventDefault();
  }

  void onDrop(MouseEvent event) {
    event.preventDefault();
    event.stopImmediatePropagation();
    log.info("Drop : ${event.dataTransfer}");
    draggingOver = false;
    if (isReadonly) return;
    processFiles(event.dataTransfer.files);
  }

  void processFiles(List<File> filesInput) {
    if (isReadonly) return;
    if (filesInput == null || filesInput.isEmpty) {
      return;
    }
    if (!multi && filesInput.length > 1) {
      return;
    }
    log.info("Dropped files: $filesInput");

    if (multi) {
      value = filesInput;
    } else {
      value = [filesInput[0]];
    }
    _files.add(value);
  }

  void deleteFiles() {
    if (isReadonly) return;
    value = null;
    _files.add(null);
  }

  bool get isEmpty {
    if (fileName != null) return false;
    return value == null || (value is List && (value as List).isEmpty);
  }

  String get renderDescription {
    if (fileName != null) return fileName;
    if (isEmpty) return fnxUiConfig.messages.input.dropFileHere(multi);
    if (value != null && value.length == 1) {
      return value[0].name;
    }
    if (value is List) {
      int count = value.length;
      return fnxUiConfig.messages.input.filesSelected(count);
    }
    return value.toString();
  }
}
