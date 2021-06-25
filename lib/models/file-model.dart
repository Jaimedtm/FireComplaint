import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

class FileModel {
  FilePickerResult _file;
  String get name {
    return _file.names[0];
  }

  String get nameElipsis {
    return _file.names[0].length > 9
        ? _file.names[0].substring(0, 6) + '...'
        : _file.names[0];
  }

  String get type {
    var f = _file.names[0];
    return f.substring(f.lastIndexOf('.') + 1);
  }

  double get size {
    return (_file.files[0].size / 1000000);
  }

  Uint8List get fielUI8 {
    return _file.files[0].bytes;
  }

  FileModel(FilePickerResult file) {
    _file = file;
  }
}
