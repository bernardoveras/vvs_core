# **VVS Core** [![pub package](https://img.shields.io/pub/v/vvs_core.svg)](https://pub.dev/packages/vvs_core)

Pacote utilizado nos projetos Flutter da empresa [VVS Sistemas](https://vvssistemas.com.br)).

**Obs:** É recomendado que utilize este package somente nos projetos da empresa VVS Sistemas.

## **Instalação**

### 1. Dependência

Adicione isto ao arquivo `pubspec.yaml` do seu pacote:

```yaml
dependencies:
    vvs_core: ^version
```

#### 2. Instalação

Você pode instalar pacotes a partir da linha de comando:

```bash
$ flutter pub get
..
```

#### 3. Importação

Agora em seu código Dart, você pode usar:

```Dart
import 'package:vvs_core/vvs_core.dart';
```

## Dependências utilizadas:

As dependências que este projeto utiliza são:

1. shared_preferences: Armazenar dados localmente no local storage do dispositivo.

2. dio: Executar requisições HTTP.

3. uuid: Gerar GUID's.

4. equatable: Igualdade entre classes.

5. animate_do: Animações facilitadas.

6. google_fonts: Fontes do Google.

7. intl: Internacionalização.

8. flutter_hooks: Gerenciar ciclos de vida de widget's.

9. package_info_plus: Obter informações nativas do aplicativo.

10. connectivity_plus: Verificar conexão com a internet.

## Utilidades do pacote

Todas as features existentes no pacote são:

### Utils:

1. copyToClipboard: Utilitário para copiar algum texto.

2. ExcludeGlowScrollBehavior: Widget para remover efeito de glow na rolagem das listas.

3. generateGuid: Gerar GUIDS.

4. getClipboardData: Obter texto copiado do clipboard.

5. hideKeyboard: Utilitário para fechar o teclado.

6. keyboardIsOpened: Utilitário para verificar se o teclado está aberto.

7. Resulter: Classe para separar o caso de sucesso e erro em uma única classe.

8. formatCurrency: Utilitário para formatar números para o formato -> "R$ 9.999,99".

9. formatDate: Utilitário para formatar datas.

10. formatDecimal: Utilitário para formatar números para o formato -> "1.000.000,00".

11. formatPercentage: Utilitário para formatar números para o formato -> "10%".

12. formatTelefone: Utilitário para formatar strings para o formato -> "(xx) xxxxx-xxxx".

13. CepHelper: Helper para validar, formatar e remover carácteres do CEP.

14. CnpjHelper: Helper para validar, formatar, gerar e remover carácteres do CNPJ.

15. CpfCnpjHelper: Helper para validar, formatar e remover carácteres do CPF ou CNPJ.

16. TelefoneHelper: Helper para formatar e remover carácteres do Telefone.

17. CentavosInputFormatter: Input formatter para formatar moedas com centavos em Text Field's.

18. CepInputFormatter: Input formatter para formatar cep's em Text Field's.

19. CnpjInputFormatter: Input formatter para formatar cnpj's em Text Field's.

20. CpfInputFormatter: Input formatter para formatar cpf's em Text Field's.

21. CpfOuCnpjFormatter: Input formatter para formatar cpf's ou cnpj's em Text Field's.

22. DataInputFormatter: Input formatter para formatar datas em Text Field's.

23. PlacaVeiculoInputFormatter: Input formatter para formatar placas de veículos em Text Field's.

24. RealInputFormatter: Input formatter para formatar moedas em Text Field's.

25. TelefoneInputFormatter: Input formatter para formatar telefones em Text Field's.

### Shared

1. BaseHookView: Classe para criar views (páginas) com viewmodels utilizando o pacote "flutter_hooks".

2. BaseView: Classe para criar views com viewmodels.

3. BaseViewModel: Classe para criar viewmodels.

### Services

1. FlutterDialogService: Serviço utilizado para exibir dialog's.
    - Este serviço não utiliza nenhum pacote externo para exibição de dialog's, para utilizar siga os passos que estão no arquivo "flutter_dialog_service.dart".

2. VvsSistemasDioAdapter: Adaptador do HTTP Client para requisições para api's com o padrão de response da VVS Sistemas.

3. InternetConnectivityPlusService: Serviço utilizado para verificar conexão com internet.
    - Este serviço utiliza o pacote "connectivity_plus".

4. SharedPreferencesLocalStorageService: Serviço utilizado para ler, salvar e deletar dados do local storage do dispositivo.

### Extensões

1. double_extension:
    1. arredondar: Arrendondar números em casas decimais.
    2. casoForZero: Retorna um valor X caso o valor atual for zero.
    3. getValueOrDefault: Retornar um valor X caso o valor atual for nulo.

2. list_extensions:
    1. sumBy: Somar alguma propriedade da lista.
    2. separarComVirgulas: Separar valores por virgulas
        - Exemplo: ['VVS Sistemas', 'Google'] = "VVS Sistemas, Google".

3. string_extensions: 
    1. whereNullOrEmpty: Retorna um valor caso for nulo ou vazio.
    2. toDateTime: Retorna um DateTime a partir de uma String.
        - O formato da string deve ser "dia/mês/ano".
    3. capitalize: Capitalização da String
        - Exemplo: "texto exemplo PARA CAPITALIZAÇÃO" = "Texto exemplo para capitalização"
    4. removeWhitespace: Remove todos os espaços em branco da String.
    5. contemNumero: Verifica se a string contém números.
    6. contemCaracterEspecial: Verifica se a string contém carácteres especiais.
    7. isInstagramUser: Verifica se a string começa com "@".

### Componentes

1. CircularLoader
2. TooltipSpan: Text.rich com Tooltip.
3. VvsButton: Botão padrão dos app's.
4. VvsIconButton: Botão padrão com ícone dos app's.