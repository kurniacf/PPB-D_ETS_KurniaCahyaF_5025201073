import 'package:flutter/material.dart';
import '../db/books_database.dart';
import '../model/book.dart';
import '../widget/book_form_widget.dart';

class AddEditBookPage extends StatefulWidget {
  final Book? book;

  const AddEditBookPage({
    Key? key,
    this.book,
  }) : super(key: key);

  @override
  State<AddEditBookPage> createState() => _AddEditBookPageState();
}

class _AddEditBookPageState extends State<AddEditBookPage> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;
  late String imageCover;

  @override
  void initState() {
    super.initState();

    title = widget.book?.title ?? '';
    description = widget.book?.description ?? '';
    imageCover = widget.book?.imageCover ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton(context)],
        ),
        body: Form(
          key: _formKey,
          child: BookFormWidget(
            title: title,
            description: description,
            imageCover: imageCover,
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) => setState(() => this.description = description),
            onChangedImageCover: (imageCover) => setState(() => this.imageCover = imageCover),
          ),
        ),
      );

  Widget buildButton(BuildContext context) {
    final isFormValid = title.isNotEmpty && description.isNotEmpty && imageCover.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: isFormValid ? Theme.of(context).colorScheme.onSurface : Colors.grey.shade700,
          backgroundColor: isFormValid ? Theme.of(context).colorScheme.primary : Colors.grey.shade700,
          elevation: 0,
        ),
        onPressed: isFormValid ? addOrUpdateBook : null,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateBook() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.book != null;

      if (isUpdating) {
        await updateBook();
      } else {
        await addBook();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateBook() async {
    final book = widget.book!.copy(
      title: title,
      description: description,
      imageCover: imageCover,
    );

    await BooksDatabase.instance.update(book);
  }

  Future addBook() async {
    final book = Book(
      title: title,
      description: description,
      imageCover: imageCover,
      createdTime: DateTime.now(),
    );

    await BooksDatabase.instance.create(book);
  }
}