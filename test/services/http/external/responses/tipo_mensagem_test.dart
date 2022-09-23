import 'package:flutter_test/flutter_test.dart';
import 'package:vvs_core/services/http/external/responses/tipo_mensagem.dart';

void main() {
  test('Deve retornar o valor da categoria', () {
    var tipo = TipoMensagem.alerta;
    expect(tipo.value, 0);

    tipo = TipoMensagem.sucesso;
    expect(tipo.value, 1);

    tipo = TipoMensagem.erro;
    expect(tipo.value, 2);

    tipo = TipoMensagem.erroCritico;
    expect(tipo.value, 3);

    tipo = TipoMensagem.info;
    expect(tipo.value, 4);

    tipo = TipoMensagem.erroPermissaoNegada;
    expect(tipo.value, 5);
  });

  test('Deve retornar uma categoria a partir de um int', () {
    var tipo = 0;
    expect(tipo.tipoMensagem, TipoMensagem.alerta);

    tipo = 1;
    expect(tipo.tipoMensagem, TipoMensagem.sucesso);

    tipo = 2;
    expect(tipo.tipoMensagem, TipoMensagem.erro);

    tipo = 3;
    expect(tipo.tipoMensagem, TipoMensagem.erroCritico);

    tipo = 4;
    expect(tipo.tipoMensagem, TipoMensagem.info);

    tipo = 5;
    expect(tipo.tipoMensagem, TipoMensagem.erroPermissaoNegada);
  });
}
