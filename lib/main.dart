import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'profile.dart';
import 'register.dart';
import 'login.dart';
import 'components/bottomNavBar.dart';

void main() async{
  await dotenv.load(fileName: ".env");

  runApp(const MainApp());  
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green, brightness: Brightness.dark),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const Accueil(),
          '/loginPage': (context) => const LoginPrompt(),
          '/registerPage': (context) => const RegisterPrompt(),
          '/profile': (context) => const Profile(),
        });
  }
}

class Accueil extends StatelessWidget {
  const Accueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Bottomnavbar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Bienvenue sur notre application',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/loginPage');
              },
              child: const Text('Se connecter'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/registerPage');
              },
              child: const Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}
