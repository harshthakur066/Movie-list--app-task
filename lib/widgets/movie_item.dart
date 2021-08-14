import 'package:flutter/material.dart';
import 'package:movie_list_app/models/movie.dart';
import 'package:movie_list_app/providers/movies.dart';
import 'package:movie_list_app/screens/movie_edit_screen.dart';
import 'package:provider/provider.dart';

class MovieItem extends StatefulWidget {
  final Movie _movie;

  MovieItem(this._movie);

  @override
  _MovieItemState createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: FileImage(
            widget._movie.image,
          ),
        ),
        title: Text(
          widget._movie.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(widget._movie.director),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).accentColor,
              onPressed: () => Navigator.of(context).pushNamed(
                  MovieEditScreen.routeName,
                  arguments: widget._movie.id),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () => Provider.of<Movies>(context, listen: false)
                  .deleteData(widget._movie.id),
            ),
          ],
        ),
      ),
    );
  }
}
