extension StringExtension on String {
  String replaceList(List<String> from, String replace) {
    String newString = this;

    for (String _from in from) {
      newString = newString.replaceAll(_from, replace);
    }

    return newString;
  }

  String whereNullOrEmpty(String defaultValue) => isNullOrEmpty() == false ? this : defaultValue;

  DateTime? toDateTime() {
    if (length != 10) return null;

    final List<String> splittedNums = split('/');
    if (splittedNums.length != 3) return null;

    final int day = int.parse(splittedNums[0]);
    final int month = int.parse(splittedNums[1]);
    final int year = int.parse(splittedNums[2]);

    return DateTime(year, month, day);
  }

  String trimBoth() => trimLeft().trimRight();

  String capitalize() {
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String removeWhitespace() {
    return replaceAll(' ', '');
  }
}

extension StringNullableExtension on String? {
  String? replaceList(List<String> from, String replace) {
    String? newString = this;

    if (isNullOrEmpty()) return null;

    for (String _from in from) {
      newString = newString!.replaceAll(_from, replace);
    }

    return newString;
  }

  bool isNullOrEmpty() => this == null || this == '';

  bool contemNumero() {
    if (this == null) return false;

    return this!.contains(RegExp(r'[0-9]'));
  }

  bool contemCaracterEspecial() {
    if (this == null) return false;

    return this!.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  bool isInstagramUser() {
    if (isNullOrEmpty()) return false;

    if (this![0] != '@') return false;

    if (this!.contains('#')) return false;

    return true;
  }

  String? trimBoth() => this?.trimLeft().trimRight();

  String? whereNullOrEmpty(String? defaultValue) => isNullOrEmpty() == false ? this : defaultValue;

  String? removeWhitespace() {
    if (this == null) return this;

    return this!.replaceAll(' ', '');
  }
}
