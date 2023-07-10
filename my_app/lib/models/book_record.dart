class BookRecord {
  final int id;
  final String title;

  const BookRecord({required this.id, required this.title});

  factory BookRecord.fromJson(Map<String, dynamic> json) {
    return BookRecord(
      id: json['id'],
      title: json['title'],
    );
  }
}
