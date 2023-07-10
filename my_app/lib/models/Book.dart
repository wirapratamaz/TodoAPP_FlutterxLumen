class Book {
  late int id;
  late String name;
  late String description;

  Book(int id, String name, String description) {
    this.id = id;
    this.name = name;
    this.description = description;
  }

  Book.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        description = json['description'];

  Map toJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}
