import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String sectionKey;
  final bool isVisible;
  const SectionTitle({
    super.key,
    required this.title,
    required this.sectionKey,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<String>? items;
  final String? description;
  final String sectionKey;
  final bool isVisible;

  const InfoCard({
    super.key,
    required this.title,
    this.subtitle,
    this.items,
    this.description,
    required this.sectionKey,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 8),
                Text(
                  subtitle!,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                ),
              ],
              if (items != null) ...[
                const SizedBox(height: 8),
                ...items!.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text('• $item'),
                  ),
                ),
              ],
              if (description != null) ...[
                const SizedBox(height: 8),
                Text(description!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
