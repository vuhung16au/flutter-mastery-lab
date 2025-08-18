import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class WakelockPage extends StatelessWidget {
  const WakelockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: ListTile(
                    leading: Icon(
                      provider.isWakelockEnabled ? Icons.wb_sunny : Icons.nightlight_round,
                      color: provider.isWakelockEnabled ? Colors.orange : Colors.blue,
                    ),
                    title: const Text('Keep Screen Awake'),
                    subtitle: Text(
                      provider.isWakelockEnabled 
                        ? 'Screen will stay awake' 
                        : 'Screen can go to sleep',
                    ),
                    trailing: Switch(
                      value: provider.isWakelockEnabled,
                      onChanged: (value) => provider.toggleWakelock(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Wakelock Status: ${provider.isWakelockEnabled ? "Enabled" : "Disabled"}',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'This feature prevents the device from going to sleep. Useful for video players, games, or monitoring apps.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
