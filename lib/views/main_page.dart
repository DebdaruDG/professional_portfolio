import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/portfolio_model.dart';
import 'dart:async';

import '../widgets/app_bar.dart';
import '../widgets/footer.dart';
import '../widgets/project_card.dart';
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
  Timer? _hideAppBarTimer;
  final Map<String, bool> _sectionVisibility = {
    'home': false,
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
    _sectionVisibility['home'] = true; // Initial section visible
  }

  void _handleScroll() {
    if (!mounted) return;

    if (!_appBarVisible) {
      _hideAppBarTimer?.cancel();
      _hideAppBarTimer = Timer(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _appBarVisible = true;
          });
        }
      });
      return;
    }

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
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    _hideAppBarTimer?.cancel();
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
                SliverToBoxAdapter(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight:
                          MediaQuery.of(context).size.height - kToolbarHeight,
                    ),
                    child: Column(
                      children: [
                        // Home Section
                        HomeSection(
                          key: _sectionKeys['home'],
                          sectionKey: _sectionKeys['home']!,
                          portfolio: widget.portfolio,
                          isVisible: _sectionVisibility['home']!,
                          onVisibilityChanged: (info) {
                            if (mounted) {
                              setState(() {
                                _sectionVisibility['home'] =
                                    info.visibleFraction > 0.1;
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
                        // EARLIER
                        // VisibilityDetector(
                        //   key: _sectionKeys['home']!,
                        //   onVisibilityChanged: (info) {
                        //     if (mounted) {
                        //       setState(() {
                        //         _sectionVisibility['home'] =
                        //             info.visibleFraction > 0.1;
                        //       });
                        //     }
                        //   },
                        //   child: AnimatedOpacity(
                        //     opacity: _sectionVisibility['home']! ? 1.0 : 0.0,
                        //     duration: const Duration(milliseconds: 500),
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(16.0),
                        //       child: Column(
                        //         key: _sectionKeys['home'],
                        //         children: [
                        //           CircleAvatar(
                        //             radius: 60,
                        //             backgroundColor:
                        //                 Theme.of(context).primaryColor,
                        //             child: Text(
                        //               widget.portfolio.basics.name[0],
                        //               style: const TextStyle(
                        //                 fontSize: 40,
                        //                 color: Colors.white,
                        //               ),
                        //             ),
                        //           ),
                        //           const SizedBox(height: 16),
                        //           Text(
                        //             widget.portfolio.basics.name,
                        //             textAlign: TextAlign.center,
                        //             style: Theme.of(context)
                        //                 .textTheme
                        //                 .headlineSmall
                        //                 ?.copyWith(fontWeight: FontWeight.bold),
                        //           ),
                        //           Text(
                        //             widget.portfolio.basics.location,
                        //             textAlign: TextAlign.center,
                        //             style: Theme.of(context)
                        //                 .textTheme
                        //                 .titleMedium
                        //                 ?.copyWith(color: Colors.grey[600]),
                        //           ),
                        //           const SizedBox(height: 16),
                        //           Text(
                        //             widget.portfolio.summary,
                        //             textAlign: TextAlign.center,
                        //             style:
                        //                 Theme.of(context).textTheme.bodyMedium,
                        //           ),
                        //           const SizedBox(height: 16),
                        //           ElevatedButton(
                        //             onPressed: () {
                        //               final aboutContext =
                        //                   _sectionKeys['about']!.currentContext;
                        //               if (aboutContext != null) {
                        //                 Scrollable.ensureVisible(
                        //                   aboutContext,
                        //                   duration: const Duration(
                        //                     milliseconds: 500,
                        //                   ),
                        //                   curve: Curves.easeInOut,
                        //                 );
                        //               }
                        //             },
                        //             child: const Text('Learn More About Me'),
                        //           ),
                        //           const SizedBox(height: 32),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // About Section
                        AboutSection(
                          key: _sectionKeys['about'],
                          sectionKey: _sectionKeys['about']!,
                          portfolio: widget.portfolio,
                          isVisible: _sectionVisibility['about']!,
                          onVisibilityChanged: (info) {
                            if (mounted) {
                              setState(() {
                                _sectionVisibility['about'] =
                                    info.visibleFraction > 0.1;
                              });
                            }
                          },
                        ),
                        // VisibilityDetector(
                        //   key: _sectionKeys['about']!,
                        //   onVisibilityChanged: (info) {
                        //     if (mounted) {
                        //       setState(() {
                        //         _sectionVisibility['about'] =
                        //             info.visibleFraction > 0.1;
                        //       });
                        //     }
                        //   },
                        //   child: AnimatedOpacity(
                        //     opacity: _sectionVisibility['about']! ? 1.0 : 0.0,
                        //     duration: const Duration(milliseconds: 500),
                        //     child: Column(
                        //       key: _sectionKeys['about'],
                        //       children: [
                        //         SectionTitle(
                        //           title: 'About Me',
                        //           sectionKey: 'about',
                        //           isVisible: _sectionVisibility['about']!,
                        //         ),
                        //         Padding(
                        //           padding: const EdgeInsets.symmetric(
                        //             horizontal: 16.0,
                        //           ),
                        //           child: Column(
                        //             children: [
                        //               InfoCard(
                        //                 title: 'Summary',
                        //                 description: widget.portfolio.summary,
                        //                 sectionKey: 'about-summary',
                        //                 isVisible: _sectionVisibility['about']!,
                        //               ),
                        //               InfoCard(
                        //                 title: 'Education',
                        //                 subtitle:
                        //                     '${widget.portfolio.education.degree} in ${widget.portfolio.education.field}',
                        //                 items: [
                        //                   '${widget.portfolio.education.institution}, ${widget.portfolio.education.year}',
                        //                   'CGPA: ${widget.portfolio.education.cgpa}',
                        //                   'Coursework: ${widget.portfolio.education.coursework.join(", ")}',
                        //                 ],
                        //                 sectionKey: 'about-education',
                        //                 isVisible: _sectionVisibility['about']!,
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         const SizedBox(height: 32),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        SkillsSection(
                          key: _sectionKeys['skills'],
                          sectionKey: _sectionKeys['skills']!,
                          portfolio: widget.portfolio,
                          isVisible: _sectionVisibility['skills']!,
                          onVisibilityChanged: (info) {
                            if (mounted) {
                              setState(() {
                                _sectionVisibility['skills'] =
                                    info.visibleFraction > 0.1;
                              });
                            }
                          },
                        ),
                        // Skills Section
                        // VisibilityDetector(
                        //   key: _sectionKeys['skills']!,
                        //   onVisibilityChanged: (info) {
                        //     if (mounted) {
                        //       setState(() {
                        //         _sectionVisibility['skills'] =
                        //             info.visibleFraction > 0.1;
                        //       });
                        //     }
                        //   },
                        //   child: AnimatedOpacity(
                        //     opacity: _sectionVisibility['skills']! ? 1.0 : 0.0,
                        //     duration: const Duration(milliseconds: 500),
                        //     child: Column(
                        //       key: _sectionKeys['skills'],
                        //       children: [
                        //         SectionTitle(
                        //           title: 'Skills',
                        //           sectionKey: 'skills',
                        //           isVisible: _sectionVisibility['skills']!,
                        //         ),
                        //         Padding(
                        //           padding: const EdgeInsets.symmetric(
                        //             horizontal: 16.0,
                        //           ),
                        //           child: Column(
                        //             children: [
                        //               InfoCard(
                        //                 title: 'Languages',
                        //                 items:
                        //                     widget.portfolio.skills.languages,
                        //                 sectionKey: 'skills-languages',
                        //                 isVisible:
                        //                     _sectionVisibility['skills']!,
                        //               ),
                        //               InfoCard(
                        //                 title: 'Databases',
                        //                 items:
                        //                     widget.portfolio.skills.databases,
                        //                 sectionKey: 'skills-databases',
                        //                 isVisible:
                        //                     _sectionVisibility['skills']!,
                        //               ),
                        //               InfoCard(
                        //                 title: 'Frameworks',
                        //                 items:
                        //                     widget.portfolio.skills.frameworks,
                        //                 sectionKey: 'skills-frameworks',
                        //                 isVisible:
                        //                     _sectionVisibility['skills']!,
                        //               ),
                        //               InfoCard(
                        //                 title: 'Concepts',
                        //                 items: widget.portfolio.skills.concepts,
                        //                 sectionKey: 'skills-concepts',
                        //                 isVisible:
                        //                     _sectionVisibility['skills']!,
                        //               ),
                        //               InfoCard(
                        //                 title: 'Tools',
                        //                 items: widget.portfolio.skills.tools,
                        //                 sectionKey: 'skills-tools',
                        //                 isVisible:
                        //                     _sectionVisibility['skills']!,
                        //               ),
                        //               InfoCard(
                        //                 title: 'Practices',
                        //                 items:
                        //                     widget.portfolio.skills.practices,
                        //                 sectionKey: 'skills-practices',
                        //                 isVisible:
                        //                     _sectionVisibility['skills']!,
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         const SizedBox(height: 32),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        ProjectsSection(
                          key: _sectionKeys['projects'],
                          sectionKey: _sectionKeys['projects']!,
                          portfolio: widget.portfolio,
                          isVisible: _sectionVisibility['projects']!,
                          onVisibilityChanged: (info) {
                            if (mounted) {
                              setState(() {
                                _sectionVisibility['projects'] =
                                    info.visibleFraction > 0.1;
                              });
                            }
                          },
                        ),
                        // Projects Section
                        // VisibilityDetector(
                        //   key: _sectionKeys['projects']!,
                        //   onVisibilityChanged: (info) {
                        //     if (mounted) {
                        //       setState(() {
                        //         _sectionVisibility['projects'] =
                        //             info.visibleFraction > 0.1;
                        //       });
                        //     }
                        //   },
                        //   child: AnimatedOpacity(
                        //     opacity:
                        //         _sectionVisibility['projects']! ? 1.0 : 0.0,
                        //     duration: const Duration(milliseconds: 500),
                        //     child: Column(
                        //       key: _sectionKeys['projects'],
                        //       children: [
                        //         SectionTitle(
                        //           title: 'Projects',
                        //           sectionKey: 'projects',
                        //           isVisible: _sectionVisibility['projects']!,
                        //         ),
                        //         Padding(
                        //           padding: const EdgeInsets.symmetric(
                        //             horizontal: 16.0,
                        //           ),
                        //           child: Column(
                        //             children:
                        //                 widget.portfolio.projects
                        //                     .asMap()
                        //                     .entries
                        //                     .map(
                        //                       (entry) => InfoCard(
                        //                         title: entry.value.name,
                        //                         description:
                        //                             entry.value.description,
                        //                         items: [entry.value.url],
                        //                         sectionKey:
                        //                             'project-${entry.key}',
                        //                         isVisible:
                        //                             _sectionVisibility['projects']!,
                        //                       ),
                        //                     )
                        //                     .toList(),
                        //           ),
                        //         ),
                        //         const SizedBox(height: 32),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Contact Section
                        ContactSection(
                          key: _sectionKeys['contact'],
                          sectionKey: _sectionKeys['contact']!,
                          portfolio: widget.portfolio,
                          isVisible: _sectionVisibility['contact']!,
                          onVisibilityChanged: (info) {
                            if (mounted) {
                              setState(() {
                                _sectionVisibility['contact'] =
                                    info.visibleFraction > 0.1;
                              });
                            }
                          },
                        ),
                        // VisibilityDetector(
                        //   key: _sectionKeys['contact']!,
                        //   onVisibilityChanged: (info) {
                        //     if (mounted) {
                        //       setState(() {
                        //         _sectionVisibility['contact'] =
                        //             info.visibleFraction > 0.1;
                        //       });
                        //     }
                        //   },
                        //   child: AnimatedOpacity(
                        //     opacity: _sectionVisibility['contact']! ? 1.0 : 0.0,
                        //     duration: const Duration(milliseconds: 500),
                        //     child: Column(
                        //       key: _sectionKeys['contact'],
                        //       children: [
                        //         SectionTitle(
                        //           title: 'Contact Me',
                        //           sectionKey: 'contact',
                        //           isVisible: _sectionVisibility['contact']!,
                        //         ),
                        //         Padding(
                        //           padding: const EdgeInsets.symmetric(
                        //             horizontal: 16.0,
                        //           ),
                        //           child: Column(
                        //             children: [
                        //               InfoCard(
                        //                 title: 'Contact Information',
                        //                 items: [
                        //                   'Email: ${widget.portfolio.basics.email}',
                        //                   'Phone: ${widget.portfolio.basics.phone}',
                        //                   'Location: ${widget.portfolio.basics.location}',
                        //                 ],
                        //                 sectionKey: 'contact-info',
                        //                 isVisible:
                        //                     _sectionVisibility['contact']!,
                        //               ),
                        //               InfoCard(
                        //                 title: 'Connect with Me',
                        //                 items: [
                        //                   'GitHub: ${widget.portfolio.basics.github}',
                        //                   'LinkedIn: ${widget.portfolio.basics.linkedin}',
                        //                   'Portfolio: ${widget.portfolio.basics.portfolio}',
                        //                 ],
                        //                 sectionKey: 'contact-connect',
                        //                 isVisible:
                        //                     _sectionVisibility['contact']!,
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         const SizedBox(height: 32),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
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
