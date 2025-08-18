import 'package:flutter/material.dart';

class AppLinksScreen extends StatelessWidget {
  const AppLinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Links & Universal Links'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'App Links & Universal Links',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'App Links (Android) and Universal Links (iOS) allow your app to handle '
              'HTTP URLs and provide a seamless web-to-app experience.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            _buildPlatformSection(
              context,
              'Android App Links',
              'https://myapp.com',
              Icons.android,
              Colors.green,
              [
                'Add intent filters in AndroidManifest.xml',
                'Host digital asset links file',
                'Verify domain ownership',
                'Handle incoming intents',
              ],
            ),
            const SizedBox(height: 20),
            _buildPlatformSection(
              context,
              'iOS Universal Links',
              'https://myapp.com',
              Icons.phone_iphone,
              Colors.blue,
              [
                'Configure Associated Domains',
                'Host apple-app-site-association file',
                'Handle incoming URLs',
                'Fallback to web if app not installed',
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Configuration Examples:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Android (AndroidManifest.xml):',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '<intent-filter android:autoVerify="true">\n'
                    '  <action android:name="android.intent.action.VIEW" />\n'
                    '  <category android:name="android.intent.category.DEFAULT" />\n'
                    '  <category android:name="android.intent.category.BROWSABLE" />\n'
                    '  <data android:scheme="https" android:host="myapp.com" />\n'
                    '</intent-filter>',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'iOS (Info.plist):',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '<key>com.apple.developer.associated-domains</key>\n'
                    '<array>\n'
                    '  <string>applinks:myapp.com</string>\n'
                    '</array>',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformSection(
    BuildContext context,
    String title,
    String url,
    IconData icon,
    Color color,
    List<String> features,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        url,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...features.map((feature) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: color, size: 16),
                  const SizedBox(width: 8),
                  Expanded(child: Text(feature)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
