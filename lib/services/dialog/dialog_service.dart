import 'package:flutter/material.dart';

abstract class IDialogService {
  Future<T?> show<T>({
    required String title,
    required Widget content,
    bool dismissible = true,
    bool showCloseButton = true,
    List<Widget>? actions,
    BoxConstraints? constraints,
  });

  Future<T?> confirmation<T>({
    required String title,
    String? description,
    Widget? content,
    bool dismissible = true,
    VoidCallback? cancel,
    VoidCallback? confirm,
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
    bool closeOnConfirm = true,
    bool closeOnCancel = true,
    bool showCloseButton = true,
    BoxConstraints? constraints,
  });
}
