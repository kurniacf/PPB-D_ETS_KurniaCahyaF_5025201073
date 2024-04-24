// File: lib\widget\book_grid_widget.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/book.dart';

class BookGridWidget extends StatelessWidget {
  const BookGridWidget({
    Key? key,
    required this.book,
    required this.index,
  }) : super(key: key);

  final Book book;
  final int index;

  @override
  Widget build(BuildContext context) {
    final coverImage = book.imageCover;
    final time = DateFormat.yMMMd().format(book.createdTime);
    final minHeight = getMinHeight(index);

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(
            coverImage,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}