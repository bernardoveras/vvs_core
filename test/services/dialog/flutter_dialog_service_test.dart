import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vvs_core/services/dialog/dialog_service.dart';
import 'package:vvs_core/services/dialog/flutter_dialog_service.dart';

void main() {
  late final IDialogService dialogService;

  setUpAll(() {
    dialogService = FlutterDialogService();
  });

  Widget buildTestApp({Widget? widget, bool dialogIsDismissible = true}) => MaterialApp(
        navigatorKey: FlutterDialogService.navigatorKey,
        home: Scaffold(
          body: Center(
            child: ElevatedButton(
              child: const Text('Open dialog'),
              onPressed: () {
                dialogService.show(
                  title: 'Title',
                  content: const Text('content'),
                  dismissible: dialogIsDismissible,
                );
              },
            ),
          ),
        ),
      );

  testWidgets('Deve abrir o dialog e ao clicar fora do dialog fechar', (tester) async {
    await tester.pumpWidget(buildTestApp());

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);

    // Tap on the barrier.
    await tester.tapAt(const Offset(10.0, 10.0));

    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(AlertDialog), findsNothing);
  });
  testWidgets('Deve abrir o dialog e ao clicar fora do dialog não fechar', (tester) async {
    await tester.pumpWidget(buildTestApp(dialogIsDismissible: false));

    await tester.tap(find.text('Open dialog'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);

    // Tap on the barrier.
    await tester.tapAt(const Offset(10.0, 10.0));

    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(AlertDialog), findsOneWidget);
  });
}
