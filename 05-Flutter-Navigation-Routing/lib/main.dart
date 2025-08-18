import 'package:flutter/material.dart';

// Import all screen files
import 'screens/home_screen.dart';
import 'screens/basic_navigation_page.dart';
import 'screens/named_routes_page.dart';
import 'screens/arguments_page.dart';
import 'screens/return_data_page.dart';
import 'screens/urls_page.dart';
import 'screens/text_fields_page.dart';
import 'screens/websockets_page.dart';
import 'screens/avoiding_jank_page.dart';
import 'screens/http_operations_page.dart';
import 'screens/send_data_page.dart';
import 'screens/route_settings_page.dart';
import 'screens/tabs_screen.dart';
import 'screens/drawer_navigation_screen.dart';
import 'screens/deep_linking_screen.dart';
import 'screens/app_links_screen.dart';
import 'screens/url_strategies_screen.dart';

void main() {
  runApp(const NavigationApp());
}

// Main App with Named Routes
class NavigationApp extends StatelessWidget {
  const NavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation & Routing Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Named Routes Configuration
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/basic-navigation': (context) => const BasicNavigationPage(),
        '/named-routes': (context) => const NamedRoutesPage(),
        '/arguments': (context) => const ArgumentsPage(),
        '/return-data': (context) => const ReturnDataPage(),
        '/urls': (context) => const URLsPage(),
        '/text-fields': (context) => const TextFieldsPage(),
        '/websockets': (context) => const WebSocketsPage(),
        '/avoiding-jank': (context) => const AvoidingJankPage(),
        '/http-operations': (context) => const HttpOperationsPage(),
        '/send-data': (context) => const SendDataPage(),
        '/route-settings': (context) => const RouteSettingsPage(),
        '/tabs': (context) => const TabsScreen(),
        '/drawer-navigation': (context) => const DrawerNavigationScreen(),
        '/deep-linking': (context) => const DeepLinkingScreen(),
        '/app-links': (context) => const AppLinksScreen(),
        '/url-strategies': (context) => const UrlStrategiesScreen(),
      },
    );
  }
}
