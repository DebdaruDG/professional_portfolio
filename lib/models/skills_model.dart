class Skills {
  final List<String> languages;
  final List<String> databases;
  final List<String> frameworks;
  final List<String> concepts;
  final List<String> tools;
  final List<String> practices;

  Skills({
    required this.languages,
    required this.databases,
    required this.frameworks,
    required this.concepts,
    required this.tools,
    required this.practices,
  });

  factory Skills.fromJson(Map<String, dynamic> json) => Skills(
    languages: List<String>.from(json['languages']),
    databases: List<String>.from(json['databases']),
    frameworks: List<String>.from(json['frameworks']),
    concepts: List<String>.from(json['concepts']),
    tools: List<String>.from(json['tools']),
    practices: List<String>.from(json['practices']),
  );
}
