final String tableBooks = 'book';

class BookFields {
  static final List<String> values = [
    id, 
    title,
    description,
    createdTime,
    imageCover
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String createdTime = 'createdTime';
  static final String imageCover = 'imageCover';
}

class Book {
  final int? id;
  final String title;
  final String description;
  final DateTime createdTime;
  final String imageCover;

  const Book({
    this.id,
    required this.title,
    required this.description,
    required this.createdTime,
    required this.imageCover,
  });

  Book copy({
    int? id,
    String? title,
    String? description,
    DateTime? createdTime,
    String? imageCover
  }) =>
      Book(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
        imageCover: imageCover ?? this.imageCover,
      );

  static Book fromJson(Map<String, Object?> json) => Book(
        id: json[BookFields.id] as int?,
        title: json[BookFields.title] as String,
        description: json[BookFields.description] as String,
        createdTime: DateTime.parse(json[BookFields.createdTime] as String),
        imageCover: json[BookFields.imageCover] as String,
      );

  Map<String, Object?> toJson() => {
        BookFields.id: id,
        BookFields.title: title,
        BookFields.description: description,
        BookFields.createdTime: createdTime.toIso8601String(),
        BookFields.imageCover: imageCover,
      };
}