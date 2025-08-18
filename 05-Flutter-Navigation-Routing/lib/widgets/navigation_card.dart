import 'package:flutter/material.dart';

class NavigationCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final bool isEnabled;

  const NavigationCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor ?? Colors.blue,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isEnabled ? null : Colors.grey,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            color: isEnabled ? null : Colors.grey,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: isEnabled ? onTap : null,
      ),
    );
  }
}
