import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/portfolio_model.dart';
import '../widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  final GlobalKey sectionKey;
  final bool isVisible;
  final Portfolio portfolio;
  final Function(VisibilityInfo item) onVisibilityChanged;

  const ProjectsSection({
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
              title: 'Projects',
              sectionKey: 'projects',
              isVisible: isVisible,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children:
                    portfolio.projects
                        .asMap()
                        .entries
                        .map(
                          (entry) => InfoCard(
                            title: entry.value.name,
                            description: entry.value.description,
                            items: [entry.value.url],
                            sectionKey: 'project-${entry.key}',
                            isVisible: isVisible,
                          ),
                        )
                        .toList(),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
