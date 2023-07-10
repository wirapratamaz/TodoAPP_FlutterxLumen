class User {
  late int id;
  late String name;
  late String email;

  User(int id, String name, String email) {
    this.id = id;
    this.name = name;
    this.email = email;
  }

  User.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        email = json['email'];

  Map toJson() {
    return {'id': id, 'name': name, 'email': email};
  }
}
