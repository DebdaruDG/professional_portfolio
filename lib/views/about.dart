import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/portfolio_model.dart';
import '../widgets/project_card.dart';

class AboutSection extends StatefulWidget {
  final GlobalKey sectionKey;
  final bool isVisible;
  final Function(VisibilityInfo) onVisibilityChanged;
  final Portfolio portfolio;

  const AboutSection({
    required this.sectionKey,
    required this.isVisible,
    required this.portfolio,
    required this.onVisibilityChanged,
    super.key,
  });

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
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
                title: 'About Me',
                sectionKey: 'about',
                isVisible: widget.isVisible,
              ),
              InfoCard(
                title: 'Summary',
                description: widget.portfolio.summary,
                sectionKey: 'about-summary',
                isVisible: widget.isVisible,
              ),
              InfoCard(
                title: 'Education',
                subtitle:
                    '${widget.portfolio.education.degree} in ${widget.portfolio.education.field}',
                items: [
                  '${widget.portfolio.education.institution}, ${widget.portfolio.education.year}',
                  'CGPA: ${widget.portfolio.education.cgpa}',
                  'Coursework: ${widget.portfolio.education.coursework.join(", ")}',
                ],
                sectionKey: 'about-education',
                isVisible: widget.isVisible,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
