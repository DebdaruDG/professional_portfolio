import 'package:flutter/material.dart';

class PortfolioAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String currentPage;
  final bool isVisible;
  const PortfolioAppBar({
    super.key,
    required this.currentPage,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: AppBar(
        title: const Text(
          'Debdaru Dasgupta',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          _NavItem(
            title: 'Home',
            isActive: currentPage == 'home',
            onTap: () => Navigator.pushNamed(context, '/home'),
          ),
          _NavItem(
            title: 'About',
            isActive: currentPage == 'about',
            onTap: () => Navigator.pushNamed(context, '/about'),
          ),
          _NavItem(
            title: 'Skills',
            isActive: currentPage == 'skills',
            onTap: () => Navigator.pushNamed(context, '/skills'),
          ),
          _NavItem(
            title: 'Projects',
            isActive: currentPage == 'projects',
            onTap: () => Navigator.pushNamed(context, '/projects'),
          ),
          _NavItem(
            title: 'Contact',
            isActive: currentPage == 'contact',
            onTap: () => Navigator.pushNamed(context, '/contact'),
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
  final VoidCallback onTap;

  const _NavItem({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextButton(
        onPressed: onTap,
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
