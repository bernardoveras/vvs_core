import '../../vvs_core.dart';

class TelefoneHelper {
  static String format(String telefone, {bool ddd = true}) => formatTelefone(telefone, ddd);

  static String strip(String telefone) {
    return telefone.replaceList(['(', ')', '-'], '');
  }
}
