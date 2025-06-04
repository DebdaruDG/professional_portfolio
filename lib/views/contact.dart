import 'package:flutter/material.dart';
import '../models/portfolio_model.dart';
import '../widgets/app_bar.dart';
import '../widgets/footer.dart';
import '../widgets/project_card.dart';

class ContactPage extends StatelessWidget {
  final Portfolio portfolio;
  const ContactPage({super.key, required this.portfolio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PortfolioAppBar(currentPage: 'contact'),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SectionTitle(title: 'Contact Me'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          InfoCard(
                            title: 'Contact Information',
                            items: [
                              'Email: ${portfolio.basics.email}',
                              'Phone: ${portfolio.basics.phone}',
                              'Location: ${portfolio.basics.location}',
                            ],
                          ),
                          InfoCard(
                            title: 'Connect with Me',
                            items: [
                              'GitHub: ${portfolio.basics.github}',
                              'LinkedIn: ${portfolio.basics.linkedin}',
                              'Portfolio: ${portfolio.basics.portfolio}',
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
