import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'api/songs.dart';
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

class DotIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;

  const DotIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == index ? Colors.white : Colors.grey,
          ),
        );
      }),
    );
  }
}
class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  List songs = [];
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    fetchSongs();
  }

  void fetchSongs() async {
    var data = await getMostListenedSongList(3);
    setState(() {
      songs = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Bottomnavbar(),
      body: SafeArea(
        child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
          'Vos chansons les plus écoutées',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                });
              },
              itemCount: (songs.length / 9).ceil(),
              itemBuilder: (context, pageIndex) {
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    final songIndex = pageIndex * 9 + index;
                    if (songIndex >= songs.length) return const SizedBox();
                    final album = songs[songIndex]['album'];
                    return Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.memory(
                              base64Decode(album['cover_image_base64'].split(',')[1]),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            album['title'],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),)
    );
  }
}