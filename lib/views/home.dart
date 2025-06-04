import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/portfolio_model.dart';
import '../widgets/app_bar.dart';
import '../widgets/footer.dart';

class HomePage extends StatefulWidget {
  final Portfolio portfolio;
  const HomePage({super.key, required this.portfolio});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _appBarVisible = true;
  String _currentSection = 'home';
  Timer? _hideAppBarTimer;
  Map<String, bool> _sectionVisibility = {'profile': false};

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    _sectionVisibility['profile'] = true; // Initial section visible
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
      _currentSection = 'home'; // Home page has a single section
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
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      VisibilityDetector(
                        key: const Key('profile'),
                        onVisibilityChanged: (info) {
                          setState(() {
                            _sectionVisibility['profile'] =
                                info.visibleFraction > 0.1;
                          });
                        },
                        child: AnimatedOpacity(
                          opacity: _sectionVisibility['profile']! ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  widget.portfolio.basics.name[0],
                                  style: const TextStyle(
                                    fontSize: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                widget.portfolio.basics.name,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
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
                                onPressed:
                                    () =>
                                        Navigator.pushNamed(context, '/about'),
                                child: const Text('Learn More About Me'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
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
