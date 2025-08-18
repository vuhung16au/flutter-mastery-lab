import 'package:flutter/material.dart';
import '../widgets/navigation_card.dart';
import '../models/navigation_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationItems = [
      const NavigationItem(
        title: 'Basic Navigation',
        description: 'Basic navigation using Navigator.push() and Navigator.pop()',
        route: '/basic-navigation',
        iconName: 'navigation',
      ),
      const NavigationItem(
        title: 'Named Routes',
        description: 'Using named routes for navigation',
        route: '/named-routes',
        iconName: 'route',
      ),
      const NavigationItem(
        title: 'Arguments in Named Routes',
        description: 'Passing data through named routes',
        route: '/arguments',
        iconName: 'data_object',
      ),
      const NavigationItem(
        title: 'Return Data from Screen',
        description: 'Getting data back from navigated screens',
        route: '/return-data',
        iconName: 'arrow_back',
      ),
      const NavigationItem(
        title: 'Send Data to Screen',
        description: 'Passing data between screens',
        route: '/send-data',
        iconName: 'send',
      ),
      const NavigationItem(
        title: 'Route Settings',
        description: 'Using RouteSettings for data passing',
        route: '/route-settings',
        iconName: 'settings',
      ),
      const NavigationItem(
        title: 'Tabbed Navigation',
        description: 'Using TabBar and TabBarView for tab navigation',
        route: '/tabs',
        iconName: 'tabs',
      ),
      const NavigationItem(
        title: 'Drawer Navigation',
        description: 'Custom drawer navigation implementation',
        route: '/drawer-navigation',
        iconName: 'drawer',
      ),
      const NavigationItem(
        title: 'Deep Linking',
        description: 'Handling custom URL schemes and deep links',
        route: '/deep-linking',
        iconName: 'deep_link',
      ),
      const NavigationItem(
        title: 'App Links & Universal Links',
        description: 'Android App Links and iOS Universal Links',
        route: '/app-links',
        iconName: 'link',
      ),
      const NavigationItem(
        title: 'URL Strategies',
        description: 'Path vs Hash URL strategies for web',
        route: '/url-strategies',
        iconName: 'link',
      ),
      const NavigationItem(
        title: 'URLs in Flutter',
        description: 'Working with URLs and deep linking',
        route: '/urls',
        iconName: 'link',
      ),
      const NavigationItem(
        title: 'Retrieve Data From TextFields',
        description: 'Getting data from form inputs',
        route: '/text-fields',
        iconName: 'text_fields',
      ),
      const NavigationItem(
        title: 'WebSockets',
        description: 'Real-time communication with WebSockets',
        route: '/websockets',
        iconName: 'wifi',
      ),
      const NavigationItem(
        title: 'Avoiding Jank',
        description: 'Performance optimization techniques',
        route: '/avoiding-jank',
        iconName: 'speed',
      ),
      const NavigationItem(
        title: 'HTTP Operations',
        description: 'Fetching, sending, updating, and deleting data',
        route: '/http-operations',
        iconName: 'http',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Navigation & Routing'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Navigation & Routing Components',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'This comprehensive demo showcases Flutter\'s navigation and routing capabilities, '
              'including basic navigation, named routes, data passing, tabs, drawers, deep linking, '
              'and more advanced features.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ...navigationItems.map((item) => NavigationCard(
              title: item.title,
              description: item.description,
              icon: _getIconData(item.iconName),
              onTap: () => Navigator.pushNamed(context, item.route),
            )),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'home':
        return Icons.home;
      case 'navigation':
        return Icons.navigation;
      case 'route':
        return Icons.route;
      case 'data_object':
        return Icons.data_object;
      case 'arrow_back':
        return Icons.arrow_back;
      case 'link':
        return Icons.link;
      case 'text_fields':
        return Icons.text_fields;
      case 'wifi':
        return Icons.wifi;
      case 'speed':
        return Icons.speed;
      case 'http':
        return Icons.http;
      case 'send':
        return Icons.send;
      case 'settings':
        return Icons.settings;
      case 'tabs':
        return Icons.tab;
      case 'drawer':
        return Icons.menu;
      case 'deep_link':
        return Icons.link_off;
      default:
        return Icons.article;
    }
  }
}
