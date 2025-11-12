import "package:mongo_dart/mongo_dart.dart";

void conexaoMongo() async {

  String stringConexaoDB = "mongodb+srv://<user>:<password>@test-asdf.mongodb.net/test?retryWrites=true&w=majority";
  Db? db; // Torna Db anulável e inicializa como null

  try {
    print("Tentando conectar a: $stringConexaoDB");
    
    db = await Db.create(stringConexaoDB);
    await db.open();

    print("Conexão com MongoDB estabelecida com sucesso 🟢");
    print(db);

    // --- Execute suas operações de banco de dados aqui (ex: query, insert) ---
    // Exemplo:
    // var collection = db.collection('minha_colecao');
    // var result = await collection.find().toList();
    // print("Foram encontrados ${result.length} documentos.");
    
  } catch (e) {
    print("Ocorreu um erro durante a conexão 🔴 $e");
  } finally {
    if (db != null && db.isConnected) {
      await db.close();
      print("🔌 Conexão com o banco de dados fechada.");
    }
  }
}