import 'package:flutter/material.dart';
import 'basic_widgets_page.dart';
import 'layout_widgets_page.dart';
import 'input_widgets_page.dart';
import 'list_widgets_page.dart';

// Home Page - Demonstrates Scaffold, AppBar, Drawer, BottomNavigationBar
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // List of pages to demonstrate different widgets
  final List<Widget> _pages = [
    const BasicWidgetsPage(),
    const LayoutWidgetsPage(),
    const InputWidgetsPage(),
    const ListWidgetsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar Widget demonstration
      appBar: AppBar(
        title: const Text('Sydney Widgets Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Welcome to Sydney!')),
              );
            },
          ),
        ],
      ),
      
      // Drawer Widget demonstration
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Sydney Widgets',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Basic Widgets'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.view_compact),
              title: const Text('Layout Widgets'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.input),
              title: const Text('Input Widgets'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('List Widgets'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 3);
              },
            ),
          ],
        ),
      ),
      
      body: _pages[_currentIndex],
      
      // FloatingActionButton demonstration
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sydney Harbour Bridge!')),
          );
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      
      // BottomNavigationBar Widget demonstration
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
            icon: Icon(Icons.widgets),
            label: 'Basic',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_compact),
            label: 'Layout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.input),
            label: 'Input',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lists',
          ),
        ],
      ),
    );
  }
}
