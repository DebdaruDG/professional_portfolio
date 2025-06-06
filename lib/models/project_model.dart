class Project {
  final String name;
  final String url;
  final String description;
  final String assetImageURL;
  final String launcherURL;

  Project({
    required this.name,
    required this.url,
    required this.description,
    required this.assetImageURL,
    required this.launcherURL,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    name: json['name'],
    url: json['url'],
    description: json['description'],
    assetImageURL: json['assetImageURL'],
    launcherURL: json['launcherURL'],
  );
}
