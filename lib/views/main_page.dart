import 'package:flutter/material.dart';
import '../models/portfolio_model.dart';
import 'dart:async';

import '../widgets/app_bar.dart';
import '../widgets/footer.dart';
import '../views/home.dart';
import '../views/about.dart';
import '../views/skills.dart';
import '../views/projects.dart';
import '../views/contact.dart';

class MainPage extends StatefulWidget {
  final Portfolio portfolio;
  const MainPage({super.key, required this.portfolio});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();
  bool _appBarVisible = true;
  String _currentSection = 'home';
  Timer? _debounceTimer;
  final Map<String, bool> _sectionVisibility = {
    'home': true,
    'about': false,
    'skills': false,
    'projects': false,
    'contact': false,
  };
  final Map<String, GlobalKey> _sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'skills': GlobalKey(),
    'projects': GlobalKey(),
    'contact': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    debugPrint('MainPage Portfolio: ${widget.portfolio.basics.name}');
  }

  void _handleScroll() {
    if (_debounceTimer?.isActive ?? false) return;
    _debounceTimer = Timer(const Duration(milliseconds: 100), () {
      if (!mounted) return;

      // Update AppBar visibility based on scroll position
      setState(() {
        _appBarVisible = _scrollController.offset < 100;
      });

      // Determine current section
      double offset = _scrollController.offset;
      String newSection = 'home';
      double minDistance = double.infinity;

      for (var entry in _sectionKeys.entries) {
        final key = entry.value;
        final context = key.currentContext;
        if (context != null) {
          final RenderBox box = context.findRenderObject() as RenderBox;
          final position = box.localToGlobal(Offset.zero).dy;
          final distance = (position - kToolbarHeight).abs();
          if (distance < minDistance &&
              position >= -50 &&
              position <= MediaQuery.of(context).size.height) {
            minDistance = distance;
            newSection = entry.key;
          }
        }
      }

      if (mounted && newSection != _currentSection) {
        setState(() {
          _currentSection = newSection;
        });
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PortfolioAppBar(
        currentSection: _currentSection,
        isVisible: _appBarVisible,
        sectionKeys: _sectionKeys,
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    // Home Section
                    HomeSection(
                      key: Key('section-home'),
                      sectionKey: _sectionKeys['home']!,
                      isVisible: _sectionVisibility['home']!,
                      portfolio: widget.portfolio,
                      onVisibilityChanged: (info) {
                        if (mounted) {
                          setState(() {
                            _sectionVisibility['home'] =
                                info.visibleFraction > 0.5;
                          });
                        }
                      },
                      onLearnMoreTap: () {
                        final aboutContext =
                            _sectionKeys['about']!.currentContext;
                        if (aboutContext != null) {
                          Scrollable.ensureVisible(
                            aboutContext,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                    // About Section
                    AboutSection(
                      key: Key('section-about'),
                      sectionKey: _sectionKeys['about']!,
                      isVisible: _sectionVisibility['about']!,
                      portfolio: widget.portfolio,
                      onVisibilityChanged: (info) {
                        if (mounted) {
                          setState(() {
                            _sectionVisibility['about'] =
                                info.visibleFraction > 0.5;
                          });
                        }
                      },
                    ),
                    // Skills Section
                    SkillsSection(
                      key: Key('section-skills'),
                      sectionKey: _sectionKeys['skills']!,
                      isVisible: _sectionVisibility['skills']!,
                      portfolio: widget.portfolio,
                      onVisibilityChanged: (info) {
                        if (mounted) {
                          setState(() {
                            _sectionVisibility['skills'] =
                                info.visibleFraction > 0.5;
                          });
                        }
                      },
                    ),
                    // Projects Section
                    ProjectsSection(
                      key: Key('section-projects'),
                      sectionKey: _sectionKeys['projects']!,
                      isVisible: _sectionVisibility['projects']!,
                      portfolio: widget.portfolio,
                      onVisibilityChanged: (info) {
                        if (mounted) {
                          setState(() {
                            _sectionVisibility['projects'] =
                                info.visibleFraction > 0.5;
                          });
                        }
                      },
                    ),
                    // Contact Section
                    ContactSection(
                      key: Key('section-contact'),
                      sectionKey: _sectionKeys['contact']!,
                      isVisible: _sectionVisibility['contact']!,
                      portfolio: widget.portfolio,
                      onVisibilityChanged: (info) {
                        if (mounted) {
                          setState(() {
                            _sectionVisibility['contact'] =
                                info.visibleFraction > 0.5;
                          });
                        }
                      },
                    ),
                  ]),
                ),
              ],
            ),
          ),
          PortfolioFooter(basics: widget.portfolio.basics),
        ],
      ),
    );
  }
}
