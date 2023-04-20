// ignore_for_file: unused_import, library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'joke_provider.dart';
import 'home.dart';
import 'feed_page.dart';
import 'favorites_page.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'notifications_manager.dart';


Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  final notificationManager = NotificationManager();
  await notificationManager.initNotifications();
  await notificationManager.scheduleDailyNotification();
  // ignore: prefer_const_constructors
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JokeProvider(),
      child: MaterialApp(
        title: 'LA RIGOL APP',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        initialRoute: '/home',
        routes: {
          '/home': (context) => const MainPage(),
          '/feed': (context) => const FeedPage(),
          '/favorites': (context) => FavoritesPage(),
        },
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final _pages = [
    const HomePage(),
    const FeedPage(),
    FavoritesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LA RIGOL APP'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Fil d\'actualité',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.purple, // Couleur de l'élément sélectionné
        unselectedItemColor: Colors.grey, // Couleur de l'élément non sélectionné
        showUnselectedLabels: true, // Afficher les labels pour les éléments non sélectionnés
      ),
    );
  }
}
