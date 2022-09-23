import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vvs_core/utils/input_formatters/input_formatters.dart';

Widget boilerplate(TextInputFormatter inputFormatter, TextEditingController textController) {
  return MaterialApp(
    home: MediaQuery(
      data: const MediaQueryData(size: Size(320, 480)),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Material(
          child: TextField(
            controller: textController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              inputFormatter,
            ],
          ),
        ),
      ),
    ),
  );
}

Widget boilerplatePlacaVeiculo(TextInputFormatter inputFormatter, TextEditingController textController) {
  return MaterialApp(
    home: MediaQuery(
      data: const MediaQueryData(size: Size(320, 480)),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Material(
          child: TextField(
            controller: textController,
            inputFormatters: [
              inputFormatter,
            ],
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('CpfInputFormatter', (WidgetTester tester) async {
    final textController = TextEditingController();
    await tester.pumpWidget(boilerplate(CpfInputFormatter(), textController));

    await tester.enterText(find.byType(TextField), '12345678900');
    expect(textController.text, '123.456.789-00');
  });

  testWidgets('CnpjInputFormatter', (WidgetTester tester) async {
    final textController = TextEditingController();
    await tester.pumpWidget(boilerplate(CnpjInputFormatter(), textController));

    await tester.enterText(find.byType(TextField), '12345678900099');
    expect(textController.text, '12.345.678/9000-99');
  });

  testWidgets('TelefoneInputFormatter', (WidgetTester tester) async {
    final textController = TextEditingController();

    await tester.pumpWidget(boilerplate(TelefoneInputFormatter(), textController));

    await tester.enterText(find.byType(TextField), '9912345678');
    expect(textController.text, '(99) 1234-5678');

    await tester.pumpWidget(boilerplate(TelefoneInputFormatter(), textController));
    await tester.enterText(find.byType(TextField), '00987654321');

    expect(textController.text, '(00) 98765-4321');
  });
  testWidgets('DataInputFormatter', (WidgetTester tester) async {
    final textController = TextEditingController();
    await tester.pumpWidget(boilerplate(DataInputFormatter(), textController));

    await tester.enterText(find.byType(TextField), '01011900');
    expect(textController.text, '01/01/1900');
  });

  testWidgets('CepInputFormatter', (WidgetTester tester) async {
    final textController = TextEditingController();
    await tester.pumpWidget(boilerplate(CepInputFormatter(), textController));

    await tester.enterText(find.byType(TextField), '123456789');
    expect(textController.text, '');

    await tester.enterText(find.byType(TextField), '12345678');
    expect(textController.text, '12.345-678');

    await tester.pumpWidget(boilerplate(CepInputFormatter(ponto: false), textController));

    await tester.enterText(find.byType(TextField), '12345678');
    expect(textController.text, '12345-678');
  });

  testWidgets('RealInputFormatter', (WidgetTester tester) async {
    final textController = TextEditingController();
    await tester.pumpWidget(boilerplate(RealInputFormatter(), textController));

    await tester.enterText(find.byType(TextField), '1256780');
    expect(textController.text, '1.256.780');
    await tester.enterText(find.byType(TextField), '125678');
    expect(textController.text, '125.678');
    await tester.enterText(find.byType(TextField), '1234');
    expect(textController.text, '1.234');

    await tester.enterText(find.byType(TextField), '5678');
    expect(textController.text, '5.678');

    await tester.enterText(find.byType(TextField), '678');
    expect(textController.text, '678');

    await tester.enterText(find.byType(TextField), '78');
    expect(textController.text, '78');

    await tester.enterText(find.byType(TextField), '8');
    expect(textController.text, '8');
  });

  testWidgets('RealInputFormatter + moeda', (WidgetTester tester) async {
    final textController = TextEditingController();

    await tester.pumpWidget(boilerplate(RealInputFormatter(moeda: true), textController));

    await tester.enterText(find.byType(TextField), '1256780');
    expect(textController.text, 'R\$ 1.256.780');

    await tester.enterText(find.byType(TextField), '125678');
    expect(textController.text, 'R\$ 125.678');

    await tester.enterText(find.byType(TextField), '5678');
    expect(textController.text, 'R\$ 5.678');

    await tester.enterText(find.byType(TextField), '678');
    expect(textController.text, 'R\$ 678');

    await tester.enterText(find.byType(TextField), '78');
    expect(textController.text, 'R\$ 78');

    await tester.enterText(find.byType(TextField), '8');
    expect(textController.text, 'R\$ 8');
  });

  testWidgets('CentavosInputFormatter', (WidgetTester tester) async {
    final textController = TextEditingController();
    await tester.pumpWidget(boilerplate(CentavosInputFormatter(), textController));

    await tester.enterText(find.byType(TextField), '12567');
    expect(textController.text, '125,67');

    await tester.enterText(find.byType(TextField), '567');
    expect(textController.text, '5,67');

    await tester.enterText(find.byType(TextField), '67');
    expect(textController.text, '0,67');

    await tester.enterText(find.byType(TextField), '8');
    expect(textController.text, '0,08');
  });

  testWidgets('CentavosInputFormatter 3 decimais', (WidgetTester tester) async {
    final textController = TextEditingController();

    await tester.pumpWidget(boilerplate(CentavosInputFormatter(casasDecimais: 3), textController));

    await tester.enterText(find.byType(TextField), '125678');
    expect(textController.text, '125,678');

    await tester.enterText(find.byType(TextField), '5678');
    expect(textController.text, '5,678');

    await tester.enterText(find.byType(TextField), '678');
    expect(textController.text, '0,678');

    await tester.enterText(find.byType(TextField), '78');
    expect(textController.text, '0,078');

    await tester.enterText(find.byType(TextField), '8');
    expect(textController.text, '0,008');
  });

  testWidgets('Compound of CPF and CPNJ', (WidgetTester tester) async {
    final textController = TextEditingController();
    final formatter = CompoundFormatter([
      CpfInputFormatter(),
      CnpjInputFormatter(),
    ]);

    // Esperamos os resultados no seguinte formato:
    // '123.456.789-00'      // CPF
    // '12.345.678/9000-99'  // CPNJ

    await tester.pumpWidget(boilerplate(formatter, textController));
    await tester.enterText(find.byType(TextField), '12345678900');
    expect(textController.text, '123.456.789-00');
    await tester.enterText(find.byType(TextField), '123456789000');
    expect(textController.text, '12.345.678/9000');
    await tester.enterText(find.byType(TextField), '1234567890009');
    expect(textController.text, '12.345.678/9000-9');
    await tester.enterText(find.byType(TextField), '12345678900099');
    expect(textController.text, '12.345.678/9000-99');
  });

  testWidgets('PlacaVeiculoInputFormatter', (WidgetTester tester) async {
    final textController = TextEditingController();

    // testa toUpperCase
    await tester.pumpWidget(
        boilerplatePlacaVeiculo(PlacaVeiculoInputFormatter(), textController));
    await tester.enterText(find.byType(TextField), 'abc');
    expect(textController.text, 'ABC');

    await tester.pumpWidget(
        boilerplatePlacaVeiculo(PlacaVeiculoInputFormatter(), textController));
    await tester.enterText(find.byType(TextField), 'abc-1234');
    expect(textController.text, 'ABC-1234');
  });

  testWidgets('CPFToCPNJFormatter', (WidgetTester tester) async {
    final textController = TextEditingController();
    final formatter = CpfOuCnpjFormatter();

    // Esperamos os resultados no seguinte formato:
    // '123.456.789-00'      // CPF
    // '12.345.678/9000-99'  // CPNJ

    await tester.pumpWidget(boilerplate(formatter, textController));
    await tester.enterText(find.byType(TextField), '12345678900');
    expect(textController.text, '123.456.789-00');
    await tester.enterText(find.byType(TextField), '123456789000');
    expect(textController.text, '12.345.678/9000');
    await tester.enterText(find.byType(TextField), '1234567890009');
    expect(textController.text, '12.345.678/9000-9');
    await tester.enterText(find.byType(TextField), '12345678900099');
    expect(textController.text, '12.345.678/9000-99');
  });
}
