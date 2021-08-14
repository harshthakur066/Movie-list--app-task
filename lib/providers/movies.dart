import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../models/movie.dart';
import '../helpers/db_helper.dart';

class Movies with ChangeNotifier {
  List<Movie> _items = [];

  List<Movie> get items {
    return [..._items];
  }

  Movie findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> addMovie(Movie newMovie) async {
    // final newMovie = Movie(
    //   id: DateTime.now().toString(),
    //   title: pickedTitle,
    //   director: pickedDirector,
    //   image: pickedImage,
    // );
    _items.add(newMovie);
    notifyListeners();

    await DBHelper.insert(
      'Movies',
      {
        'id': newMovie.id,
        'title': newMovie.title,
        'director': newMovie.director,
        'image': newMovie.image.path,
      },
    );
    print('Added Movie');
  }

  Future<void> editData(String id, Movie editedMovie) async {
    final movieIndex = _items.indexWhere((element) => element.id == id);
    if (movieIndex >= 0) {
      _items[movieIndex] = editedMovie;
      notifyListeners();

      await DBHelper.edit(
          'Movies',
          {
            'id': id,
            'title': editedMovie.title,
            'director': editedMovie.director,
            'image': editedMovie.image.path,
          },
          id);
      print('Updated Movie');
    } else {
      print('Update fail');
    }
  }

  Future<void> fetchData() async {
    final dataList = await DBHelper.getData('Movies');
    _items = dataList
        .map(
          (e) => Movie(
            id: e['id'],
            title: e['title'],
            director: e['director'],
            image: File(e['image']),
          ),
        )
        .toList();
    notifyListeners();
    print('Fetched Movies');
  }

  Future<void> deleteData(String id) async {
    final existingMovieIndex = _items.indexWhere((prod) => prod.id == id);
    // var existingMovie = _items[existingMovieIndex];
    _items.removeAt(existingMovieIndex);
    notifyListeners();

    await DBHelper.delete('Movies', id);
    print('Deleted Movie');
  }
}
