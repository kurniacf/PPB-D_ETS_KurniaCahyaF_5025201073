import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../db/books_database.dart';
import '../model/book.dart';
import '../widget/book_grid_widget.dart';
import 'edit_book_page.dart';
import 'book_detail_page.dart';

class BooksPage extends StatefulWidget {
  final VoidCallback toggleTheme;

  const BooksPage({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  late List<Book> books;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshBooks();
  }

  @override
  void dispose() {
    BooksDatabase.instance.close();
    super.dispose();
  }

  Future refreshBooks() async {
    setState(() => isLoading = true);
    books = await BooksDatabase.instance.readAllBooks();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Books',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : books.isEmpty
              ? Center(child: Text('No books', style: Theme.of(context).textTheme.headline6))
              : buildBooks(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddEditBookPage()));
          refreshBooks();
        },
      ),
    );
  }

  Widget buildBooks() {
    return MasonryGridView.count(
      itemCount: books.length,
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        final book = books[index];
        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => BookDetailPage(bookId: book.id!)),
            );

            refreshBooks();
          },
          child: BookGridWidget(book: book, index: index),
        );
      },
    );
  }
}