import 'package:flutter/material.dart';

class ExpansionTileDemo extends StatelessWidget {
  const ExpansionTileDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expansion Tile Demo'),
      ),
      body: ListView(
        children: [
          ExpansionTile(
            leading: const Icon(Icons.folder),
            title: const Text('Documents'),
            subtitle: const Text('3 files'),
            children: [
              ListTile(
                leading: const Icon(Icons.description),
                title: const Text('Report.pdf'),
                subtitle: const Text('2.3 MB'),
                trailing: const Icon(Icons.download),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Downloading Report.pdf...')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.description),
                title: const Text('Presentation.pptx'),
                subtitle: const Text('15.7 MB'),
                trailing: const Icon(Icons.download),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Downloading Presentation.pptx...')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.description),
                title: const Text('Budget.xlsx'),
                subtitle: const Text('8.1 MB'),
                trailing: const Icon(Icons.download),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Downloading Budget.xlsx...')),
                  );
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.image),
            title: const Text('Images'),
            subtitle: const Text('5 photos'),
            children: [
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('vacation_1.jpg'),
                subtitle: const Text('2.1 MB'),
                trailing: const Icon(Icons.visibility),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening vacation_1.jpg...')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('vacation_2.jpg'),
                subtitle: const Text('1.8 MB'),
                trailing: const Icon(Icons.visibility),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening vacation_2.jpg...')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('vacation_3.jpg'),
                subtitle: const Text('3.2 MB'),
                trailing: const Icon(Icons.visibility),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening vacation_3.jpg...')),
                  );
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.music_note),
            title: const Text('Music'),
            subtitle: const Text('12 songs'),
            children: [
              ListTile(
                leading: const Icon(Icons.audiotrack),
                title: const Text('Song 1.mp3'),
                subtitle: const Text('3:45'),
                trailing: const Icon(Icons.play_arrow),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Playing Song 1.mp3...')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.audiotrack),
                title: const Text('Song 2.mp3'),
                subtitle: const Text('4:12'),
                trailing: const Icon(Icons.play_arrow),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Playing Song 2.mp3...')),
                  );
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.video_library),
            title: const Text('Videos'),
            subtitle: const Text('2 videos'),
            children: [
              ListTile(
                leading: const Icon(Icons.videocam),
                title: const Text('tutorial.mp4'),
                subtitle: const Text('15:30'),
                trailing: const Icon(Icons.play_arrow),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Playing tutorial.mp4...')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.videocam),
                title: const Text('meeting.mp4'),
                subtitle: const Text('45:12'),
                trailing: const Icon(Icons.play_arrow),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Playing meeting.mp4...')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
