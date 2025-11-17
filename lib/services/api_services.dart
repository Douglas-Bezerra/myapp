import "dart:convert";
import "dart:developer";
import "package:http/http.dart" as http;
import "package:myapp/models/cotacoes_model.dart";

class ApiServices {
  static Future<CotacoesModel> conversorMoedas({
    required String code,
    required String codein,
  }) async {
    String endpoint = "https://economia.awesomeapi.com.br/json/last/$code-$codein?token=f8b71d9c7d6e60dcffeacc01c2c9a69f6bb05858955d7c0d4c5dc4b0d63954f4";
    final resposta = await http.get(Uri.parse(endpoint));

    if (resposta.statusCode == 200) {
      log(resposta.body);

      final Map<String, dynamic> jsonResponse = jsonDecode(resposta.body);

      if (jsonResponse.isNotEmpty) {
        final String key = jsonResponse.keys.first;
        final Map<String, dynamic> dadosCotacao = jsonResponse[key];

        return CotacoesModel.fromJson(dadosCotacao);
      } else {
        throw Exception("Resposta da API vazia.");
      }
    } else {
      throw Exception(
        "Falha na conexão com a API. Status Code: ${resposta.statusCode}",
      );
    }
  }
}