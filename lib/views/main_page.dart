import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/portfolio_model.dart';
import 'dart:async';

import '../widgets/app_bar.dart';
import '../widgets/footer.dart';
import '../widgets/helpers/image_slider.dart';
import '../widgets/project_card.dart';
import 'skills.dart';

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
                    VisibilityDetector(
                      key: Key('section-home'),
                      onVisibilityChanged: (info) {
                        if (mounted) {
                          setState(() {
                            _sectionVisibility['home'] =
                                info.visibleFraction > 0.1;
                          });
                        }
                      },
                      child: AnimatedOpacity(
                        opacity: _sectionVisibility['home']! ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          key: _sectionKeys['home'],
                          padding: const EdgeInsets.all(16.0),
                          constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height -
                                kToolbarHeight,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.portfolio.basics.name,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                widget.portfolio.basics.location,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                widget.portfolio.summary,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  final aboutContext =
                                      _sectionKeys['about']!.currentContext;
                                  if (aboutContext != null) {
                                    Scrollable.ensureVisible(
                                      aboutContext,
                                      duration: const Duration(
                                        milliseconds: 500,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                child: const Text('Learn More About Me'),
                              ),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // About Section
                    VisibilityDetector(
                      key: Key('section-about'),
                      onVisibilityChanged: (info) {
                        if (mounted) {
                          setState(() {
                            _sectionVisibility['about'] =
                                info.visibleFraction > 0.1;
                          });
                        }
                      },
                      child: AnimatedOpacity(
                        opacity: _sectionVisibility['about']! ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          key: _sectionKeys['about'],
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SectionTitle(
                                title: 'About Me',
                                sectionKey: 'about',
                                isVisible: _sectionVisibility['about']!,
                              ),
                              InfoCard(
                                title: 'Summary',
                                description: widget.portfolio.summary,
                                sectionKey: 'about-summary',
                                isVisible: _sectionVisibility['about']!,
                              ),
                              InfoCard(
                                title: 'Education',
                                subtitle:
                                    '${widget.portfolio.education.degree} in ${widget.portfolio.education.field}',
                                items: [
                                  '${widget.portfolio.education.institution}, ${widget.portfolio.education.year}',
                                  'CGPA: ${widget.portfolio.education.cgpa}',
                                  'Coursework: ${widget.portfolio.education.coursework.join(", ")}',
                                ],
                                sectionKey: 'about-education',
                                isVisible: _sectionVisibility['about']!,
                              ),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Skills Section
                    VisibilityDetector(
                      key: Key('section-skills'),
                      onVisibilityChanged: (info) {
                        if (mounted) {
                          setState(() {
                            _sectionVisibility['skills'] =
                                info.visibleFraction > 0.1;
                          });
                        }
                      },
                      child: AnimatedOpacity(
                        opacity: _sectionVisibility['skills']! ? 1.0 : 0.3,
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          key: _sectionKeys['skills'],
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SectionTitle(
                                title: 'Skills',
                                sectionKey: 'skills',
                                isVisible: _sectionVisibility['skills']!,
                              ),
                              Wrap(
                                alignment: WrapAlignment.center,
                                direction: Axis.horizontal,
                                textDirection: TextDirection.rtl,
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: [
                                  PortfolioCard(
                                    title: 'Languages',
                                    description: widget
                                        .portfolio
                                        .skills
                                        .languages
                                        .join(', '),
                                    isVisible: _sectionVisibility['skills']!,
                                  ),
                                  PortfolioCard(
                                    title: 'Databases',
                                    description: widget
                                        .portfolio
                                        .skills
                                        .databases
                                        .join(', '),
                                    isVisible: _sectionVisibility['skills']!,
                                  ),
                                  PortfolioCard(
                                    title: 'Frameworks',
                                    description: widget
                                        .portfolio
                                        .skills
                                        .frameworks
                                        .join(', '),
                                    isVisible: _sectionVisibility['skills']!,
                                  ),
                                  PortfolioCard(
                                    title: 'Concepts',
                                    description: widget
                                        .portfolio
                                        .skills
                                        .concepts
                                        .join(', '),
                                    isVisible: _sectionVisibility['skills']!,
                                  ),
                                  PortfolioCard(
                                    title: 'Tools',
                                    description: widget.portfolio.skills.tools
                                        .join(', '),
                                    isVisible: _sectionVisibility['skills']!,
                                  ),
                                  PortfolioCard(
                                    title: 'Practices',
                                    description: widget
                                        .portfolio
                                        .skills
                                        .practices
                                        .join(', '),
                                    isVisible: _sectionVisibility['skills']!,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Projects Section
                    VisibilityDetector(
                      key: Key('section-projects'),
                      onVisibilityChanged: (info) {
                        if (mounted) {
                          setState(() {
                            _sectionVisibility['projects'] =
                                info.visibleFraction > 0.1;
                          });
                        }
                      },
                      child: AnimatedOpacity(
                        opacity: _sectionVisibility['projects']! ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          key: _sectionKeys['projects'],
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SectionTitle(
                                title: 'Projects',
                                sectionKey: 'projects',
                                isVisible: _sectionVisibility['projects']!,
                              ),
                              Column(
                                children:
                                    widget.portfolio.projects
                                        .asMap()
                                        .entries
                                        .map(
                                          (entry) => InfoCard(
                                            title: entry.value.name,
                                            description:
                                                entry.value.description,
                                            items: [entry.value.url],
                                            sectionKey: 'project-${entry.key}',
                                            isVisible:
                                                _sectionVisibility['projects']!,
                                          ),
                                        )
                                        .toList(),
                              ),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Contact Section
                    VisibilityDetector(
                      key: Key('section-contact'),
                      onVisibilityChanged: (info) {
                        if (mounted) {
                          setState(() {
                            _sectionVisibility['contact'] =
                                info.visibleFraction > 0.1;
                          });
                        }
                      },
                      child: AnimatedOpacity(
                        opacity: _sectionVisibility['contact']! ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          key: _sectionKeys['contact'],
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SectionTitle(
                                title: 'Contact Me',
                                sectionKey: 'contact',
                                isVisible: _sectionVisibility['contact']!,
                              ),
                              InfoCard(
                                title: 'Contact Information',
                                items: [
                                  'Email: ${widget.portfolio.basics.email}',
                                  'Phone: ${widget.portfolio.basics.phone}',
                                  'Location: ${widget.portfolio.basics.location}',
                                ],
                                sectionKey: 'contact-info',
                                isVisible: _sectionVisibility['contact']!,
                              ),
                              InfoCard(
                                title: 'Connect with Me',
                                items: [
                                  'GitHub: ${widget.portfolio.basics.github}',
                                  'LinkedIn: ${widget.portfolio.basics.linkedin}',
                                  'Portfolio: ${widget.portfolio.basics.portfolio}',
                                ],
                                sectionKey: 'contact-connect',
                                isVisible: _sectionVisibility['contact']!,
                              ),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
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
