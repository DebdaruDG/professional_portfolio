import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/education_model.dart';
import '../models/experience_model.dart';
import '../models/portfolio_model.dart';
import '../widgets/helpers/resume_download_button.dart';
import '../colors/color_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        duration: const Duration(milliseconds: 500),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 600),
              childAnimationBuilder:
                  (widget) => SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(child: widget),
                  ),
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SectionTitle(
                    title: 'About Me',
                    sectionKey: 'about',
                    isVisible: widget.isVisible,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: _InfoCard(
                    title: 'Summary',
                    subtitle: widget.portfolio.summary,
                    sectionKey: 'about-summary',
                    isVisible: widget.isVisible,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align to top
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _EducationSection(
                              education: widget.portfolio.education,
                              isVisible: widget.isVisible,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: ColorPicker.cyberYellow,
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        width: 2,
                        height: MediaQuery.of(context).size.height * 0.8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _ExperienceSection(
                              experiences: widget.portfolio.experience,
                              isVisible: widget.isVisible,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: DownloadResumeButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EducationSection extends StatelessWidget {
  final Education education;
  final bool isVisible;

  const _EducationSection({required this.education, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      title: 'Education',
      icon: FontAwesomeIcons.graduationCap,
      subtitle: '${education.degree} in ${education.field}',
      items: [
        '${education.institution}, ${education.year}',
        'CGPA: ${education.cgpa}',
        'Coursework: ${education.coursework.join(", ")}',
      ],
      sectionKey: 'about-education',
      isVisible: isVisible,
    );
  }
}

class _ExperienceSection extends StatelessWidget {
  final List<Experience> experiences;
  final bool isVisible;

  const _ExperienceSection({
    required this.experiences,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      title: 'Experience',
      icon: FontAwesomeIcons.briefcase,
      items:
          experiences.asMap().entries.expand((entry) {
            final exp = entry.value;
            return [
              '${exp.title} at ${exp.company}',
              '${exp.location} | ${exp.startDate} - ${exp.endDate}',
              ...exp.highlights.map((highlight) => '• $highlight'),
              if (entry.key < experiences.length - 1) '---',
            ];
          }).toList(),
      sectionKey: 'about-experience',
      isVisible: isVisible,
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
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: ColorPicker.cyberYellow, size: 28),
                  const SizedBox(width: 12),
                ],
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: ColorPicker.cyberYellow,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (subtitle != null)
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[300],
                  height: 1.5,
                ),
              ),
            if (subtitle != null && items != null) const SizedBox(height: 16),
            if (items != null)
              ...items!.asMap().entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (entry.value.startsWith('•'))
                        const Icon(
                          Icons.circle,
                          size: 8,
                          color: ColorPicker.cyberYellow,
                        )
                      else if (entry.value == '---')
                        const SizedBox.shrink()
                      else
                        const SizedBox(width: 8),
                      const SizedBox(width: 8),
                      Expanded(
                        child:
                            entry.value == '---'
                                ? Divider(color: Colors.grey[600], thickness: 1)
                                : Text(
                                  entry.value,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(
                                    color:
                                        entry.value.startsWith('•')
                                            ? Colors.grey[300]
                                            : Colors.white,
                                    fontWeight:
                                        entry.value.startsWith('•')
                                            ? FontWeight.normal
                                            : FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
