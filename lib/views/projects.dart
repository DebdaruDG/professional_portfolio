import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/portfolio_model.dart';
import '../widgets/project_card.dart';

class ProjectsSection extends StatefulWidget {
  final GlobalKey sectionKey;
  final bool isVisible;
  final Function(VisibilityInfo) onVisibilityChanged;
  final Portfolio portfolio;

  const ProjectsSection({
    required this.sectionKey,
    required this.isVisible,
    required this.portfolio,
    required this.onVisibilityChanged,
    super.key,
  });

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.sectionKey,
      onVisibilityChanged: widget.onVisibilityChanged,
      child: AnimatedOpacity(
        opacity: widget.isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SectionTitle(
                title: 'Projects',
                sectionKey: 'projects',
                isVisible: widget.isVisible,
              ),
              Column(
                children:
                    widget.portfolio.projects
                        .asMap()
                        .entries
                        .map(
                          (entry) => InfoCard(
                            title: entry.value.name,
                            description: entry.value.description,
                            items: [entry.value.url],
                            sectionKey: 'project-${entry.key}',
                            isVisible: widget.isVisible,
                          ),
                        )
                        .toList(),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
