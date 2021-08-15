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
  String _titleValue = '';
  String _directorValue = '';
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _editMovie() {
    print('screen call');

    // print('_titleValue $_titleValue');
    // print('_directorValue $_directorValue');
    // print('_pickedImage $_pickedImage');

    if (_titleValue.isEmpty || _directorValue.isEmpty || _pickedImage == null) {
      print('something missing');
      return;
    }
    final movieId = ModalRoute.of(context)?.settings.arguments as String;
    // final loadedMovie =
    //     Provider.of<Movies>(context, listen: false).findById(movieId);
    // print(loadedMovie.image);

    var _editedData = Movie(
      id: movieId,
      title: _titleValue,
      director: _directorValue,
      image: _pickedImage as File,
    );

    Provider.of<Movies>(context, listen: false).editData(movieId, _editedData);
    Navigator.of(context).pop();
    // print('done');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedMovie =
        Provider.of<Movies>(context, listen: false).findById(movieId);

    setState(() {
      _pickedImage = loadedMovie.image;
      _titleValue = loadedMovie.title;
      _directorValue = loadedMovie.director;
    });

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
              padding: const EdgeInsets.fromLTRB(8, 40, 8, 8),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Movie Name',
                      prefixIcon: Icon(
                        Icons.movie,
                        color: Theme.of(context).primaryColor,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    controller: TextEditingController(text: loadedMovie.title),
                    onChanged: (value) {
                      _titleValue = value;
                    },
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Diector Name',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).primaryColor,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    controller:
                        TextEditingController(text: loadedMovie.director),
                    onChanged: (value) {
                      _directorValue = value;
                    },
                  ),
                  SizedBox(height: 40),
                  ImageInput(_selectImage, loadedMovie.image),
                ],
              ),
            ),
          )),
          RaisedButton.icon(
            onPressed: _editMovie,
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: Text(
              'Save Changes',
              style: TextStyle(color: Colors.white),
            ),
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
