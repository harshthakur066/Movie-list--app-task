import 'package:flutter/material.dart';
import 'package:movie_list_app/providers/google_signin.dart';
import 'package:movie_list_app/providers/movies.dart';
import 'package:movie_list_app/widgets/movie_item.dart';
import 'package:provider/provider.dart';

import 'package:movie_list_app/screens/movie_add_screen.dart';

class MovieListScreen extends StatelessWidget {
  static const routeName = '/list-movie';
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
          Padding(
            padding: const EdgeInsets.fromLTRB(3, 0, 15, 0),
            child: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Movies>(context, listen: false).fetchData(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
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
                    : RefreshIndicator(
                        onRefresh: () async {
                          await Provider.of<Movies>(context).fetchData();
                        },
                        child: ListView.builder(
                          // reverse: true,
                          itemCount: movies.items.length,
                          itemBuilder: (ctx, i) => MovieItem(movies.items[i]),
                        ),
                      ),
              ),
      ),
    );
  }
}
