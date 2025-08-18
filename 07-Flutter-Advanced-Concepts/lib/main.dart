import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'providers/app_provider.dart';
import 'pages/api_page.dart';
import 'pages/communication_page.dart';
import 'pages/wakelock_page.dart';
import 'services/communication_service.dart';

// Main App
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'Sydney Advanced Concepts',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    ApiPage(),
    CommunicationPage(),
    WakelockPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sydney Advanced Concepts'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.http),
            label: 'API',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'Communication',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),
            label: 'Wakelock',
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        activeBackgroundColor: Colors.red,
        activeForegroundColor: Colors.white,
        buttonSize: const Size(56.0, 56.0),
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        elevation: 8.0,
        shape: const CircleBorder(),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.email),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            label: 'Email',
            onTap: () => _sendEmail(),
          ),
          SpeedDialChild(
            child: const Icon(Icons.phone),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'Call',
            onTap: () => _makeCall(),
          ),
          SpeedDialChild(
            child: const Icon(Icons.message),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            label: 'SMS',
            onTap: () => _sendSMS(),
          ),
        ],
      ),
    );
  }

  void _sendEmail() async {
    try {
      await CommunicationService.sendEmail(
        to: 'sydney@example.com',
        subject: 'Hello from Sydney',
        body: 'This email was sent from Sydney using the speed dial feature!',
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sydney email app opened')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _makeCall() async {
    try {
      await CommunicationService.makeCall('+61212345678');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sydney phone app opened')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _sendSMS() async {
    try {
      await CommunicationService.sendSMS(
        phoneNumber: '+61212345678',
        message: 'Hello from Sydney!',
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sydney SMS app opened')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}

