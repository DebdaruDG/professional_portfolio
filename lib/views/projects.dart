import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';
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
                          (entry) => CustomProjectCard(
                            name: entry.value.name,
                            description: entry.value.description,
                            imageUrl:
                                entry
                                    .value
                                    .assetImageURL, // Assuming imageUrl in Portfolio model
                            projectUrl: entry.value.url,
                            isVisible: widget.isVisible,
                            sectionKey: 'project-${entry.key}',
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

class CustomProjectCard extends StatefulWidget {
  final String name;
  final String description;
  final String imageUrl;
  final String projectUrl;
  final bool isVisible;
  final String sectionKey;

  const CustomProjectCard({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.projectUrl,
    required this.isVisible,
    required this.sectionKey,
    super.key,
  });

  @override
  State<CustomProjectCard> createState() => _CustomProjectCardState();
}

class _CustomProjectCardState extends State<CustomProjectCard> {
  bool _isHovered = false;

  // Function to launch URL
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _launchUrl(widget.projectUrl),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color:
                    _isHovered
                        ? Colors.yellow[700]!.withOpacity(0.5)
                        : Colors.grey.withOpacity(0.2),
                spreadRadius: _isHovered ? 4 : 2,
                blurRadius: _isHovered ? 8 : 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  AnimatedOpacity(
                    opacity: _isHovered ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      widget.description,
                      style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
              AnimatedOpacity(
                opacity: _isHovered ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/Images/${widget.imageUrl}',
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => Container(
                            height: 150,
                            color: Colors.grey[300],
                            child: const Center(
                              child: Text('Image not available'),
                            ),
                          ),
                    ),
                    const SizedBox(height: 8.0),
                    const Icon(
                      Icons.touch_app,
                      color: Colors.black54,
                      size: 24.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
