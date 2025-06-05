import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/portfolio_model.dart';
import '../widgets/helpers/image_slider.dart';

class HomeSection extends StatefulWidget {
  final GlobalKey sectionKey;
  final bool isVisible;
  final Function(VisibilityInfo) onVisibilityChanged;
  final Portfolio portfolio;
  final VoidCallback onLearnMoreTap;

  const HomeSection({
    required this.sectionKey,
    required this.isVisible,
    required this.portfolio,
    required this.onLearnMoreTap,
    required this.onVisibilityChanged,
    super.key,
  });

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  @override
  void initState() {
    super.initState();
    debugPrint('HomeSection: ${widget.portfolio.basics.name}');
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.sectionKey,
      onVisibilityChanged: widget.onVisibilityChanged,
      child: AnimatedOpacity(
        opacity: widget.isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ImageSliderScreen(),
              ),
              const SizedBox(height: 16),
              Text(
                widget.portfolio.basics.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.portfolio.basics.location,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              Text(
                widget.portfolio.summary,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: widget.onLearnMoreTap,
                child: const Text('Learn More About Me'),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
