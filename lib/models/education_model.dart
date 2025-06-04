class Education {
  final String degree;
  final String field;
  final String institution;
  final String year;
  final String cgpa;
  final List<String> coursework;

  Education({
    required this.degree,
    required this.field,
    required this.institution,
    required this.year,
    required this.cgpa,
    required this.coursework,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
    degree: json['degree'],
    field: json['field'],
    institution: json['institution'],
    year: json['year'],
    cgpa: json['cgpa'],
    coursework: List<String>.from(json['coursework']),
  );
}
