import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_list_app/models/movie.dart';
import 'package:movie_list_app/providers/movies.dart';
import 'package:movie_list_app/widgets/image_input.dart';
import 'package:provider/provider.dart';

class MovieEditScreen extends StatefulWidget {
  static const routeName = '/edit-movie';
  MovieEditScreen({Key? key}) : super(key: key);

  @override
  _MovieEditScreenState createState() => _MovieEditScreenState();
}

class _MovieEditScreenState extends State<MovieEditScreen> {
  final _tiltleController = TextEditingController();
  final _directorController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _editMovie(movie) {
    if (_tiltleController.text.isEmpty ||
        _directorController.text.isEmpty ||
        _pickedImage == null) {
      return;
    }

    var _editedData = Movie(
      id: movie.id,
      title: movie.text,
      director: movie.text,
      image: movie.image as File,
    );

    Provider.of<Movies>(context, listen: false).editData(movie.id, _editedData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedMovie =
        Provider.of<Movies>(context, listen: false).findById(movieId);
    print(loadedMovie.image);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit a Movie'),
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
                    controller: TextEditingController(text: loadedMovie.title),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(labelText: 'Director'),
                    controller:
                        TextEditingController(text: loadedMovie.director),
                  ),
                  SizedBox(height: 20),
                  ImageInput(_selectImage),
                ],
              ),
            ),
          )),
          RaisedButton.icon(
            onPressed: () => _editMovie(loadedMovie),
            icon: Icon(Icons.add),
            label: Text('Save Changes'),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
            // textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
