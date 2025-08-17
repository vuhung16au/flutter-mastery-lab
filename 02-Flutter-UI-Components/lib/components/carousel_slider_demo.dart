import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class CarouselSliderDemo extends StatelessWidget {
  const CarouselSliderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'https://picsum.photos/300/200?random=1',
      'https://picsum.photos/300/200?random=2',
      'https://picsum.photos/300/200?random=3',
      'https://picsum.photos/300/200?random=4',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carousel Slider Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FlutterCarousel(
              items: images.map((image) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                ),
              )).toList(),
              options: CarouselOptions(
                height: 200,
                showIndicator: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Swipe to navigate or wait for auto-play',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
