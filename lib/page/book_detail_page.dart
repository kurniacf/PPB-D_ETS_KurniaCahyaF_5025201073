import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/books_database.dart';
import '../model/book.dart';
import '../page/edit_book_page.dart';

class BookDetailPage extends StatefulWidget {
  final int bookId;

  const BookDetailPage({
    Key? key,
    required this.bookId,
  }) : super(key: key);

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late Book book;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshBook();
  }

  Future refreshBook() async {
    setState(() => isLoading = true);
    book = await BooksDatabase.instance.readBook(widget.bookId);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [editButton(context), deleteButton(context)],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      book.title,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMd().format(book.createdTime),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(height: 8),
                     Image.network(
                      book.imageCover,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const Text('Gambar tidak ditemukan');
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      book.description,
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  ],
                ),
              ),
      );

  Widget editButton(BuildContext context) => IconButton(
        icon: Icon(Icons.edit_outlined, color: Theme.of(context).iconTheme.color),
        onPressed: () async {
          if (isLoading) return;

          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddEditBookPage(book: book),
          ));

          refreshBook();
        },
      );

  Widget deleteButton(BuildContext context) => IconButton(
        icon: Icon(Icons.delete, color: Theme.of(context).iconTheme.color),
        onPressed: () async {
          await BooksDatabase.instance.delete(widget.bookId);

          Navigator.of(context).pop();
        },
      );
}