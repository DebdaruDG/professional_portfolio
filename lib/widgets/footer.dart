import 'package:flutter/material.dart';
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
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinkButton(title: 'Email', url: 'mailto:${basics.email}'),
              LinkButton(title: 'GitHub', url: basics.github),
              LinkButton(title: 'LinkedIn', url: basics.linkedin),
              LinkButton(title: 'Portfolio', url: basics.portfolio),
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

  const LinkButton({super.key, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        child: Text(title, style: const TextStyle(color: Colors.white70)),
      ),
    );
  }
}
