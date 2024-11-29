import 'package:flutter/material.dart';
import 'components/bottomNavBar.dart';
import 'utils/secure_storage.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  final _storage = SecureStorage();
  String? _token;

  @override
  void initState() {
    super.initState();
    _storage.readToken().then((token) {
      setState(() {
        _token = token;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const Bottomnavbar(),
        body: Center(
          child: _token == null
              ? const Text('Vous n\'êtes pas connecté')
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Vous êtes connecté'),
                    ElevatedButton(
                      onPressed: () async {
                        await _storage.deleteToken();
                        setState(() {
                          _token = null;
                        });
                      },
                      child: const Text('Se déconnecter'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}