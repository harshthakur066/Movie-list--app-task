import 'dart:io';

class Movie {
  final String id;
  final String title;
  final String director;
  final File image;

  Movie({
    required this.id,
    required this.title,
    required this.director,
    required this.image,
  });
}
