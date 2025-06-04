import 'package:flutter/material.dart';
import '../models/portfolio_model.dart';
import '../widgets/app_bar.dart';
import '../widgets/footer.dart';
import '../widgets/project_card.dart';

class SkillsPage extends StatelessWidget {
  final Portfolio portfolio;
  const SkillsPage({super.key, required this.portfolio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PortfolioAppBar(currentPage: 'skills'),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SectionTitle(title: 'Skills'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          InfoCard(
                            title: 'Languages',
                            items: portfolio.skills.languages,
                          ),
                          InfoCard(
                            title: 'Databases',
                            items: portfolio.skills.databases,
                          ),
                          InfoCard(
                            title: 'Frameworks',
                            items: portfolio.skills.frameworks,
                          ),
                          InfoCard(
                            title: 'Concepts',
                            items: portfolio.skills.concepts,
                          ),
                          InfoCard(
                            title: 'Tools',
                            items: portfolio.skills.tools,
                          ),
                          InfoCard(
                            title: 'Practices',
                            items: portfolio.skills.practices,
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          PortfolioFooter(basics: portfolio.basics),
        ],
      ),
    );
  }
}
