import 'package:flutter/material.dart';
import 'package:flutter_devicon/flutter_devicon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../colors/color_picker.dart';
import '../models/portfolio_model.dart';
import '../widgets/project_card.dart';

class SkillsSection extends StatefulWidget {
  final GlobalKey sectionKey;
  final bool isVisible;
  final Portfolio portfolio;
  final Function(VisibilityInfo) onVisibilityChanged;

  const SkillsSection({
    required this.sectionKey,
    required this.isVisible,
    required this.portfolio,
    required this.onVisibilityChanged,
    super.key,
  });

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  @override
  void initState() {
    super.initState();
    debugPrint(
      'SkillsSection: ${widget.portfolio.skills.languages.join(", ")}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final skills = widget.portfolio.skills;
    return VisibilityDetector(
      key: widget.sectionKey,
      onVisibilityChanged: widget.onVisibilityChanged,
      child: AnimatedOpacity(
        opacity: widget.isVisible ? 1.0 : 0.3,
        duration: const Duration(milliseconds: 500),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SectionTitle(
                title: 'Skills',
                sectionKey: 'skills',
                isVisible: widget.isVisible,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16.0,
                runSpacing: 16.0,
                children: [
                  PortfolioCard(
                    title: 'Languages',
                    description: skills.languages.join(', '),
                    isVisible: widget.isVisible,
                  ),
                  PortfolioCard(
                    title: 'Databases',
                    description: skills.databases.join(', '),
                    isVisible: widget.isVisible,
                  ),
                  PortfolioCard(
                    title: 'Frameworks',
                    description: skills.frameworks.join(', '),
                    isVisible: widget.isVisible,
                  ),
                  PortfolioCard(
                    title: 'Concepts',
                    description: skills.concepts.join(', '),
                    isVisible: widget.isVisible,
                  ),
                  PortfolioCard(
                    title: 'Tools',
                    description: skills.tools.join(', '),
                    isVisible: widget.isVisible,
                  ),
                  PortfolioCard(
                    title: 'Practices',
                    description: skills.practices.join(', '),
                    isVisible: widget.isVisible,
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class PortfolioCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isVisible;

  const PortfolioCard({
    super.key,
    required this.title,
    required this.description,
    required this.isVisible,
  });

  // Map skills to their respective icons
  IconData _getIconForSkill(String skill) {
    switch (skill.toLowerCase()) {
      // Languages
      case 'dart':
        return FontAwesomeIcons.dartLang;
      case 'python':
        return FlutterDEVICON.python_plain_wordmark;
      case 'javascript':
        return FlutterDEVICON.javascript_plain;
      case 'typescript':
        return FlutterDEVICON.typescript_plain;
      case 'c':
        return FlutterDEVICON.c_plain;

      // Databases
      case 'postgresql':
        return FlutterDEVICON.postgresql_plain;
      case 'mongodb':
        return FlutterDEVICON.mongodb_plain;
      case 'sqlite':
        return FlutterDEVICON.sequelize_plain;
      case 'chromadb':
        return FontAwesomeIcons
            .database; // Fallback, as ChromaDB may not have a specific icon

      // Frameworks
      case 'flutter':
        return FlutterDEVICON.flutter_plain;
      case 'angular':
        return FlutterDEVICON.angularjs_plain;
      case 'react':
        return FlutterDEVICON.react_original;
      case 'node.js':
        return FlutterDEVICON.nodejs_plain;
      case 'express.js':
        return FlutterDEVICON.express_original;

      // Concepts
      case 'rest':
        return FontAwesomeIcons.networkWired; // Generic icon for REST
      case 'graphql':
        return Icons.graphic_eq_outlined;
      case 'websockets':
        return FontAwesomeIcons.satellite; // Generic icon for WebSockets
      case 'clean architecture':
        return FontAwesomeIcons.layerGroup; // Generic icon for architecture

      // Tools
      case 'azure devops':
        return FontAwesomeIcons.microsoft;
      case 'firebase':
        return FontAwesomeIcons.fire;
      case 'git':
        return FlutterDEVICON.git_plain;
      case 'docker':
        return FlutterDEVICON.docker_plain;
      case 'figma':
        return FontAwesomeIcons.figma;

      // Practices
      case 'agile':
        return FontAwesomeIcons.userGroup; // Generic icon for Agile
      case 'ci/cd':
        return FontAwesomeIcons.codeBranch; // Generic icon for CI/CD
      case 'tdd':
        return FontAwesomeIcons.vial; // Generic icon for TDD

      default:
        return FontAwesomeIcons.circleQuestion; // Fallback for unknown skills
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    late final int itemsPerRow;

    if (screenWidth > 1024) {
      itemsPerRow = 3;
    } else if (screenWidth > 600) {
      itemsPerRow = 2;
    } else {
      itemsPerRow = 1;
    }

    final double cardWidth = (screenWidth - 32) / itemsPerRow;
    final List<String> skills = description.split(', ');

    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: ColorPicker.cyberYellow, width: 2.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomPaint(
                painter: ZigZagPainter(),
                child: const SizedBox(width: 40, height: 10),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 16.0,
                runSpacing: 16.0,
                children:
                    skills.map((skill) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getIconForSkill(skill),
                            color: ColorPicker.cyberYellow,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            skill,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ZigZagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = ColorPicker.cyberYellow
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    final path = Path();
    const double step = 5.0;
    double x = 0.0;
    bool up = true;

    while (x < size.width) {
      path.lineTo(x, up ? 0 : size.height);
      x += step;
      up = !up;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
