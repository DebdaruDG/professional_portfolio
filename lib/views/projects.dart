import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/portfolio_model.dart';
import '../widgets/helpers/custom_project_card.dart';
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
    // Determine number of columns based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount =
        screenWidth > 1200
            ? 3
            : screenWidth > 600
            ? 2
            : 2;

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
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio:
                      1.5, // Adjust as needed for card proportions
                ),
                itemCount: widget.portfolio.projects.length,
                itemBuilder: (context, index) {
                  final project = widget.portfolio.projects[index];
                  return CustomProjectCard(
                    name: project.name,
                    description: project.description,
                    imageUrl:
                        project.assetImageURL, // Using assetImageURL from model
                    projectUrl:
                        project.launcherURL, // Using launcherURL from model
                    isVisible: widget.isVisible,
                    sectionKey: 'project-$index',
                  );
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
