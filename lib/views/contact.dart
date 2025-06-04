import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/portfolio_model.dart';
import '../widgets/app_bar.dart';
import '../widgets/footer.dart';
import '../widgets/project_card.dart';

class ContactPage extends StatefulWidget {
  final Portfolio portfolio;
  const ContactPage({super.key, required this.portfolio});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final ScrollController _scrollController = ScrollController();
  bool _appBarVisible = true;
  String _currentSection = 'contact';
  Timer? _hideAppBarTimer;
  final Map<String, bool> _sectionVisibility = {
    'contact-info': false,
    'connect': false,
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    _sectionVisibility['contact-info'] = true; // Initial section visible
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
      _currentSection = 'contact'; // Adjust based on section heights if needed
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
                      key: const Key('contact-title'),
                      onVisibilityChanged: (info) {
                        setState(() {
                          _sectionVisibility['contact-info'] =
                              info.visibleFraction > 0.1;
                        });
                      },
                      child: SectionTitle(
                        title: 'Contact Me',
                        sectionKey: 'contact-title',
                        isVisible: _sectionVisibility['contact-info']!,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          VisibilityDetector(
                            key: const Key('contact-info'),
                            onVisibilityChanged: (info) {
                              setState(() {
                                _sectionVisibility['contact-info'] =
                                    info.visibleFraction > 0.1;
                              });
                            },
                            child: InfoCard(
                              title: 'Contact Information',
                              items: [
                                'Email: ${widget.portfolio.basics.email}',
                                'Phone: ${widget.portfolio.basics.phone}',
                                'Location: ${widget.portfolio.basics.location}',
                              ],
                              sectionKey: 'contact-info',
                              isVisible: _sectionVisibility['contact-info']!,
                            ),
                          ),
                          VisibilityDetector(
                            key: const Key('connect'),
                            onVisibilityChanged: (info) {
                              setState(() {
                                _sectionVisibility['connect'] =
                                    info.visibleFraction > 0.1;
                              });
                            },
                            child: InfoCard(
                              title: 'Connect with Me',
                              items: [
                                'GitHub: ${widget.portfolio.basics.github}',
                                'LinkedIn: ${widget.portfolio.basics.linkedin}',
                                'Portfolio: ${widget.portfolio.basics.portfolio}',
                              ],
                              sectionKey: 'connect',
                              isVisible: _sectionVisibility['connect']!,
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
