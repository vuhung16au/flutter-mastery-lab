class NavigationItem {
  final String title;
  final String description;
  final String route;
  final String iconName;
  final bool isEnabled;

  const NavigationItem({
    required this.title,
    required this.description,
    required this.route,
    required this.iconName,
    this.isEnabled = true,
  });
}
