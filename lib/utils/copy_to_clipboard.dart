import 'package:flutter/services.dart';

Future<void> copyToClipboard(String text) {
    return Clipboard.setData(ClipboardData(text: text));
  }