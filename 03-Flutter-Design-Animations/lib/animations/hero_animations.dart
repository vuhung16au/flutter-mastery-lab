import 'package:flutter/material.dart';

class HeroAnimations extends StatelessWidget {
  const HeroAnimations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Animations'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Tap on any card to see Hero animation',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            
            // Hero Card 1
            HeroCard(
              heroTag: 'hero1',
              title: 'Beautiful Sunset',
              subtitle: 'Tap to see full view',
              color: Colors.orange,
              icon: Icons.wb_sunny,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HeroDetailPage(
                      heroTag: 'hero1',
                      title: 'Beautiful Sunset',
                      description: 'A stunning sunset view with vibrant colors painting the sky. The golden hour creates magical lighting that transforms the landscape into a breathtaking scene.',
                      color: Colors.orange,
                      icon: Icons.wb_sunny,
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Hero Card 2
            HeroCard(
              heroTag: 'hero2',
              title: 'Mountain Peak',
              subtitle: 'Tap to see full view',
              color: Colors.blue,
              icon: Icons.landscape,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HeroDetailPage(
                      heroTag: 'hero2',
                      title: 'Mountain Peak',
                      description: 'Majestic mountain peaks reaching towards the sky, covered in snow and surrounded by clouds. A symbol of strength and natural beauty.',
                      color: Colors.blue,
                      icon: Icons.landscape,
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Hero Card 3
            HeroCard(
              heroTag: 'hero3',
              title: 'Ocean Waves',
              subtitle: 'Tap to see full view',
              color: Colors.teal,
              icon: Icons.waves,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HeroDetailPage(
                      heroTag: 'hero3',
                      title: 'Ocean Waves',
                      description: 'The rhythmic motion of ocean waves crashing against the shore, creating a soothing sound and mesmerizing pattern of movement.',
                      color: Colors.teal,
                      icon: Icons.waves,
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Hero Card 4
            HeroCard(
              heroTag: 'hero4',
              title: 'Forest Path',
              subtitle: 'Tap to see full view',
              color: Colors.green,
              icon: Icons.forest,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HeroDetailPage(
                      heroTag: 'hero4',
                      title: 'Forest Path',
                      description: 'A peaceful forest path winding through tall trees, with sunlight filtering through the canopy creating dappled shadows on the ground.',
                      color: Colors.green,
                      icon: Icons.forest,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HeroCard extends StatelessWidget {
  final String heroTag;
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const HeroCard({
    super.key,
    required this.heroTag,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Hero(
              tag: heroTag,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(width: 16),
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
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: color,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class HeroDetailPage extends StatelessWidget {
  final String heroTag;
  final String title;
  final String description;
  final Color color;
  final IconData icon;

  const HeroDetailPage({
    super.key,
    required this.heroTag,
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color.withValues(alpha: 0.1),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Image Section
            Container(
              width: double.infinity,
              height: 300,
              color: color.withValues(alpha: 0.1),
              child: Center(
                child: Hero(
                  tag: heroTag,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                ),
              ),
            ),
            
            // Content Section
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Additional Info Cards
                  Row(
                    children: [
                      Expanded(
                        child: _InfoCard(
                          icon: Icons.location_on,
                          title: 'Location',
                          subtitle: 'Natural Wonder',
                          color: color,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _InfoCard(
                          icon: Icons.access_time,
                          title: 'Best Time',
                          subtitle: 'Golden Hour',
                          color: color,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _InfoCard(
                          icon: Icons.camera_alt,
                          title: 'Photography',
                          subtitle: 'Perfect Light',
                          color: color,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _InfoCard(
                          icon: Icons.favorite,
                          title: 'Rating',
                          subtitle: '5.0 Stars',
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 30,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
