import 'package:uuid/uuid.dart';

String generateGuid({bool onlyLettersAndNumbers = false}) {
  String guid = const Uuid().v4();

  if (onlyLettersAndNumbers) {
    guid = guid.replaceAll('-', '');
  }

  return guid;
}
