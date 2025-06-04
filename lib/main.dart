import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/portfolio_model.dart';
import 'provider/theme_provider.dart';
import 'services/load_json.dart';
import 'views/about.dart';
import 'views/contact.dart';
import 'views/home.dart';
import 'views/projects.dart';
import 'views/skills.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return FutureBuilder<Portfolio>(
      future: loadPortfolio('my_details.json'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: Text('No data found')));
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Debdaru's Portfolio",
            theme: themeProvider.theme,
            initialRoute: '/home',
            routes: {
              '/home': (context) => HomePage(portfolio: snapshot.data!),
              '/about': (context) => AboutPage(portfolio: snapshot.data!),
              '/skills': (context) => SkillsPage(portfolio: snapshot.data!),
              '/projects': (context) => ProjectsPage(portfolio: snapshot.data!),
              '/contact': (context) => ContactPage(portfolio: snapshot.data!),
            },
            home: HomePage(portfolio: snapshot.data!),
          );
        }
      },
    );
  }
}
