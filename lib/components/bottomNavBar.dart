import 'package:flutter/material.dart';

class Bottomnavbar extends StatelessWidget {
  const Bottomnavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Recherche',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Profile'
        ),
      ],
      onTap: (index) {
        if (index == 0) { // Index 0 corresponds to the Home tab
          Navigator.pushNamed(context, '/');
        } else if (index == 1) { // Index 1 corresponds to the Search tab
          Navigator.pushNamed(context, '/search');
        } else if (index == 2) { // Index 2 corresponds to the Profile tab
          Navigator.pushNamed(context, '/profile');
        }
      },
    );
  }
}
