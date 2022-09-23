import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vvs_core/utils/copy_to_clipboard.dart';

void main() {
  final List<MethodCall> log = <MethodCall>[];

  const String text = 'copied text';

  void mockClipboard() {
    handler(MethodCall methodCall) async {
      log.add(methodCall);
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
  test('Copy to Clipboard', () async {
    await copyToClipboard(text);

    final String copiedText = log.firstWhere((e) => e.method == 'Clipboard.setData').arguments['text'];
    expect(copiedText, text);
  });
}
