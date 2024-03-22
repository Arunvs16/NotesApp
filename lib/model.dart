class Notes {
  String title;
  String description;

  Notes({required this.title, required this.description});

  Notes.fromMap(Map map)
      : title = map['title'],
        description = map['description'];

  Map toMap() {
    return {
      'title': title,
      'description': description,
    };
  }
}
