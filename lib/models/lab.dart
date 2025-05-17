class Lab {
  final String name;
  final String description;
  final String source;

  Lab({
    required this.name,
    required this.description,
    required this.source,
  });

  factory Lab.fromJson(Map<String, dynamic> json) {
    return Lab(
      name: json['title'],
      description: json['description'],
      source: json['source'],
    );
  }
}
