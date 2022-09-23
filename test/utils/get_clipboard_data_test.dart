import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vvs_core/utils/get_clipboard_data.dart';

void main() {
  final List<MethodCall> log = <MethodCall>[];

  const String text = 'copied text';

  void mockClipboard() {
    handler(MethodCall methodCall) async {
      log.add(methodCall);

      if (methodCall.method == 'Clipboard.getData') {
        return {'text': text};
      }
    }

    TestWidgetsFlutterBinding.ensureInitialized();

    SystemChannels.platform.setMockMethodCallHandler(handler);
  }

  tearDownAll(() {
    SystemChannels.platform.setMockMethodCallHandler(null);
  });

  setUpAll(() {
    mockClipboard();
  });

  test('Get data from Clipboard', () async {
    String? copiedText = await getDataFromClipboard();

    expect(copiedText, text);
  });
}
