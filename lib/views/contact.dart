import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/portfolio_model.dart';
import '../widgets/project_card.dart';

class ContactSection extends StatefulWidget {
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
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.sectionKey,
      onVisibilityChanged: (_) => widget.onVisibilityChanged,
      child: AnimatedOpacity(
        opacity: widget.isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Column(
          key: widget.sectionKey,
          children: [
            SectionTitle(
              title: 'Contact Me',
              sectionKey: 'contact',
              isVisible: widget.isVisible,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  InfoCard(
                    title: 'Contact Information',
                    items: [
                      'Email: ${widget.portfolio.basics.email}',
                      'Phone: ${widget.portfolio.basics.phone}',
                      'Location: ${widget.portfolio.basics.location}',
                    ],
                    sectionKey: 'contact-info',
                    isVisible: widget.isVisible,
                  ),
                  InfoCard(
                    title: 'Connect with Me',
                    items: [
                      'GitHub: ${widget.portfolio.basics.github}',
                      'LinkedIn: ${widget.portfolio.basics.linkedin}',
                      'Portfolio: ${widget.portfolio.basics.portfolio}',
                    ],
                    sectionKey: 'contact-connect',
                    isVisible: widget.isVisible,
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
