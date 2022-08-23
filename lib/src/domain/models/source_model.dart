import 'dart:convert';

class Source {
  const Source({required this.id, required this.name});

  final String id;
  final String name;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };

  factory Source.fromMap(Map<String, dynamic> map) => Source(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
      );

  String toJson() => json.encode(toMap());

  factory Source.fromJson(String source) => Source.fromMap(json.decode(source));
}
