import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'api/user.dart';

class RegisterPrompt extends StatefulWidget {
  const RegisterPrompt({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterPromptState();
  }
}

class _RegisterPromptState extends State<RegisterPrompt> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordValidationController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _cityController = TextEditingController();
  bool _isFormInError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordValidationController.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    _addressController.dispose();
    _postalCodeController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  bool _validatePasswordValidation(String password, String passwordValidation) {
    return password == passwordValidation;
  }

  Future _submitForm(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _isFormInError = true;
      });
      return;
    }

    final navigator = Navigator.of(context);
    final responseCode = await registerUser(
        _firstNameController.text,
        _lastNameController.text,
        _emailController.text,
        _addressController.text,
        _postalCodeController.text,
        _cityController.text,
        _passwordController.text);
    if (!mounted) return;

    if (responseCode == 201) {
      navigator.pushNamed('/loginPage');
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
            body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                    key: _formKey,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Inscrivez-vous pour ecouter votre musique en illimite !",
                          style: TextStyle(
                              fontFamily: 'DiamondSmith', fontSize: 32),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: _isFormInError ? 20 : 0),
                        Text(
                          _isFormInError ? 'Erreur lors de l\'inscription' : '',
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                controller: _lastNameController,
                                decoration: const InputDecoration(
                                  hintText: 'Nom',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer un nom';
                                  } else if (!RegExp(r'^[a-zA-Z]+$')
                                      .hasMatch(value)) {
                                    return 'Nom invalide';
                                  }
                                  return null;
                                },
                              )),
                              const SizedBox(width: 20),
                              Expanded(
                                  child: TextFormField(
                                controller: _firstNameController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Prenom',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer un prénom';
                                  } else if (!RegExp(r'^[a-zA-Z]+$')
                                      .hasMatch(value)) {
                                    return 'Prénom invalide';
                                  }
                                  return null;
                                },
                              ))
                            ],
                          ),
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
                            controller: _addressController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Adresse',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer une adresse';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                controller: _cityController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Ville',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer une ville';
                                  } else if (!RegExp(r'^[a-zA-Z]+$')
                                      .hasMatch(value)) {
                                    return 'Ville invalide';
                                  }
                                  return null;
                                },
                              )),
                              const SizedBox(width: 20),
                              Expanded(
                                  child: TextFormField(
                                controller: _postalCodeController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Code Postal',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer un code postal';
                                  } else if (!RegExp('^[0-9]{5}\$')
                                      .hasMatch(value)) {
                                    return 'Code postal invalide';
                                  }
                                  return null;
                                },
                              ))
                            ],
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
                              } else if (!RegExp(
                                      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$')
                                  .hasMatch(value)) {
                                return 'Mot de passe invalide';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: _passwordValidationController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Confirmation Mot de passe',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez confirmer le mot de passe';
                              } else if (!_validatePasswordValidation(
                                  _passwordController.text, value)) {
                                return 'Les mots de passe ne correspondent pas';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _submitForm(context),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: const Text('Inscription',
                              style: TextStyle(color: Colors.black)),
                        ),
                        const SizedBox(height: 20),
                        const Text("Vous avez déjà un compte ?",
                            style: TextStyle(fontSize: 16)),
                        RichText(
                          text: TextSpan(
                              text: "Cliquez ICI pour vous connecter",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.green),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, '/loginPage');
                                }),
                        ),
                      ],
                    ))))));
  }
}
