import 'dart:convert';

import 'dart:io';

import 'package:flutter/foundation.dart';

bool _isEmpty(dynamic value) {
  if (value is String) {
    return value.toString().trim().isEmpty;
  }
  if (value is Iterable || value is Map) {
    return (value.isEmpty as bool?) ?? false;
  }
  return false;
}

/// Checks if data is null or blank (empty or only contains whitespace).
bool isNullOrBlank(dynamic value) {
  if (value == null) {
    return true;
  }

  // Pretty sure that isNullOrBlank should't be validating
  // iterables... but I'm going to keep this for compatibility.
  return _isEmpty(value);
}

/// Checks if data is null or blank (empty or only contains whitespace).
bool? isBlank(dynamic value) {
  return _isEmpty(value);
}

/// Checks if string is boolean.
bool isBool(String value) {
  return (value == 'true' || value == 'false');
}

/// Checks if string is int or double.
bool isNumber(String value) {
  return num.tryParse(value) is num;
}

/// Checks if string is double.
bool isDouble(String value) {
  return double.tryParse(value) is double;
}

/// Checks if string is int.
bool isInt(String value) {
  return int.tryParse(value) is int;
}

/// Checks if string is map.
bool isMap(String value) {
  try {
    jsonDecode(value) as Map<String, dynamic>;
    return true;
  } on FormatException catch (_) {
    return false;
  }
}

/// Checks if string is URL.
bool isURL(String s) => hasMatch(s,
    r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9].)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-]+))*$");

/// Checks if string is email.
bool isEmail(String? s) => s == null
    ? false
    : hasMatch(s,
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

/// Checks if string is phone number.
bool isPhoneNumber(String s) {
  if (s.length > 16 || s.length < 9) return false;
  return hasMatch(s, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
}

/// Checks if string is DateTime (UTC or Iso8601).
bool isDateTime(String s) => hasMatch(s, r'^\d{4}-\d{2}-\d{2}[ T]\d{2}:\d{2}:\d{2}.\d{3}Z?$');

/// Checks if string is IPv4.
bool isIPv4(String s) => hasMatch(s, r'^(?:(?:^|\.)(?:2(?:5[0-5]|[0-4]\d)|1?\d?\d)){4}$');

/// Checks if string is IPv6.
bool isIPv6(String s) => hasMatch(s,
    r'^((([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}:[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){5}:([0-9A-Fa-f]{1,4}:)?[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){4}:([0-9A-Fa-f]{1,4}:){0,2}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){3}:([0-9A-Fa-f]{1,4}:){0,3}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){2}:([0-9A-Fa-f]{1,4}:){0,4}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|(([0-9A-Fa-f]{1,4}:){0,5}:((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|(::([0-9A-Fa-f]{1,4}:){0,5}((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|([0-9A-Fa-f]{1,4}::([0-9A-Fa-f]{1,4}:){0,5}[0-9A-Fa-f]{1,4})|(::([0-9A-Fa-f]{1,4}:){0,6}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){1,7}:))$');

//Check if num is a cnpj
bool isCnpj(String cnpj) {
  // Obter somente os números do CNPJ
  final numbers = cnpj.replaceAll(RegExp(r'[^0-9]'), '');

  // Testar se o CNPJ possui 14 dígitos
  if (numbers.length != 14) {
    return false;
  }

  // Testar se todos os dígitos do CNPJ são iguais
  if (RegExp(r'^(\d)\1*$').hasMatch(numbers)) {
    return false;
  }

  // Dividir dígitos
  final digits = numbers.split('').map(int.parse).toList();

  // Calcular o primeiro dígito verificador
  var calcDv1 = 0;
  var j = 0;
  for (var i in Iterable<int>.generate(12, (i) => i < 4 ? 5 - i : 13 - i)) {
    calcDv1 += digits[j++] * i;
  }
  calcDv1 %= 11;
  final dv1 = calcDv1 < 2 ? 0 : 11 - calcDv1;

  // Testar o primeiro dígito verificado
  if (digits[12] != dv1) {
    return false;
  }

  // Calcular o segundo dígito verificador
  var calcDv2 = 0;
  j = 0;
  for (var i in Iterable<int>.generate(13, (i) => i < 5 ? 6 - i : 14 - i)) {
    calcDv2 += digits[j++] * i;
  }
  calcDv2 %= 11;
  final dv2 = calcDv2 < 2 ? 0 : 11 - calcDv2;

  // Testar o segundo dígito verificador
  if (digits[13] != dv2) {
    return false;
  }

  return true;
}

/// Checks if the cpf is valid.
bool isCpf(String cpf) {
  // get only the numbers
  final numbers = cpf.replaceAll(RegExp(r'[^0-9]'), '');
  // Test if the CPF has 11 digits
  if (numbers.length != 11) {
    return false;
  }
  // Test if all CPF digits are the same
  if (RegExp(r'^(\d)\1*$').hasMatch(numbers)) {
    return false;
  }

  // split the digits
  final digits = numbers.split('').map(int.parse).toList();

  // Calculate the first verifier digit
  var calcDv1 = 0;
  for (var i in Iterable<int>.generate(9, (i) => 10 - i)) {
    calcDv1 += digits[10 - i] * i;
  }
  calcDv1 %= 11;

  final dv1 = calcDv1 < 2 ? 0 : 11 - calcDv1;

  // Tests the first verifier digit
  if (digits[9] != dv1) {
    return false;
  }

  // Calculate the second verifier digit
  var calcDv2 = 0;
  for (var i in Iterable<int>.generate(10, (i) => 11 - i)) {
    calcDv2 += digits[11 - i] * i;
  }
  calcDv2 %= 11;

  final dv2 = calcDv2 < 2 ? 0 : 11 - calcDv2;

  // Test the second verifier digit
  if (digits[10] != dv2) {
    return false;
  }

  return true;
}

bool hasMatch(String? value, String pattern) {
  return (value == null) ? false : RegExp(pattern).hasMatch(value);
}

/// Remove all whitespace inside string
/// Example: your name => yourname
String removeAllWhitespace(String value) {
  return value.replaceAll(' ', '');
}

bool isDesktopPlatform() => Platform.isWindows || Platform.isLinux || Platform.isMacOS;
bool isMobilePlatform() => Platform.isAndroid || Platform.isIOS;
bool isWebPlatform() => kIsWeb;
