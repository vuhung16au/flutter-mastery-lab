import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class ConvexBottomBarDemo extends StatefulWidget {
  const ConvexBottomBarDemo({super.key});

  @override
  State<ConvexBottomBarDemo> createState() => _ConvexBottomBarDemoState();
}

class _ConvexBottomBarDemoState extends State<ConvexBottomBarDemo> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 64, color: Colors.blue),
          SizedBox(height: 16),
          Text('Home Page', style: TextStyle(fontSize: 24)),
        ],
      ),
    ),
    const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64, color: Colors.green),
          SizedBox(height: 16),
          Text('Search Page', style: TextStyle(fontSize: 24)),
        ],
      ),
    ),
    const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite, size: 64, color: Colors.red),
          SizedBox(height: 16),
          Text('Favorites Page', style: TextStyle(fontSize: 24)),
        ],
      ),
    ),
    const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 64, color: Colors.orange),
          SizedBox(height: 16),
          Text('Profile Page', style: TextStyle(fontSize: 24)),
        ],
      ),
    ),
    const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.settings, size: 64, color: Colors.purple),
          SizedBox(height: 16),
          Text('Settings Page', style: TextStyle(fontSize: 24)),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Convex Bottom Bar Demo'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.search, title: 'Search'),
          TabItem(icon: Icons.favorite, title: 'Favorites'),
          TabItem(icon: Icons.person, title: 'Profile'),
          TabItem(icon: Icons.settings, title: 'Settings'),
        ],
        initialActiveIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.blue,
        activeColor: Colors.white,
        color: Colors.white70,
        // Note: TabStyle.fixed requires odd number of items
        // TabStyle.react works with any number of items
        style: TabStyle.fixed,
        elevation: 8,
        cornerRadius: 20,
      ),
    );
  }
}
