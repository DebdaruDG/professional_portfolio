import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/portfolio_model.dart';
import '../widgets/app_bar.dart';
import '../widgets/footer.dart';
import '../widgets/project_card.dart';

class ProjectsPage extends StatefulWidget {
  final Portfolio portfolio;
  const ProjectsPage({super.key, required this.portfolio});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _appBarVisible = true;
  String _currentSection = 'projects';
  Timer? _hideAppBarTimer;
  final Map<String, bool> _sectionVisibility = {};

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    // Initialize visibility for each project
    for (var project in widget.portfolio.projects) {
      _sectionVisibility[project.name] = false;
    }
    if (widget.portfolio.projects.isNotEmpty) {
      _sectionVisibility[widget.portfolio.projects.first.name] = true;
    }
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
      _currentSection = 'projects'; // Adjust based on section heights if needed
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
                      key: const Key('projects-title'),
                      onVisibilityChanged: (info) {
                        setState(() {
                          _sectionVisibility[widget
                                      .portfolio
                                      .projects
                                      .isNotEmpty
                                  ? widget.portfolio.projects.first.name
                                  : 'projects'] =
                              info.visibleFraction > 0.1;
                        });
                      },
                      child: SectionTitle(
                        title: 'Projects',
                        sectionKey: 'projects-title',
                        isVisible:
                            _sectionVisibility[widget
                                    .portfolio
                                    .projects
                                    .isNotEmpty
                                ? widget.portfolio.projects.first.name
                                : 'projects']!,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children:
                            widget.portfolio.projects
                                .asMap()
                                .entries
                                .map(
                                  (entry) => VisibilityDetector(
                                    key: Key('project-${entry.key}'),
                                    onVisibilityChanged: (info) {
                                      setState(() {
                                        _sectionVisibility[entry.value.name] =
                                            info.visibleFraction > 0.1;
                                      });
                                    },
                                    child: InfoCard(
                                      title: entry.value.name,
                                      description: entry.value.description,
                                      items: [entry.value.url],
                                      sectionKey: entry.value.name,
                                      isVisible:
                                          _sectionVisibility[entry.value.name]!,
                                    ),
                                  ),
                                )
                                .toList(),
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
