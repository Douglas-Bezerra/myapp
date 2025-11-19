import 'package:flutter/material.dart';
import 'package:myapp/controllers/sqflite_controller.dart';
import 'package:myapp/views/tela_conversao.dart';
import 'package:myapp/views/tela_cadastro.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _fazerAutenticacao() async {
    if (_formKey.currentState!.validate()) {
      
      final email = _emailController.text.trim();
      final senha = _passwordController.text.trim();

      final controller = SqfliteController.instance;
      final usuarios = await controller.getUsers();

      // Verificando se existe email
      final user = usuarios.where((u) => u.email == email).firstOrNull;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email não encontrado")),
        );
        return;
      }

      if (user.password != senha) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Senha incorreta")),
        );
        return;
      }
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TelaConversao(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                    height: 100,
                    width: 100,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(45.0),
                  child: Text(
                    'Faça seu Login!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 27, 48, 141),
                    ),
                  ),
                ),

                // EMAIL
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 226, 135, 0),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Informe seu email";
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return "Email inválido";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16.0),

                // SENHA
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 226, 135, 0),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Informe sua senha";
                    }
                    if (value.length < 4) {
                      return "A senha deve ter ao menos 4 caracteres";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 40.0),

                ElevatedButton(
                  onPressed: _fazerAutenticacao,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    textStyle: const TextStyle(fontSize: 18),
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('ENTRAR'),
                ),

                const SizedBox(height: 10.0),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TelaCadastro(),
                      ),
                    );
                  },
                  child: const Text(
                    "Não possui conta? Faça seu cadastro.",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 33, 150),
                      fontSize: 17.0,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
