import 'basic_model.dart';
import 'education_model.dart';
import 'experience_model.dart';
import 'project_model.dart';
import 'skills_model.dart';

class Portfolio {
  final Basics basics;
  final String summary;
  final Skills skills;
  final List<Experience> experience;
  final List<Project> projects;
  final Education education;

  Portfolio({
    required this.basics,
    required this.summary,
    required this.skills,
    required this.experience,
    required this.projects,
    required this.education,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
    basics: Basics.fromJson(json['basics']),
    summary: json['summary'],
    skills: Skills.fromJson(json['skills']),
    experience:
        (json['experience'] as List)
            .map((e) => Experience.fromJson(e))
            .toList(),
    projects:
        (json['projects'] as List).map((e) => Project.fromJson(e)).toList(),
    education: Education.fromJson(json['education']),
  );
}
