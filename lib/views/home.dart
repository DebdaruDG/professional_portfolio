import 'package:flutter/material.dart';
import '../models/portfolio_model.dart';
import '../widgets/app_bar.dart';
import '../widgets/footer.dart';

class HomePage extends StatelessWidget {
  final Portfolio portfolio;
  const HomePage({super.key, required this.portfolio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PortfolioAppBar(currentPage: 'home'),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Theme.of(context).cardColor,
                        child: Text(
                          portfolio.basics.name[0],
                          style: const TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        portfolio.basics.name,
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        portfolio.basics.location,
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          color: Theme.of(
                            context,
                          ).primaryColor.withOpacity(0.45),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        portfolio.summary,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/about'),
                        child: const Text('Learn More About Me'),
                      ),
                    ]),
                  ),
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
