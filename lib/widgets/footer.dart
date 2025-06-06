import 'package:flutter/material.dart';
import 'package:flutter_devicon/flutter_devicon.dart';
import 'package:personal_porfolio/colors/color_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/basic_model.dart';

class PortfolioFooter extends StatelessWidget {
  final Basics basics;
  const PortfolioFooter({super.key, required this.basics});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Theme.of(context).primaryColorDark,
      child: Column(
        children: [
          Text(
            '© 2025 ${basics.name}. All rights reserved.',
            style: const TextStyle(color: ColorPicker.cyberYellow),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinkButton(
                title: 'Email',
                url: 'mailto:${basics.email}',
                icon: Icons.mail,
              ),
              LinkButton(
                title: 'GitHub',
                url: basics.github,
                icon: FlutterDEVICON.github_original,
              ),
              LinkButton(
                title: 'LinkedIn',
                url: basics.linkedin,
                icon: FlutterDEVICON.linkedin_plain,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LinkButton extends StatelessWidget {
  final String title;
  final String url;
  final IconData icon;

  const LinkButton({
    super.key,
    required this.title,
    required this.url,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton.icon(
        onPressed: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        icon: Icon(icon, color: Colors.white70, size: 20),
        label: Text(title, style: const TextStyle(color: Colors.white70)),
      ),
    );
  }
}
