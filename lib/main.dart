import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/portfolio_model.dart';
import 'provider/theme_provider.dart';
import 'services/load_json.dart';
import 'views/main_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) {
        final themeProvider = ThemeProvider();
        return themeProvider;
      },
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
      future: loadPortfolio('my_details.json').catchError((error) {
        throw error;
      }),
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Debdaru's Portfolio",
          theme: themeProvider.theme,
          home: Builder(
            builder: (context) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Scaffold(
                  body: Center(child: Text('Error: ${snapshot.error}')),
                );
              } else if (!snapshot.hasData) {
                return const Scaffold(
                  body: Center(child: Text('No data found')),
                );
              } else {
                return MainPage(portfolio: snapshot.data!);
              }
            },
          ),
        );
      },
    );
  }
}
