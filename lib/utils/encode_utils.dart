import 'dart:convert';

String urlDecoder(String encoded) {
  return utf8.decode(
    base64.decode('$encoded=='),
  );
}
