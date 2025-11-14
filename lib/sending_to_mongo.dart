import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String? mongodbUsername = dotenv.env['mongoDB_username'];
final String? mongodbPassword = dotenv.env['mongoDB_password'];

const String databaseName = "appFlutter";
const nomeColecao = "CoinHistory";

final stringConexaoDB = "mongodb+srv://$mongodbUsername:$mongodbPassword@cluster.1i6ypbc.mongodb.net/$databaseName?retryWrites=true&w=majority";

Future<void> enviarDadosMongo(String email, String password) async {
  Db? db;
  try {
    db = await Db.create(stringConexaoDB);
    await db.open();

    var collection = db.collection(nomeColecao);

    final dadosLoginUsuario = {
      'email': email,
      'senha': password,
      'data_registro': DateTime.now().toIso8601String(),
    };

    await collection.insertOne(dadosLoginUsuario);
    print("Dados inseridos no MongoDB: $email");
  } catch (e) {
    print("Erro ao conectar ou inserir no MongoDB: $e");
    rethrow;
  } finally {
    if (db != null && db.isConnected) {
      await db.close();
    }
  }
}