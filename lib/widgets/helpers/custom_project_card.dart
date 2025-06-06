import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../colors/color_picker.dart';

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
      cursor: _isHovered ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: () => _launchUrl(widget.projectUrl),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin:
              _isHovered
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(vertical: 8.0),
          padding: _isHovered ? EdgeInsets.zero : const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[900], // Dark background
            border: Border.all(color: ColorPicker.cyberYellow, width: 1.5),
            borderRadius: BorderRadius.zero,
            boxShadow: [
              BoxShadow(
                color:
                    _isHovered
                        ? ColorPicker.cyberYellow.withOpacity(0.5)
                        : Colors.grey.withOpacity(0.2),
                spreadRadius: _isHovered ? 4 : 0,
                blurRadius: _isHovered ? 8 : 0,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Non-hovered state: Title and Description
              AnimatedOpacity(
                opacity: _isHovered ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: ColorPicker.cyberYellow,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.description,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: ColorPicker.cyberYellow,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Hovered state: Full-container image and icon
              AnimatedOpacity(
                opacity: _isHovered ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/${widget.imageUrl}',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover, // Image covers entire container
                      errorBuilder:
                          (context, error, stackTrace) => Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Text('Image not available'),
                            ),
                          ),
                    ),
                    Positioned(
                      bottom: 8.0,
                      right: 8.0,
                      child: const Icon(
                        Icons.touch_app,
                        color: ColorPicker.cyberYellow,
                        size: 24.0,
                      ),
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
