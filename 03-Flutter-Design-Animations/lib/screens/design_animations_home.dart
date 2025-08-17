import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../widgets/custom_fonts_section.dart';
import '../widgets/themes_auto_size_section.dart';
import '../widgets/skeleton_shimmer_section.dart';
import '../widgets/route_transition_section.dart';
import '../widgets/ripple_effect_section.dart';
import '../widgets/lazy_loader_section.dart';
import '../widgets/radial_hero_section.dart';
import '../widgets/hinge_animation_section.dart';
import '../widgets/lottie_animation_section.dart';
import '../widgets/progress_indicator_section.dart';
import '../widgets/physics_simulation_section.dart';
import '../widgets/rotate_transition_section.dart';
import '../widgets/rive_animation_section.dart';
// Import the animation gallery
import '../animations/index.dart';

class DesignAnimationsHome extends StatefulWidget {
  const DesignAnimationsHome({super.key});

  @override
  State<DesignAnimationsHome> createState() => _DesignAnimationsHomeState();
}

class _DesignAnimationsHomeState extends State<DesignAnimationsHome>
    with TickerProviderStateMixin {
  late AnimationController _rippleController;
  late AnimationController _hingeController;
  late AnimationController _rotateController;
  late AnimationController _radialController;
  late AnimationController _physicsController;
  late AnimationController _skeletonController;

  bool _showSkeleton = true;

  @override
  void initState() {
    super.initState();
    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _hingeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _rotateController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _radialController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _physicsController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _skeletonController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _startSkeletonAnimation();
  }

  void _startSkeletonAnimation() {
    _skeletonController.repeat(reverse: true);
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showSkeleton = false;
        });
        _skeletonController.stop();
      }
    });
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _hingeController.dispose();
    _rotateController.dispose();
    _radialController.dispose();
    _physicsController.dispose();
    _skeletonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Design & Animations',
              textStyle: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              speed: const Duration(milliseconds: 100),
            ),
          ],
          totalRepeatCount: 1,
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 600),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(child: widget),
              ),
              children: [
                // Animation Gallery Section
                _buildSectionTitle('🎨 Animation Gallery'),
                _buildAnimationGallerySection(),
                
                _buildSectionTitle('Customizing Fonts'),
                CustomFontsSection(),
                
                _buildSectionTitle('Themes & Auto Size Text'),
                ThemesAutoSizeSection(),
                
                _buildSectionTitle('Skeleton Text & Shimmer'),
                SkeletonShimmerSection(showSkeleton: _showSkeleton),
                
                _buildSectionTitle('Animation in Route Transition'),
                RouteTransitionSection(),
                
                _buildSectionTitle('Ripple Effect'),
                RippleEffectSection(controller: _rippleController),
                
                _buildSectionTitle('Lazy Loader'),
                LazyLoaderSection(),
                
                _buildSectionTitle('Radial Hero Animation'),
                RadialHeroSection(controller: _radialController),
                
                _buildSectionTitle('Hinge Animation'),
                HingeAnimationSection(controller: _hingeController),
                
                _buildSectionTitle('Lottie Animation'),
                LottieAnimationSection(),
                
                _buildSectionTitle('Progress Indicator'),
                ProgressIndicatorSection(),
                
                _buildSectionTitle('Physics Simulation'),
                PhysicsSimulationSection(controller: _physicsController),
                
                _buildSectionTitle('Rotate Transition'),
                RotateTransitionSection(controller: _rotateController),
                
                _buildSectionTitle('Rive Animation'),
                RiveAnimationSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildAnimationGallerySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Comprehensive Animation Gallery',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Explore 8 animation categories with 40+ animation types including basic animations, staggered effects, text animations, physics simulations, hero transitions, Lottie animations, modern Flutter Animate syntax, and loading animations.',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AnimationGallery(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.animation),
                  label: const Text('Open Gallery'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BasicAnimations(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Try Basic'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildAnimationChip('Basic', Icons.animation),
              _buildAnimationChip('Staggered', Icons.list),
              _buildAnimationChip('Text', Icons.text_fields),
              _buildAnimationChip('Physics', Icons.science),
              _buildAnimationChip('Hero', Icons.flight),
              _buildAnimationChip('Lottie', Icons.movie),
              _buildAnimationChip('Modern', Icons.auto_awesome),
              _buildAnimationChip('Loading', Icons.hourglass_empty),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnimationChip(String label, IconData icon) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label, style: GoogleFonts.poppins(fontSize: 12)),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
    );
  }
}
