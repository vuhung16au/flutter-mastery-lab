import 'package:flutter/material.dart';

class SnackbarDemo extends StatelessWidget {
  const SnackbarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
    
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Snackbar Demo'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  scaffoldMessengerKey.currentState?.showSnackBar(
                    const SnackBar(
                      content: Text('This is a simple snackbar'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text('Simple Snackbar'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  scaffoldMessengerKey.currentState?.showSnackBar(
                    SnackBar(
                      content: const Text('Action snackbar'),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          // Use post frame callback to ensure the frame is complete
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            scaffoldMessengerKey.currentState?.showSnackBar(
                              const SnackBar(content: Text('Undo action performed!')),
                            );
                          });
                        },
                      ),
                    ),
                  );
                },
                child: const Text('Snackbar with Action'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  scaffoldMessengerKey.currentState?.showSnackBar(
                    SnackBar(
                      content: const Row(
                        children: [
                          Icon(Icons.info, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Info snackbar with icon'),
                        ],
                      ),
                      backgroundColor: Colors.blue,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                child: const Text('Styled Snackbar'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  scaffoldMessengerKey.currentState?.showSnackBar(
                    SnackBar(
                      content: const Text('Error occurred!'),
                      backgroundColor: Colors.red,
                      action: SnackBarAction(
                        label: 'DISMISS',
                        textColor: Colors.white,
                        onPressed: () {
                          scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );
                },
                child: const Text('Error Snackbar'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  scaffoldMessengerKey.currentState?.showSnackBar(
                    SnackBar(
                      content: const Text('This snackbar will stay until dismissed'),
                      duration: const Duration(days: 365), // Very long duration
                      action: SnackBarAction(
                        label: 'DISMISS',
                        onPressed: () {
                          scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );
                },
                child: const Text('Persistent Snackbar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
