import 'package:flutter/material.dart';
import "package:myapp/sending_to_mongo.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _fazerLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        await enviarDadosMongo(email, password);
        

        print("Login bem-sucedido e dados enviados.");
      } catch (e) {
        print("Falha ao enviar dados de login: $e");
      }
    } else {
      print("Preencha todos os campos.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Image.asset('assets/logo.png', height: 100, width: 100),
              ),
              Padding(
                padding: const EdgeInsets.all(45.0),
                child: const Text(
                  'Faça seu Login!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 27, 48, 141),
                  ),
                ),
              ),

              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 226, 135, 0),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16.0),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 226, 135, 0),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40.0),

              ElevatedButton(
                onPressed: _fazerLogin,
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
            ],
          ),
        ),
      ),
    );
  }
}