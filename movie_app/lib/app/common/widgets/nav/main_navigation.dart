import 'package:flutter/material.dart';
import 'package:movie_app/app/modules/movies/screens/movie_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    MovieScreen(key: ValueKey('/movie')),
    Center(
      key: ValueKey('series'),
      child: Text("📂 Series",
          style: TextStyle(fontSize: 22, color: Colors.white)),
    ),
    Center(
      key: ValueKey('favorite'),
      child: Text("⭐ Favorite",
          style: TextStyle(fontSize: 22, color: Colors.white)),
    ),
    Center(
      key: ValueKey('profile'),
      child: Text("👤 Profile",
          style: TextStyle(fontSize: 22, color: Colors.white)),
    ),
  ];

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.movie_creation_rounded),
      label: "Movies",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.tv_rounded),
      label: "Series",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.star_rounded),
      label: "Favorites",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_rounded),
      label: "Profile",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 13,
        unselectedFontSize: 12,
        onTap: (index) => setState(() => _currentIndex = index),
        items: _navItems,
      ),
    );
  }
}
