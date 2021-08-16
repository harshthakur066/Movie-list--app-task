import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_list_app/models/movie.dart';
import 'package:movie_list_app/providers/movies.dart';
import 'package:movie_list_app/widgets/image_input.dart';
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
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Fill all the feilds.'),
          duration: Duration(seconds: 2),
          // action: SnackBarAction(
          //   label: 'UNDO',
          //   onPressed: () => cart.removeOneItem(product.id),
          // ),
        ),
      );
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
              padding: const EdgeInsets.fromLTRB(8, 40, 8, 8),
              child: Column(
                children: [
                  TextField(
                    controller: _tiltleController,
                    decoration: InputDecoration(
                      hintText: 'Movie Name',
                      // prefix: Icon(Icons.person, color: Colors.orange),
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
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _directorController,
                    decoration: InputDecoration(
                      hintText: 'Diector Name',
                      // prefix: Icon(Icons.person, color: Colors.orange),
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
                  ),
                  SizedBox(height: 40),
                  ImageInput(_selectImage, null),
                ],
              ),
            ),
          )),
          RaisedButton.icon(
            onPressed: _saveMovie,
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: Text(
              'Add Movie',
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
