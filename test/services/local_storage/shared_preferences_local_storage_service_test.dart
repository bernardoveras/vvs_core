import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:vvs_core/services/local_storage/local_storage_service.dart';
import 'package:vvs_core/services/local_storage/shared_preferences_local_storage_service.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}

void main() {
  late final SharedPreferences sharedPreferences;
  late final ILocalStorageService storageService;

  setUpAll(() {
    sharedPreferences = SharedPreferencesMock();
    storageService = SharedPreferencesLocalStorageService(sharedPreferences);
  });

  void mockRead(dynamic value) {
    return when(() => sharedPreferences.get(any())).thenAnswer((_) => Future.value(value));
  }

  test('Deve retornar o valor correto no read caso o resultado for uma String', () async {
    const String result = 'value';

    mockRead(result);

    expect(await storageService.read('generic_key'), result);
  });

  test('Deve retornar o valor correto no read caso o resultado for um Int', () async {
    const int result = 21;

    mockRead(result);

    expect(await storageService.read('generic_key'), result);
  });

  test('Deve retornar o valor correto no read caso o resultado for um Double', () async {
    const double result = 21.2;

    mockRead(result);

    expect(await storageService.read('generic_key'), result);
  });

  test('Deve retornar o valor correto no read caso o resultado for um Bool', () async {
    const bool result = false;

    mockRead(result);

    expect(await storageService.read('generic_key'), result);
  });

  test("Deve retornar o valor correto no read caso o resultado for um Map", () async {
    const Map result = {"key": "value"};

    mockRead(result);

    expect(await storageService.read('generic_key'), result);
  });
}
