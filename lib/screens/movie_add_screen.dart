import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_list_app/models/movie.dart';
import 'package:movie_list_app/providers/movies.dart';
import 'package:provider/provider.dart';

class MovieAddScreen extends StatefulWidget {
  static const routeName = '/add-movie';
  MovieAddScreen({Key? key}) : super(key: key);

  @override
  _MovieAddScreenState createState() => _MovieAddScreenState();
}

class _MovieAddScreenState extends State<MovieAddScreen> {
  final _tiltleController = TextEditingController();
  final _directorController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _saveMovie() {
    if (_tiltleController.text.isEmpty ||
        _directorController.text.isEmpty ||
        _pickedImage == null) {
      return;
    }

    var _addData = Movie(
      id: DateTime.now().toString(),
      title: _tiltleController.text,
      director: _directorController.text,
      image: _pickedImage as File,
    );

    Provider.of<Movies>(context, listen: false).addMovie(_addData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Movie'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Name'),
                    controller: _tiltleController,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(labelText: 'Director'),
                    controller: _directorController,
                  ),
                  SizedBox(height: 10),
                  // ImageInput(_selectImage),
                  SizedBox(height: 10),
                ],
              ),
            ),
          )),
          ElevatedButton.icon(
            onPressed: _saveMovie,
            icon: Icon(Icons.add),
            label: Text('Add Spot'),
            // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            // color: Theme.of(context).accentColor,
            // textColor: Colors.white,
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(color: Colors.white),
              shadowColor: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
