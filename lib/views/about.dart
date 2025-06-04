import 'package:flutter/material.dart';
import '../models/portfolio_model.dart';
import '../widgets/app_bar.dart';
import '../widgets/footer.dart';
import '../widgets/project_card.dart';

class AboutPage extends StatelessWidget {
  final Portfolio portfolio;
  const AboutPage({super.key, required this.portfolio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PortfolioAppBar(currentPage: 'about'),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SectionTitle(title: 'About Me'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          InfoCard(
                            title: 'Summary',
                            description: portfolio.summary,
                          ),
                          InfoCard(
                            title: 'Education',
                            subtitle:
                                '${portfolio.education.degree} in ${portfolio.education.field}',
                            items: [
                              '${portfolio.education.institution}, ${portfolio.education.year}',
                              'CGPA: ${portfolio.education.cgpa}',
                              'Coursework: ${portfolio.education.coursework.join(", ")}',
                            ],
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
