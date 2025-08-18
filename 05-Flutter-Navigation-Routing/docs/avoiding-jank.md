# Flutter - Avoiding Jank

## Overview
Avoiding jank (stuttering or frame drops) is crucial for providing smooth user experiences in Flutter applications. This component demonstrates performance optimization techniques to ensure consistent 60fps rendering and responsive UI interactions.

## Key Concepts

### 1. Loading States
Show loading indicators during async operations to prevent UI freezes.

### 2. Efficient Rendering
Use appropriate widgets for large lists and complex layouts.

### 3. State Management
Proper state updates to avoid unnecessary rebuilds and UI freezes.

## Implementation

### Basic Performance Optimization

#### Loading State Management
```dart
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
```

## Advanced Performance Patterns

### 1. Efficient List Rendering

#### ListView.builder vs ListView
```dart
class EfficientListPage extends StatefulWidget {
  const EfficientListPage({super.key});

  @override
  State<EfficientListPage> createState() => _EfficientListPageState();
}

class _EfficientListPageState extends State<EfficientListPage> {
  final List<String> _items = List.generate(1000, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Efficient List')),
      body: Column(
        children: [
          // Good: ListView.builder - only builds visible items
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_items[index]),
                  subtitle: Text('Subtitle for ${_items[index]}'),
                  trailing: Icon(Icons.arrow_forward),
                );
              },
            ),
          ),
          
          // Bad: ListView - builds all items at once
          // Expanded(
          //   child: ListView(
          //     children: _items.map((item) => ListTile(
          //       title: Text(item),
          //     )).toList(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
```

### 2. Image Optimization

#### Lazy Loading and Caching
```dart
class OptimizedImagePage extends StatefulWidget {
  const OptimizedImagePage({super.key});

  @override
  State<OptimizedImagePage> createState() => _OptimizedImagePageState();
}

class _OptimizedImagePageState extends State<OptimizedImagePage> {
  final List<String> _imageUrls = [
    'https://picsum.photos/200/200?random=1',
    'https://picsum.photos/200/200?random=2',
    'https://picsum.photos/200/200?random=3',
    // Add more URLs...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Optimized Images')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: _imageUrls.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    _imageUrls[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    // Add loading placeholder
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    // Add error handling
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.error, color: Colors.red),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Image ${index + 1}'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

### 3. Computationally Expensive Operations

#### Background Processing
```dart
import 'dart:isolate';

class HeavyComputationPage extends StatefulWidget {
  const HeavyComputationPage({super.key});

  @override
  State<HeavyComputationPage> createState() => _HeavyComputationPageState();
}

class _HeavyComputationPageState extends State<HeavyComputationPage> {
  bool _isComputing = false;
  String _result = '';

  Future<void> _performHeavyComputation() async {
    setState(() {
      _isComputing = true;
      _result = '';
    });

    try {
      // Perform heavy computation in background
      final result = await compute(_heavyComputation, 1000000);
      
      if (mounted) {
        setState(() {
          _result = 'Result: $result';
          _isComputing = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _result = 'Error: $e';
          _isComputing = false;
        });
      }
    }
  }

  static int _heavyComputation(int iterations) {
    int result = 0;
    for (int i = 0; i < iterations; i++) {
      result += i * i;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Heavy Computation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isComputing) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text('Computing...'),
            ] else ...[
              ElevatedButton(
                onPressed: _performHeavyComputation,
                child: const Text('Start Heavy Computation'),
              ),
              const SizedBox(height: 16),
              if (_result.isNotEmpty) Text(_result),
            ],
          ],
        ),
      ),
    );
  }
}
```

### 4. Memory Management

#### Proper Disposal of Resources
```dart
class MemoryOptimizedPage extends StatefulWidget {
  const MemoryOptimizedPage({super.key});

  @override
  State<MemoryOptimizedPage> createState() => _MemoryOptimizedPageState();
}

