import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/portfolio_model.dart';

// my_details.json
Future<Portfolio> loadPortfolio(String filename) async {
  final jsonString = await rootBundle.loadString('assets/data/$filename');
  final jsonMap = json.decode(jsonString);
  return Portfolio.fromJson(jsonMap);
}
