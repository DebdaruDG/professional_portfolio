class Experience {
  final String title;
  final String company;
  final String location;
  final String startDate;
  final String endDate;
  final List<String> highlights;

  Experience({
    required this.title,
    required this.company,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.highlights,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    title: json['title'],
    company: json['company'],
    location: json['location'],
    startDate: json['startDate'],
    endDate: json['endDate'],
    highlights: List<String>.from(json['highlights']),
  );
}
