import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_list_app/models/movie.dart';
import 'package:movie_list_app/providers/movies.dart';
import 'package:movie_list_app/widgets/image_input.dart';
import 'package:provider/provider.dart';

class MovieEditScreen extends StatefulWidget {
  static const routeName = '/edit-movie';
  // late String _prevTitle;
  // late String _pevDirector;
  // late File _prevImage;

  // MovieEditScreen(this._prevTitle, this._pevDirector, this._prevImage);
  MovieEditScreen({Key? key}) : super(key: key);

  @override
  _MovieEditScreenState createState() => _MovieEditScreenState();
}

class _MovieEditScreenState extends State<MovieEditScreen> {
  final _tiltleController = TextEditingController();
  final _directorController = TextEditingController();
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    initializeMovie();
  }

  void initializeMovie() {
    final movieId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedMovie =
        Provider.of<Movies>(context, listen: false).findById(movieId);
    _tiltleController.text = loadedMovie.title;
    _directorController.text = loadedMovie.director;
    _pickedImage = loadedMovie.image;
  }

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _editMovie() {
    print('screen call');
    // if (_tiltleController.text.isEmpty ||
    //     _directorController.text.isEmpty ||
    //     _pickedImage == null) {
    //   return;
    // }
    final movieId = ModalRoute.of(context)?.settings.arguments as String;
    // final loadedMovie =
    //     Provider.of<Movies>(context, listen: false).findById(movieId);
    // print(loadedMovie.image);

    var _editedData = Movie(
      id: movieId,
      title: _tiltleController.text,
      director: _directorController.text,
      image: _pickedImage as File,
    );

    Provider.of<Movies>(context, listen: false).editData(movieId, _editedData);
    Navigator.of(context).pop();
    print('done');
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
                      controller: _directorController
                      // TextEditingController(text: loadedMovie.director),
                      ),
                  SizedBox(height: 20),
                  ImageInput(_selectImage, _pickedImage),
                ],
              ),
            ),
          )),
          RaisedButton.icon(
            onPressed: _editMovie,
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
