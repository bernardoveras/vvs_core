import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vvs_core/utils/hide_keyboard.dart';

class HideKeyboardTestWidget extends StatelessWidget {
  const HideKeyboardTestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 200.0,
            child: TextField(
              key: const Key('text_field'),
              focusNode: FocusNode(debugLabel: 'focusNode'),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            key: const Key('hide_keyboard_button'),
            onPressed: () => hideKeyboard(),
            child: const Text('Hide keyboard'),
          ),
        ],
      ),
    ));
  }
}

void main() {
  const textFieldKey = Key('text_field');
  const buttonKey = Key('hide_keyboard_button');
  testWidgets('Hide keyboard', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HideKeyboardTestWidget(),
    ));

    var textField = find.byKey(textFieldKey).evaluate().single.widget as TextField;

    expect(textField.focusNode!.hasFocus, false);

    await tester.tap(find.byWidget(textField));

    await tester.pumpAndSettle();

    textField = find.byKey(textFieldKey).evaluate().single.widget as TextField;

    expect(textField.focusNode!.hasFocus, true);

    var button = find.byKey(buttonKey).evaluate().single.widget as ElevatedButton;

    await tester.tap(find.byWidget(button));

    await tester.pumpAndSettle();

    textField = find.byKey(textFieldKey).evaluate().single.widget as TextField;

    expect(textField.focusNode!.hasFocus, false);
  });
}
