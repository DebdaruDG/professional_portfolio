import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/portfolio_model.dart';
import '../widgets/project_card.dart';

class SkillsSection extends StatelessWidget {
  final GlobalKey sectionKey;
  final bool isVisible;
  final Portfolio portfolio;
  final Function(VisibilityInfo item) onVisibilityChanged;

  const SkillsSection({
    required this.sectionKey,
    required this.isVisible,
    required this.portfolio,
    required this.onVisibilityChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final skills = portfolio.skills;
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
              title: 'Skills',
              sectionKey: 'skills',
              isVisible: isVisible,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  InfoCard(
                    title: 'Languages',
                    items: skills.languages,
                    sectionKey: 'skills-languages',
                    isVisible: isVisible,
                  ),
                  InfoCard(
                    title: 'Databases',
                    items: skills.databases,
                    sectionKey: 'skills-databases',
                    isVisible: isVisible,
                  ),
                  InfoCard(
                    title: 'Frameworks',
                    items: skills.frameworks,
                    sectionKey: 'skills-frameworks',
                    isVisible: isVisible,
                  ),
                  InfoCard(
                    title: 'Concepts',
                    items: skills.concepts,
                    sectionKey: 'skills-concepts',
                    isVisible: isVisible,
                  ),
                  InfoCard(
                    title: 'Tools',
                    items: skills.tools,
                    sectionKey: 'skills-tools',
                    isVisible: isVisible,
                  ),
                  InfoCard(
                    title: 'Practices',
                    items: skills.practices,
                    sectionKey: 'skills-practices',
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
