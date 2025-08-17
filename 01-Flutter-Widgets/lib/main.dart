import 'package:flutter/material.dart';

void main() {
  runApp(const FlutterWidgetsDemoApp());
}

// Main App - Demonstrates MaterialApp class
class FlutterWidgetsDemoApp extends StatelessWidget {
  const FlutterWidgetsDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sydney Widgets Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

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

// Page 1: Basic Widgets - Demonstrates Container, SizedBox, ClipRRect, RichText
class BasicWidgetsPage extends StatelessWidget {
  const BasicWidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sydney Basic Widgets',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // Container Widget demonstration
          const Text(
            'Container Widget:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Welcome to Sydney Harbour',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // SizedBox Widget demonstration
          const Text(
            'SizedBox Widget:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: Container(
                  color: Colors.red.shade100,
                  child: const Center(child: Text('Bondi')),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 120,
                height: 60,
                child: Container(
                  color: Colors.green.shade100,
                  child: const Center(child: Text('Manly Beach')),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // ClipRRect Widget demonstration
          const Text(
            'ClipRRect Widget:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.infinity,
              height: 80,
              color: Colors.purple.shade100,
              child: const Center(
                child: Text(
                  'Sydney Opera House',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // RichText Widget demonstration
          const Text(
            'RichText Widget:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 16, color: Colors.black),
              children: [
                TextSpan(
                  text: 'Welcome to ',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: 'Sydney',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                TextSpan(
                  text: ', the beautiful ',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: 'harbour city',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.red,
                  ),
                ),
                TextSpan(
                  text: ' of Australia!',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Page 2: Layout Widgets - Demonstrates various layout widgets
class LayoutWidgetsPage extends StatelessWidget {
  const LayoutWidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sydney Layout Widgets',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // Row and Column demonstration
          const Text(
            'Row and Column:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 60,
                height: 60,
                color: Colors.red.shade100,
                child: const Center(child: Text('CBD')),
              ),
              Container(
                width: 60,
                height: 60,
                color: Colors.green.shade100,
                child: const Center(child: Text('North')),
              ),
              Container(
                width: 60,
                height: 60,
                color: Colors.blue.shade100,
                child: const Center(child: Text('East')),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Stack demonstration
          const Text(
            'Stack Widget:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Center(child: Text('Harbour')),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Bridge'),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Wrap demonstration
          const Text(
            'Wrap Widget:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              Chip(
                label: Text('Bondi'),
                backgroundColor: Colors.blue,
              ),
              Chip(
                label: Text('Manly'),
                backgroundColor: Colors.green,
              ),
              Chip(
                label: Text('Coogee'),
                backgroundColor: Colors.orange,
              ),
              Chip(
                label: Text('Bronte'),
                backgroundColor: Colors.purple,
              ),
              Chip(
                label: Text('Tamarama'),
                backgroundColor: Colors.red,
              ),
              Chip(
                label: Text('Clovelly'),
                backgroundColor: Colors.teal,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Page 3: Input Widgets - Demonstrates TextField and other input widgets
class InputWidgetsPage extends StatefulWidget {
  const InputWidgetsPage({super.key});

  @override
  State<InputWidgetsPage> createState() => _InputWidgetsPageState();
}

class _InputWidgetsPageState extends State<InputWidgetsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sydney Input Widgets',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // TextField Widget demonstration
          const Text(
            'TextField Widget:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Sydney Suburb',
              hintText: 'Enter your suburb',
              prefixIcon: Icon(Icons.location_city),
              border: OutlineInputBorder(),
            ),
          ),
          
          const SizedBox(height: 16),
          
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
          ),
          
          const SizedBox(height: 16),
          
          TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: const OutlineInputBorder(),
            ),
          ),
          
          const SizedBox(height: 20),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Suburb: ${_nameController.text}\n'
                      'Email: ${_emailController.text}\n'
                      'Password: ${_passwordController.text}',
                    ),
                  ),
                );
              },
              child: const Text('Submit'),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Other input widgets
          const Text(
            'Other Input Widgets:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          
          // Switch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Enable Sydney weather alerts'),
              Switch(
                value: true,
                onChanged: (value) {
                  // Handle switch change
                },
              ),
            ],
          ),
          
          const SizedBox(height: 10),
          
          // Checkbox
          Row(
            children: [
              Checkbox(
                value: true,
                onChanged: (value) {
                  // Handle checkbox change
                },
              ),
              const Text('I agree to Sydney terms and conditions'),
            ],
          ),
          
          const SizedBox(height: 10),
          
          // Radio buttons
          const Text('Select your favorite Sydney beach:'),
          RadioListTile<String>(
            title: const Text('Bondi'),
            value: 'bondi',
            groupValue: 'bondi',
            onChanged: (value) {
              // Handle radio change
            },
          ),
          RadioListTile<String>(
            title: const Text('Manly'),
            value: 'manly',
            groupValue: 'bondi',
            onChanged: (value) {
              // Handle radio change
            },
          ),
          RadioListTile<String>(
            title: const Text('Coogee'),
            value: 'coogee',
            groupValue: 'bondi',
            onChanged: (value) {
              // Handle radio change
            },
          ),
        ],
      ),
    );
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

// Page 4: List Widgets - Demonstrates ListView and GridView
class ListWidgetsPage extends StatelessWidget {
  const ListWidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'ListView'),
              Tab(text: 'GridView'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // ListView demonstration
                ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    final sydneyAttractions = [
                      'Sydney Opera House',
                      'Harbour Bridge',
                      'Bondi Beach',
                      'Manly Beach',
                      'Darling Harbour',
                      'The Rocks',
                      'Royal Botanic Garden',
                      'Taronga Zoo',
                      'Luna Park',
                      'Sydney Tower',
                      'Hyde Park',
                      'Centennial Park',
                      'Coogee Beach',
                      'Bronte Beach',
                      'Tamarama Beach',
                      'Clovelly Beach',
                      'Watsons Bay',
                      'Rose Bay',
                      'Double Bay',
                      'Vaucluse',
                    ];
                    
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.primaries[index % Colors.primaries.length],
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(sydneyAttractions[index % sydneyAttractions.length]),
                        subtitle: Text('Sydney attraction ${index + 1}'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Tapped ${sydneyAttractions[index % sydneyAttractions.length]}')),
                          );
                        },
                      ),
                    );
                  },
                ),
                
                // GridView demonstration
                GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    final sydneyBeaches = [
                      'Bondi',
                      'Manly',
                      'Coogee',
                      'Bronte',
                      'Tamarama',
                      'Clovelly',
                      'Maroubra',
                      'Cronulla',
                      'Palm Beach',
                      'Avalon',
                      'Bilgola',
                      'Newport',
                    ];
                    
                    return Card(
                      elevation: 4,
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Tapped ${sydneyBeaches[index % sydneyBeaches.length]} Beach')),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.beach_access,
                              size: 48,
                              color: Colors.primaries[index % Colors.primaries.length],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              sydneyBeaches[index % sydneyBeaches.length],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
