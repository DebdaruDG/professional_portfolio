import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/portfolio_model.dart';
import '../widgets/project_card.dart';

class ContactSection extends StatelessWidget {
  final GlobalKey sectionKey;
  final bool isVisible;
  final Portfolio portfolio;
  final Function(VisibilityInfo item) onVisibilityChanged;

  const ContactSection({
    required this.sectionKey,
    required this.isVisible,
    required this.portfolio,
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
        child: Column(
          key: sectionKey,
          children: [
            SectionTitle(
              title: 'Contact Me',
              sectionKey: 'contact',
              isVisible: isVisible,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  InfoCard(
                    title: 'Contact Information',
                    items: [
                      'Email: ${portfolio.basics.email}',
                      'Phone: ${portfolio.basics.phone}',
                      'Location: ${portfolio.basics.location}',
                    ],
                    sectionKey: 'contact-info',
                    isVisible: isVisible,
                  ),
                  InfoCard(
                    title: 'Connect with Me',
                    items: [
                      'GitHub: ${portfolio.basics.github}',
                      'LinkedIn: ${portfolio.basics.linkedin}',
                      'Portfolio: ${portfolio.basics.portfolio}',
                    ],
                    sectionKey: 'contact-connect',
                    isVisible: isVisible,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
