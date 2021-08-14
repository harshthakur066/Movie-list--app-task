import 'package:flutter/material.dart';
import 'package:movie_list_app/providers/movies.dart';
import 'package:movie_list_app/widgets/movie_item.dart';
import 'package:provider/provider.dart';

import 'package:movie_list_app/screens/movie_add_screen.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Movies'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(MovieAddScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Movies>(context, listen: false).fetchData(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<Movies>(
                    // child: null,
                    builder: (ctx, movies, _) => movies.items.length <= 0
                        ? Center(
                            child: Text(
                              'Got no movies yet, start adding some!',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          )
                        : ListView.builder(
                            itemCount: movies.items.length,
                            itemBuilder: (ctx, i) => MovieItem(movies.items[i]),
                            // itemBuilder: (ctx, i) => Card(
                            //   elevation: 5,
                            //   margin: EdgeInsets.symmetric(
                            //     vertical: 8,
                            //     horizontal: 5,
                            //   ),
                            //   child: ListTile(
                            //     leading: CircleAvatar(
                            //       backgroundImage: FileImage(
                            //         movies.items[i].image,
                            //       ),
                            //     ),
                            //     title: Text(
                            //       movies.items[i].title,
                            //       style: Theme.of(context).textTheme.headline6,
                            //     ),
                            //     subtitle: Text(
                            //       movies.items[i].director,
                            //       style: Theme.of(context).textTheme.bodyText2,
                            //     ),
                            //   ),
                            // ),
                          ),
                  ),
      ),
    );
  }
}
