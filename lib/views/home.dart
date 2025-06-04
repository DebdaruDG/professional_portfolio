import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/portfolio_model.dart';

class HomeSection extends StatelessWidget {
  final GlobalKey sectionKey;
  final bool isVisible;
  final Function(VisibilityInfo item) onVisibilityChanged;
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
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: sectionKey,
      onVisibilityChanged: (_) => onVisibilityChanged,
      child: AnimatedOpacity(
        opacity: isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  portfolio.basics.name[0],
                  style: const TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                portfolio.basics.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                portfolio.basics.location,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              Text(portfolio.summary, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onLearnMoreTap,
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
