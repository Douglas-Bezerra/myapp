import 'package:flutter/material.dart';
import 'package:myapp/controllers/sqflite_controller.dart';
import 'package:myapp/models/users_model.dart';
import 'package:myapp/views/tela_login.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _fazerRegistro() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final senha = _passwordController.text.trim();

    final controller = SqfliteController.instance;
    final usuarios = await controller.getUsers();

    // Verifica se o e-mail já existe
    final existe = usuarios.any(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
    );

    if (existe) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Este e-mail já está cadastrado.")),
      );
      return;
    }

    // Criar objeto usuário
    User novo = User(email: email, password: senha);

    // Inserir no banco
    await controller.insertUser(novo);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Cadastro realizado com sucesso!")),
    );

    // Voltar para a tela de login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TelaLogin()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                    height: 100,
                    width: 100,
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(45.0),
                  child: Text(
                    'Bem Vindo! Crie sua conta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 27, 48, 141),
                    ),
                  ),
                ),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Informe seu email";
                    }
                    if (!value.contains("@") || !value.contains(".")) {
                      return "Email inválido";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16.0),

                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Informe sua senha";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 40.0),

                ElevatedButton(
                  onPressed: _fazerRegistro,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    textStyle: const TextStyle(fontSize: 18),
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Criar Conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}