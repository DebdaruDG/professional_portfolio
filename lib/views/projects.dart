import 'package:flutter/material.dart';
import '../models/portfolio_model.dart';
import '../widgets/app_bar.dart';
import '../widgets/footer.dart';
import '../widgets/project_card.dart';

class ProjectsPage extends StatelessWidget {
  final Portfolio portfolio;
  const ProjectsPage({super.key, required this.portfolio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PortfolioAppBar(currentPage: 'projects'),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SectionTitle(title: 'Projects'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children:
                            portfolio.projects
                                .map(
                                  (project) => InfoCard(
                                    title: project.name,
                                    description: project.description,
                                    items: [project.url],
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
          PortfolioFooter(basics: portfolio.basics),
        ],
      ),
    );
  }
}
