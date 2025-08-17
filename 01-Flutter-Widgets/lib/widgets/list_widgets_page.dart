import 'package:flutter/material.dart';

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
