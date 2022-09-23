import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Um ​​comportamento de rolagem que exclui o efeito de brilho da barra de rolagem.
/// 
/// Exemplo de uso:
/// ```dart
/// MaterialApp(
///   scrollBehavior: ExcludeGlowScrollBehavior(),
///   ...
/// );
/// ```
class ExcludeGlowScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) => child;
}