class _MemoryOptimizedPageState extends State<MemoryOptimizedPage> {
  late TextEditingController _textController;
  late ScrollController _scrollController;
  late AnimationController _animationController;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    // Always dispose controllers to prevent memory leaks
    _textController.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onTextChanged(String text) {
    // Debounce text changes to avoid excessive processing
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      // Process the text change
      print('Processing: $text');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memory Optimized')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _textController,
              onChanged: _onTextChanged,
              decoration: const InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: 100,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                  subtitle: Text('Description for item $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

## Performance Monitoring

### 1. Frame Rate Monitoring
```dart
class PerformanceMonitor extends StatefulWidget {
  final Widget child;
  
  const PerformanceMonitor({super.key, required this.child});

  @override
  State<PerformanceMonitor> createState() => _PerformanceMonitorState();
}

class _PerformanceMonitorState extends State<PerformanceMonitor>
    with WidgetsBindingObserver {
  int _frameCount = 0;
  DateTime? _lastFrameTime;
  double _fps = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startMonitoring();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _startMonitoring() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _frameCount++;
      final now = DateTime.now();
      
      if (_lastFrameTime != null) {
        final duration = now.difference(_lastFrameTime!);
        if (duration.inMilliseconds > 0) {
          _fps = 1000 / duration.inMilliseconds;
        }
      }
      
      _lastFrameTime = now;
      
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          top: 50,
          right: 16,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'FPS: ${_fps.toStringAsFixed(1)}\nFrames: $_frameCount',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
```

### 2. Memory Usage Monitoring
```dart
class MemoryMonitor extends StatelessWidget {
  const MemoryMonitor({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getMemoryInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Memory: ${snapshot.data}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Future<String> _getMemoryInfo() async {
    // This is a simplified example
    // In a real app, you might use platform-specific code to get actual memory usage
    return 'Memory info unavailable';
  }
}
```

## Best Practices

### 1. Widget Optimization
```dart
class OptimizedWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const OptimizedWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}

// Use const constructors when possible
class OptimizedList extends StatelessWidget {
  const OptimizedList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return const OptimizedWidget(
          title: 'Title',
          subtitle: 'Subtitle',
        );
      },
    );
  }
}
```

### 2. State Management Optimization
```dart
class OptimizedStatePage extends StatefulWidget {
  const OptimizedStatePage({super.key});

  @override
  State<OptimizedStatePage> createState() => _OptimizedStatePageState();
}

class _OptimizedStatePageState extends State<OptimizedStatePage> {
  int _counter = 0;
  String _text = '';
  bool _isVisible = true;

  void _incrementCounter() {
    // Only update what's necessary
    setState(() {
      _counter++;
    });
  }

  void _updateText(String newText) {
    // Avoid unnecessary setState calls
    if (_text != newText) {
      setState(() {
        _text = newText;
      });
    }
  }

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Optimized State')),
      body: Column(
        children: [
          if (_isVisible) ...[
            Text('Counter: $_counter'),
            Text('Text: $_text'),
          ],
          Row(
            children: [
              ElevatedButton(
                onPressed: _incrementCounter,
                child: const Text('Increment'),
              ),
              ElevatedButton(
                onPressed: _toggleVisibility,
                child: const Text('Toggle'),
              ),
            ],
          ),
          TextField(
            onChanged: _updateText,
            decoration: const InputDecoration(
              labelText: 'Enter text',
            ),
          ),
        ],
      ),
    );
  }
}
```

### 3. Animation Optimization
```dart
class OptimizedAnimationPage extends StatefulWidget {
  const OptimizedAnimationPage({super.key});

  @override
  State<OptimizedAnimationPage> createState() => _OptimizedAnimationPageState();
}

class _OptimizedAnimationPageState extends State<OptimizedAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Optimized Animation')),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: const Center(
                  child: Text('Animated', style: TextStyle(color: Colors.white)),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.status == AnimationStatus.completed) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
```

## Testing Performance

### 1. Performance Tests
```dart
testWidgets('list scrolls smoothly', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: AvoidingJankPage(),
    ),
  );

  // Wait for loading to complete
  await tester.pump(const Duration(seconds: 3));

  // Test scrolling performance
  await tester.fling(
    find.byType(ListView),
    const Offset(0, -500),
    3000,
  );

  await tester.pumpAndSettle();
});
```

### 2. Memory Leak Tests
```dart
testWidgets('no memory leaks on dispose', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MemoryOptimizedPage(),
    ),
  );

  // Navigate away and back multiple times
  for (int i = 0; i < 10; i++) {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: Text('Page $i')),
      ),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: MemoryOptimizedPage(),
      ),
    );
  }

  // If there are memory leaks, this might throw
  await tester.pumpAndSettle();
});
```

## Conclusion

Avoiding jank is essential for creating smooth, responsive Flutter applications. By implementing proper loading states, using efficient widgets, managing memory correctly, and monitoring performance, you can ensure your app maintains consistent 60fps rendering and provides an excellent user experience. Always profile your app on real devices to identify and fix performance bottlenecks.
