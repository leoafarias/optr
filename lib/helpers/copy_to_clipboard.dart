import 'package:flutter/services.dart';

/// Copies [text] to the system clipboard
void copyToClipboard(String text) {
  Clipboard.setData(ClipboardData(text: text));
}
