class TodoModel {
  final int? id;
  final String title;
  final String description;
  TodoModel({this.id, required this.title, required this.description});

  // Dart object lai convert to map // json
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
    };
  }

  // map lai convert to dart object
  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }
}
