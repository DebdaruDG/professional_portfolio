class Project {
  final String name;
  final String url;
  final String description;

  Project({required this.name, required this.url, required this.description});

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    name: json['name'],
    url: json['url'],
    description: json['description'],
  );
}
