import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class BookFormWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final String? imageCover;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedImageCover;

  const BookFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    this.imageCover = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedImageCover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildImageCover(context),
              SizedBox(height: 8),
              buildTitle(context),
              SizedBox(height: 8),
              buildDescription(context),
            ],
          ),
        ),
      );

  Widget buildTitle(BuildContext context) => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: TextStyle(
          color: Theme.of(context).textTheme.headline6?.color,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription(BuildContext context) => TextFormField(
        maxLines: 5,
        initialValue: description,
        style: Theme.of(context).textTheme.subtitle1,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
        ),
        validator: (description) =>
            description != null && description.isEmpty ? 'The description cannot be empty' : null,
        onChanged: onChangedDescription,
      );

  Widget buildImageCover(BuildContext context) => TextFormField(
        maxLines: 1,
        initialValue: imageCover,
        style: Theme.of(context).textTheme.subtitle1,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Image Cover',
          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
        ),
        validator: (imageCover) =>
            imageCover != null && imageCover.isEmpty ? 'The image cover cannot be empty' : null,
        onChanged: onChangedImageCover,
      );
}