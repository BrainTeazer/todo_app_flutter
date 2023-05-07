class Item {
  final int id;
  final String title;
  final String? description;
  bool isCompleted;

  Item({required this.id, required this.title, this.description, required this.isCompleted});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted
    };
  }

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, description: $description, isCompleted: $isCompleted}';
  }
}
