import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movie_list_app/screens/movie_add_screen.dart';
import 'package:movie_list_app/screens/movie_list_screen.dart';
import 'package:provider/provider.dart';

import './providers/movies.dart';

import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Movies(),
      child: MaterialApp(
        title: 'Spot',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.amber,
        ),
        home: MovieListScreen(),
        routes: {
          MovieAddScreen.routeName: (ctx) => MovieAddScreen(),
        },
      ),
    );
  }
}
