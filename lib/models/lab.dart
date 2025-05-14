class Lab {
  final String title;
  final String description;
  final String source;

  Lab({
    required this.title,
    required this.description,
    required this.source,
  });

  factory Lab.fromJson(Map<String, dynamic> json) {
    return Lab(
      title: json['title'],
      description: json['description'],
      source: json['source'],
    );
  }
}
