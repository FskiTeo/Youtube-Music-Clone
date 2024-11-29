import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'api/user.dart';

class LoginPrompt extends StatefulWidget {
  const LoginPrompt({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPromptState();
  }
}

class _LoginPromptState extends State<LoginPrompt> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isFormInError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future _submitForm(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _isFormInError = true;
      });
      return;
    }

    final navigator = Navigator.of(context);
    final responseCode = await loginUser(
      _emailController.text,
      _passwordController.text,
    );

    print(responseCode);
    
    if (responseCode == 200) {
      _isFormInError = false;
      _emailController.clear();
      _passwordController.clear();
      navigator.pushNamed('/');
      return;
    } else {
      setState(() {
        _isFormInError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Connectez-vous pour ecouter votre musique en illimite !",
                          style: TextStyle(
                              fontFamily: 'DiamondSmith', fontSize: 32),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: _isFormInError ? 20 : 0),
                        Text(
                          _isFormInError ? 'Erreur lors du login' : '',
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Email',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer un email';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Email invalide';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Mot de passe',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer un mot de passe';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _submitForm(context),
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.green)),
                          child: const Text('Connexion',
                              style: TextStyle(color: Colors.black)),
                        ),
                        const SizedBox(height: 20),
                        const Text("Vous n'avez pas encore de comtpe ?",
                            style: TextStyle(fontSize: 16)),
                        RichText(
                          text: TextSpan(
                              text: "Cliquez ICI pour vous inscrire",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.green),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, '/registerPage');
                                }),
                        )
                      ],
                    )))));
  }
}
