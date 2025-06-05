import 'package:flutter/material.dart';

class PortfolioAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String currentSection;
  final bool isVisible;
  final Map<String, GlobalKey> sectionKeys;

  const PortfolioAppBar({
    super.key,
    required this.currentSection,
    required this.isVisible,
    required this.sectionKeys,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.3,
      duration: const Duration(milliseconds: 300),
      child: AppBar(
        title: const Text(
          'Debdaru Dasgupta',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).cardColor,
        actions: [
          _NavItem(
            title: 'Home',
            isActive: currentSection == 'home',
            sectionKey: sectionKeys['home']!,
          ),
          _NavItem(
            title: 'About',
            isActive: currentSection == 'about',
            sectionKey: sectionKeys['about']!,
          ),
          _NavItem(
            title: 'Skills',
            isActive: currentSection == 'skills',
            sectionKey: sectionKeys['skills']!,
          ),
          _NavItem(
            title: 'Projects',
            isActive: currentSection == 'projects',
            sectionKey: sectionKeys['projects']!,
          ),
          _NavItem(
            title: 'Contact',
            isActive: currentSection == 'contact',
            sectionKey: sectionKeys['contact']!,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NavItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final GlobalKey sectionKey;

  const _NavItem({
    required this.title,
    required this.isActive,
    required this.sectionKey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextButton(
        onPressed: () {
          final sectionContext = sectionKey.currentContext;
          if (sectionContext != null) {
            Scrollable.ensureVisible(
              sectionContext,
              alignment: 0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        },
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white70,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
