import 'dart:typed_data';

class LogoPickerController {
  Uint8List? _bytes;
  void setBytes(Uint8List? bytes) {
    _bytes = bytes;
  }

  Uint8List? get bytes => _bytes;
}
