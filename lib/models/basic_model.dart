class Basics {
  final String name;
  final String location;
  final String email;
  final String phone;
  final String github;
  final String linkedin;
  final String portfolio;

  Basics({
    required this.name,
    required this.location,
    required this.email,
    required this.phone,
    required this.github,
    required this.linkedin,
    required this.portfolio,
  });

  factory Basics.fromJson(Map<String, dynamic> json) => Basics(
    name: json['name'],
    location: json['location'],
    email: json['email'],
    phone: json['phone'],
    github: json['github'],
    linkedin: json['linkedin'],
    portfolio: json['portfolio'],
  );
}
