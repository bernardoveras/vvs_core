import 'package:flutter/material.dart';

/// Verifica se o teclado está aberto
/// 
/// Exemplo de uso:
/// ```dart
/// if (keyboardIsOpened) {
///  FocusScope.of(context).unfocus();
/// }
/// ```
bool get keyboardIsOpened => WidgetsBinding.instance.window.viewInsets.bottom > 0.0;