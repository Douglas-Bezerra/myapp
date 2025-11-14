import "package:mongo_dart/mongo_dart.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';

void conexaoMongo() async {
  final String? mongodbUsername = dotenv.env['mongoDB_username'];
  final String? mongodbPassword = dotenv.env['mongoDB_password'];

  const String databaseName = "appFlutter";

  if (mongodbUsername == null || mongodbPassword == null) {
    print("Erro: Variáveis de ambiente MONGO_DB_USERNAME ou MONGO_DB_PASSWORD não encontradas.",
    );
    return;
  }

  String stringConexaoDB = "mongodb+srv://$mongodbUsername:$mongodbPassword@cluster.1i6ypbc.mongodb.net/$databaseName?retryWrites=true&w=majority";

  Db? db; // Torna Db anulável e inicializa como null

  try {
    print("Tentando conectar com o banco de dados");

    db = await Db.create(stringConexaoDB);
    await db.open();

    print("Conexão com MongoDB estabelecida com sucesso 🟢");
    print(db);
  } catch (e) {
    print("Ocorreu um erro durante a conexão 🔴 $e");
  } finally {
    if (db != null && db.isConnected) {
      await db.close();
      print("Conexão com o banco de dados fechada ❌");
    }
  }
}