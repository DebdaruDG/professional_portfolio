import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/portfolio_model.dart';
import '../widgets/helpers/resume_download_button.dart';
import '../widgets/project_card.dart';
import '../colors/color_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SectionTitle(
                title: 'About Me',
                sectionKey: 'about',
                isVisible: widget.isVisible,
              ),
              const SizedBox(height: 24),
              AnimationLimiter(
                child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 500),
                    childAnimationBuilder:
                        (widget) => SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(child: widget),
                        ),
                    children: [
                      _InfoCard(
                        title: 'Summary',
                        subtitle: widget.portfolio.summary,
                        sectionKey: 'about-summary',
                        isVisible: widget.isVisible,
                      ),
                      const SizedBox(height: 16),
                      _InfoCard(
                        title: 'Education',
                        icon: FontAwesomeIcons.graduationCap,
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
                      const SizedBox(height: 24),
                      DownloadResumeButton(),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     // Logic to Download Resume
                      //   },
                      //   child: const Text('Download Resume'),
                      // ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<String>? items;
  final String sectionKey;
  final bool isVisible;
  final IconData? icon;

  const _InfoCard({
    required this.title,
    this.subtitle,
    this.items,
    required this.sectionKey,
    required this.isVisible,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: ColorPicker.cyberYellow, size: 24),
                  const SizedBox(width: 8),
                ],
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (subtitle != null)
              Text(
                subtitle!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Colors.grey[400]),
              ),
            if (subtitle != null) const SizedBox(height: 8),
            if (items != null)
              ...items!.map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        size: 8,
                        color: ColorPicker.cyberYellow,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // if (items == null && subtitle == null)
            //   Text(
            //     title == 'Summary' ? item.portfolio.summary : '',
            //     style: Theme.of(
            //       context,
            //     ).textTheme.bodyMedium?.copyWith(color: Colors.white),
            //   ),
          ],
        ),
      ),
    );
  }
}
