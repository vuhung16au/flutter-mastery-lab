import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabbed Navigation'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: 'Home'),
            Tab(icon: Icon(Icons.business), text: 'Business'),
            Tab(icon: Icon(Icons.school), text: 'School'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _HomeTab(),
          _BusinessTab(),
          _SchoolTab(),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 100, color: Colors.blue),
          SizedBox(height: 20),
          Text(
            'Home Tab',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'This is the home tab content',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _BusinessTab extends StatelessWidget {
  const _BusinessTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.business, size: 100, color: Colors.green),
          SizedBox(height: 20),
          Text(
            'Business Tab',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'This is the business tab content',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _SchoolTab extends StatelessWidget {
  const _SchoolTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.school, size: 100, color: Colors.orange),
          SizedBox(height: 20),
          Text(
            'School Tab',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'This is the school tab content',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
