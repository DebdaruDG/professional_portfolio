import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/portfolio_model.dart';
import '../widgets/app_bar.dart';
import '../widgets/footer.dart';
import '../widgets/project_card.dart';

class AboutPage extends StatefulWidget {
  final Portfolio portfolio;
  const AboutPage({super.key, required this.portfolio});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final ScrollController _scrollController = ScrollController();
  bool _appBarVisible = true;
  String _currentSection = 'about';
  Timer? _hideAppBarTimer;
  Map<String, bool> _sectionVisibility = {'summary': false, 'education': false};

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    _sectionVisibility['summary'] = true; // Initial section visible
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
      _currentSection =
          offset < 200 ? 'about' : 'about'; // Adjust based on section heights
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
                      key: const Key('about-title'),
                      onVisibilityChanged: (info) {
                        setState(() {
                          _sectionVisibility['summary'] =
                              info.visibleFraction > 0.1;
                        });
                      },
                      child: SectionTitle(
                        title: 'About Me',
                        sectionKey: 'about-title',
                        isVisible: _sectionVisibility['summary']!,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          VisibilityDetector(
                            key: const Key('summary'),
                            onVisibilityChanged: (info) {
                              setState(() {
                                _sectionVisibility['summary'] =
                                    info.visibleFraction > 0.1;
                              });
                            },
                            child: InfoCard(
                              title: 'Summary',
                              description: widget.portfolio.summary,
                              sectionKey: 'summary',
                              isVisible: _sectionVisibility['summary']!,
                            ),
                          ),
                          VisibilityDetector(
                            key: const Key('education'),
                            onVisibilityChanged: (info) {
                              setState(() {
                                _sectionVisibility['education'] =
                                    info.visibleFraction > 0.1;
                              });
                            },
                            child: InfoCard(
                              title: 'Education',
                              subtitle:
                                  '${widget.portfolio.education.degree} in ${widget.portfolio.education.field}',
                              items: [
                                '${widget.portfolio.education.institution}, ${widget.portfolio.education.year}',
                                'CGPA: ${widget.portfolio.education.cgpa}',
                                'Coursework: ${widget.portfolio.education.coursework.join(", ")}',
                              ],
                              sectionKey: 'education',
                              isVisible: _sectionVisibility['education']!,
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
