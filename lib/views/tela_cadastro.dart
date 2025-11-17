import 'package:flutter/material.dart';
import 'package:myapp/services/api_services.dart';
import 'package:myapp/models/cotacoes_model.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<StatefulWidget> createState() => _TelaCadastro();
}

class _TelaCadastro extends State<TelaCadastro> {
  var _emailController = TextEditingController();
  var _senhaController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "De",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _senhaController,
                    decoration: const InputDecoration(
                      labelText: "Para",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _valueController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Valor",
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                ElevatedButton(
                  onPressed: () async {
                    try {
                      CotacoesModel dados = await ApiServices.conversorMoedas(
                        email: _emailController.text,
                        senha: _senhaController.text,
                      );

                      double valorOriginal = double.tryParse(_valueController.text) ?? 0.0;
                      double cotacaoAlta = double.tryParse(dados.high) ?? 0.0;
                      double resultado = valorOriginal * cotacaoAlta;

                      setState(() {
                        _highController.text = dados.high;
                        _lowController.text = dados.low;
                        _timestampController.text = dados.timestamp;
                        _createdateController.text = dados.createdate;
                        _resultController.text = resultado.toStringAsFixed(2);
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erro na API/Rede: ${e.toString()}'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                  child: const Text("Converter"),
                ),
              ],
            ),

            const SizedBox(height: 30),

            TextField(
              controller: _resultController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Resultado da Conversão",
                border: const OutlineInputBorder(),
              ),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            const SizedBox(height: 20),

            const Text("Detalhes da Cotação",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _highController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Alta",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _lowController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Baixa",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _timestampController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Timestamp (Epoch)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            TextField(
              controller: _createdateController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Data de Criação (UTC)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}