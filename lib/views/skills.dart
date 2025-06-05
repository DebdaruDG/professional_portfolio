import 'package:flutter/material.dart';
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

    final double cardWidth =
        (screenWidth - 32) / itemsPerRow; // Adjusted for padding
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
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
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16),
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
