import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/api/base_component.dart';
import 'package:fnx_ui/api/input_component.dart';
import 'package:fnx_ui/fnx_ui.dart';

const CUSTOM_INPUT_FILE_VALUE_ACCESSOR = const Provider(ngValueAccessor, useExisting: FnxFile, multi: true);

@Component(
  selector: 'fnx-file',
  templateUrl: "fnx_file.html",
  styleUrls: ["fnx_file.css"],
  providers: const [
    CUSTOM_INPUT_FILE_VALUE_ACCESSOR,
    const Provider(FnxBaseComponent, useExisting: FnxFile, multi: false),
  ],
  directives: [coreDirectives, formDirectives],
  preserveWhitespace: false,
)
class FnxFile extends FnxInputComponent<List<File>> implements OnInit, OnDestroy {
  /// Is it possible to drag and drop multiple files?
  @Input()
  bool multi = false;

  ///
  /// Optional:
  /// If there is already a selected file in the model, use this attribute to provide file name or description.
  ///
  @Input()
  String fileName;

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
    if (multi) {
      _files.add(filesInput);
    } else {
      _files.add([filesInput[0]]);
    }
  }

  void deleteFiles() {
    if (isReadonly) return;
    value = null;
    _files.add(null);
  }

  bool get isEmpty {
    return value == null || (value is List && (value as List).isEmpty);
  }

  String get renderDescription {
    if (isEmpty) return fnxUiConfig.messages.input.dropFileHere(multi);
    if (fileName != null) return fileName;
    if (value is List && value.length == 1) {
      return value[0].toString();
    }
    if (value is List) {
      int count = value.length;
      return fnxUiConfig.messages.input.filesSelected(count);
    }
    return value.toString();
  }
}
