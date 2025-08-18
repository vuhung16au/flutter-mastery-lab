import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';
import '../models/navigation_item.dart';

class DrawerNavigationScreen extends StatelessWidget {
  const DrawerNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationItems = [
      const NavigationItem(
        title: 'Home',
        description: 'Main home screen',
        route: '/',
        iconName: 'home',
      ),
      const NavigationItem(
        title: 'Basic Navigation',
        description: 'Basic navigation examples',
        route: '/basic-navigation',
        iconName: 'navigation',
      ),
      const NavigationItem(
        title: 'Named Routes',
        description: 'Named routes demonstration',
        route: '/named-routes',
        iconName: 'route',
      ),
      const NavigationItem(
        title: 'Tabs',
        description: 'Tabbed navigation',
        route: '/tabs',
        iconName: 'tabs',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer Navigation'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: CustomDrawer(
        navigationItems: navigationItems,
        currentRoute: '/drawer-navigation',
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              'Drawer Navigation',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Swipe from left edge or tap the menu icon',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'This demonstrates how to implement a custom drawer',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
