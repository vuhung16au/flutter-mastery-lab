import 'package:flutter/material.dart';

class AvoidingJankPage extends StatefulWidget {
  const AvoidingJankPage({super.key});

  @override
  State<AvoidingJankPage> createState() => _AvoidingJankPageState();
}

class _AvoidingJankPageState extends State<AvoidingJankPage> {
  List<String> _items = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate heavy computation
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _items = List.generate(100, (index) => 'Item ${index + 1}');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avoiding Jank'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_items[index]),
                  subtitle: Text('This is item number ${index + 1}'),
                );
              },
            ),
    );
  }
}
