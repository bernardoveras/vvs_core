import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../componentes/vvs_button.dart';
import 'dialog_service.dart';

/// A classe FlutterDialogService é um singleton que fornece um mecanismo para mostrar diálogos.
/// Esta classe não utiliza nenhum package para mostrar diálogos, utiliza apenas a api do flutter.
///
/// Exemplo:
/// ```dart
/// var dialogService = FlutterDialogService.init(navigatorKey);
/// dialogService.show();
/// ```
class FlutterDialogService implements IDialogService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<T?> show<T>({
    required String title,
    required Widget content,
    bool dismissible = true,
    bool showCloseButton = true,
    T Function()? close,
    List<Widget>? actions,
    BoxConstraints? constraints,
  }) async {
    return await showDialog<T>(
      context: navigatorKey.currentState!.overlay!.context,
      builder: (context) => ConstrainedBox(
        constraints: constraints ?? const BoxConstraints(),
        child: AlertDialog(
          title: FadeInUp(
            from: 5,
            duration: const Duration(milliseconds: 200),
            child: Row(
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
                if (showCloseButton) ...{
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: Colors.black,
                    tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      Navigator.pop(navigatorKey.currentState!.overlay!.context);
                    },
                    splashRadius: 24,
                  ),
                },
              ],
            ),
          ),
          content: FadeInUp(
            from: 5,
            duration: const Duration(milliseconds: 200),
            child: content,
          ),
          actions: actions
              ?.map(
                (action) => FadeInUp(
                  from: 5,
                  duration: const Duration(milliseconds: 200),
                  child: action,
                ),
              )
              .toList(),
        ),
      ),
      barrierDismissible: dismissible,
    );
  }

  @override
  Future<T?> confirmation<T>({
    required String title,
    String? description,
    Widget? content,
    bool dismissible = true,
    VoidCallback? cancel,
    VoidCallback? confirm,
    T Function()? close,
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
    bool closeOnConfirm = true,
    bool closeOnCancel = true,
    bool showCloseButton = true,
    BoxConstraints? constraints,
  }) {
    if ((description == null && content == null) || (description != null && content != null)) {
      throw AssertionError('Informe um description ou content.');
    }

    return show(
      title: title,
      content: content ??
          Text(
            description!,
            style: GoogleFonts.roboto(color: Colors.grey.shade600),
          ),
      constraints: constraints,
      showCloseButton: showCloseButton,
      dismissible: dismissible,
      actions: [
        VvsButton.text(
          cancelText,
          onPressed: () {
            if (cancel != null) {
              cancel.call();
            }
            if (closeOnCancel && close != null) {
              Navigator.pop(navigatorKey.currentState!.overlay!.context);
            }
            if (close != null) {
              close.call();
            }
          },
        ),
        VvsButton(
          confirmText,
          onPressed: () {
            if (confirm != null) {
              confirm.call();
            }
            if (closeOnConfirm && close != null) {
              Navigator.pop(navigatorKey.currentState!.overlay!.context);
            }
            if (close != null) {
              close.call();
            }
          },
        ),
      ],
    );
  }
}
