import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/portfolio_model.dart';
import '../widgets/app_bar.dart';
import '../widgets/footer.dart';
import '../widgets/project_card.dart';

class SkillsPage extends StatefulWidget {
  final Portfolio portfolio;
  const SkillsPage({super.key, required this.portfolio});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _appBarVisible = true;
  String _currentSection = 'skills';
  Timer? _hideAppBarTimer;
  final Map<String, bool> _sectionVisibility = {
    'languages': false,
    'databases': false,
    'frameworks': false,
    'concepts': false,
    'tools': false,
    'practices': false,
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    _sectionVisibility['languages'] = true; // Initial section visible
  }

  void _handleScroll() {
    if (!_appBarVisible) return;

    setState(() {
      _appBarVisible = false;
    });

    _hideAppBarTimer?.cancel();
    _hideAppBarTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _appBarVisible = true;
        });
      }
    });

    // Update current section based on scroll position
    final offset = _scrollController.offset;
    setState(() {
      _currentSection = 'skills'; // Adjust based on section heights if needed
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _hideAppBarTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PortfolioAppBar(
        currentPage: _currentSection,
        isVisible: _appBarVisible,
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    VisibilityDetector(
                      key: const Key('skills-title'),
                      onVisibilityChanged: (info) {
                        setState(() {
                          _sectionVisibility['languages'] =
                              info.visibleFraction > 0.1;
                        });
                      },
                      child: SectionTitle(
                        title: 'Skills',
                        sectionKey: 'skills-title',
                        isVisible: _sectionVisibility['languages']!,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          VisibilityDetector(
                            key: const Key('languages'),
                            onVisibilityChanged: (info) {
                              setState(() {
                                _sectionVisibility['languages'] =
                                    info.visibleFraction > 0.1;
                              });
                            },
                            child: InfoCard(
                              title: 'Languages',
                              items: widget.portfolio.skills.languages,
                              sectionKey: 'languages',
                              isVisible: _sectionVisibility['languages']!,
                            ),
                          ),
                          VisibilityDetector(
                            key: const Key('databases'),
                            onVisibilityChanged: (info) {
                              setState(() {
                                _sectionVisibility['databases'] =
                                    info.visibleFraction > 0.1;
                              });
                            },
                            child: InfoCard(
                              title: 'Databases',
                              items: widget.portfolio.skills.databases,
                              sectionKey: 'databases',
                              isVisible: _sectionVisibility['databases']!,
                            ),
                          ),
                          VisibilityDetector(
                            key: const Key('frameworks'),
                            onVisibilityChanged: (info) {
                              setState(() {
                                _sectionVisibility['frameworks'] =
                                    info.visibleFraction > 0.1;
                              });
                            },
                            child: InfoCard(
                              title: 'Frameworks',
                              items: widget.portfolio.skills.frameworks,
                              sectionKey: 'frameworks',
                              isVisible: _sectionVisibility['frameworks']!,
                            ),
                          ),
                          VisibilityDetector(
                            key: const Key('concepts'),
                            onVisibilityChanged: (info) {
                              setState(() {
                                _sectionVisibility['concepts'] =
                                    info.visibleFraction > 0.1;
                              });
                            },
                            child: InfoCard(
                              title: 'Concepts',
                              items: widget.portfolio.skills.concepts,
                              sectionKey: 'concepts',
                              isVisible: _sectionVisibility['concepts']!,
                            ),
                          ),
                          VisibilityDetector(
                            key: const Key('tools'),
                            onVisibilityChanged: (info) {
                              setState(() {
                                _sectionVisibility['tools'] =
                                    info.visibleFraction > 0.1;
                              });
                            },
                            child: InfoCard(
                              title: 'Tools',
                              items: widget.portfolio.skills.tools,
                              sectionKey: 'tools',
                              isVisible: _sectionVisibility['tools']!,
                            ),
                          ),
                          VisibilityDetector(
                            key: const Key('practices'),
                            onVisibilityChanged: (info) {
                              setState(() {
                                _sectionVisibility['practices'] =
                                    info.visibleFraction > 0.1;
                              });
                            },
                            child: InfoCard(
                              title: 'Practices',
                              items: widget.portfolio.skills.practices,
                              sectionKey: 'practices',
                              isVisible: _sectionVisibility['practices']!,
                            ),
                          ),
                        ],
                      ),
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
