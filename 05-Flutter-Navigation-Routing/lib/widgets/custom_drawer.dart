import 'package:flutter/material.dart';
import '../models/navigation_item.dart';

class CustomDrawer extends StatelessWidget {
  final List<NavigationItem> navigationItems;
  final String currentRoute;

  const CustomDrawer({
    super.key,
    required this.navigationItems,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flutter Navigation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Routing Demo',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ...navigationItems.map((item) => _buildDrawerItem(context, item)),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, NavigationItem item) {
    final isSelected = currentRoute == item.route;
    
    return ListTile(
      leading: Icon(
        _getIconData(item.iconName),
        color: isSelected ? Theme.of(context).colorScheme.primary : null,
      ),
      title: Text(
        item.title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Theme.of(context).colorScheme.primary : null,
        ),
      ),
      selected: isSelected,
      onTap: () {
        Navigator.pop(context); // Close drawer
        if (item.route != currentRoute) {
          Navigator.pushReplacementNamed(context, item.route);
        }
      },
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
