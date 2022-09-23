import 'package:flutter/services.dart';

Future<String?> getDataFromClipboard() async {
  return (await Clipboard.getData(Clipboard.kTextPlain))?.text;
}
