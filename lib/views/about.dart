import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/portfolio_model.dart';
import '../widgets/project_card.dart';

class AboutSection extends StatelessWidget {
  final GlobalKey sectionKey;
  final bool isVisible;
  final Portfolio portfolio;
  final Function(VisibilityInfo item) onVisibilityChanged;

  const AboutSection({
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
              title: 'About Me',
              sectionKey: 'about',
              isVisible: isVisible,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  InfoCard(
                    title: 'Summary',
                    description: portfolio.summary,
                    sectionKey: 'about-summary',
                    isVisible: isVisible,
                  ),
                  InfoCard(
                    title: 'Education',
                    subtitle:
                        '${portfolio.education.degree} in ${portfolio.education.field}',
                    items: [
                      '${portfolio.education.institution}, ${portfolio.education.year}',
                      'CGPA: ${portfolio.education.cgpa}',
                      'Coursework: ${portfolio.education.coursework.join(", ")}',
                    ],
                    sectionKey: 'about-education',
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
