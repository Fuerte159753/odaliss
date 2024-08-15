import 'package:flutter/material.dart';
import 'package:food_app/base/base.dart';
import 'package:food_app/models/usuario.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

Future<void> _login() async {
  setState(() {
    _autoValidateMode = AutovalidateMode.onUserInteraction;
  });

  if (_formKey.currentState!.validate()) {
    String email = emailController.text;
    String password = passwordController.text;

    // Mostrar animación de carga
    showDialog(
      context: context,
      barrierDismissible: false, // Evitar que el diálogo se cierre al hacer clic fuera de él
      builder: (BuildContext context) {
        return Center(
          child: LoadingAnimationWidget.fourRotatingDots(
            color: Colors.white,
            size: 100,
          ),
        );
      },
    );

    try {
      Usuario? user = await DatabaseHelper().login(email, password);

      await Future.delayed(const Duration(seconds: 1)); // Añadir un retraso de 1 segundo

      Navigator.of(context).pop(); // Cerrar la animación de carga

      if (user == null) {
        if (await DatabaseHelper().correoExiste(email)) {
          _showAlert('Verifica tu contraseña');
        } else {
          _showAlert('El correo electrónico no está registrado');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inicio de sesión exitoso')),
        );
        Navigator.pushReplacementNamed(
          context,
          '/inicio',
          arguments: user.id,
        );
      }
    } catch (e) {
      Navigator.of(context).pop(); // Cerrar la animación de carga si hay un error
      _showAlert('No se pudo conectar con la base de datos. Intenta nuevamente más tarde.');
    }
  }
}
  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: _formKey,
              autovalidateMode: _autoValidateMode,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/logo.png',
                    width: 300,
                    height: 300,
                  ),
                 const Text(
                    'RESTORANT-FOOD',
                    style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Lobster',
                    fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person, color: Colors.white),
                      labelText: 'Correo',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu correo electrónico';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock, color: Colors.white),
                      labelText: 'Contraseña',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu contraseña';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  GestureDetector(
                    onTap: _login,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Entrar',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/registro');
                    },
                    child: const Text(
                      'No estas registrado? Crea una cuenta aquí',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}