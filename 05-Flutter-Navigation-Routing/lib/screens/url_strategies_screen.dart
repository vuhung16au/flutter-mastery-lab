import 'package:flutter/material.dart';
import '../widgets/strategy_card.dart';
import '../widgets/consideration_item.dart';

class UrlStrategiesScreen extends StatelessWidget {
  const UrlStrategiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('URL Strategies'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'URL Strategies',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'URL strategies determine how your Flutter web app handles URLs. '
              'This affects routing, browser history, and SEO.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            StrategyCard(
              title: 'Path URL Strategy',
              description: 'Uses path-based URLs (default)',
              example: 'example.com/route',
              icon: Icons.link,
              color: Colors.blue,
              features: [
                'Uses browser history API',
                'Better for SEO',
                'Works with server-side routing',
                'Default strategy',
              ],
            ),
            StrategyCard(
              title: 'Hash URL Strategy',
              description: 'Uses hash-based URLs',
              example: 'example.com/#/route',
              icon: Icons.tag,
              color: Colors.orange,
              features: [
                'Uses URL hash fragments',
                'No server configuration needed',
                'Works with static hosting',
                'May affect SEO',
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Implementation Examples:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildCodeExamples(),
            const SizedBox(height: 20),
            const Text(
              'Considerations:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const ConsiderationItem(
              title: 'SEO',
              description: 'Path strategy is better for search engine optimization',
              icon: Icons.search,
            ),
            const ConsiderationItem(
              title: 'Server Configuration',
              description: 'Path strategy may require server-side routing configuration',
              icon: Icons.settings,
            ),
            const ConsiderationItem(
              title: 'Static Hosting',
              description: 'Hash strategy works well with static hosting services',
              icon: Icons.cloud,
            ),
            const ConsiderationItem(
              title: 'Browser History',
              description: 'Both strategies support browser back/forward navigation',
              icon: Icons.history,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeExamples() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Path Strategy (main.dart):',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'import \'package:flutter_web_plugins/flutter_web_plugins.dart\';\n\n'
            'void main() {\n'
            '  setUrlStrategy(PathUrlStrategy());\n'
            '  runApp(MyApp());\n'
            '}',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
          SizedBox(height: 10),
          Text(
            'Hash Strategy (main.dart):',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'import \'package:flutter_web_plugins/flutter_web_plugins.dart\';\n\n'
            'void main() {\n'
            '  setUrlStrategy(HashUrlStrategy());\n'
            '  runApp(MyApp());\n'
            '}',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ],
      ),
    );
  }
}
