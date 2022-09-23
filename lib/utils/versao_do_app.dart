import 'dart:core';

import 'package:package_info_plus/package_info_plus.dart';

/// Classe que retorna a versão do app.
/// 
/// Exemplo de uso:
/// ```dart
/// String versaoDoApp = await VersaoDoApp.obter();
/// ```
class VersaoDoApp {
  const VersaoDoApp._();

  static Future<String> obter() async => (await PackageInfo.fromPlatform()).version;
}
