import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movie_list_app/providers/google_signin.dart';
import 'package:movie_list_app/screens/home_sceen.dart';
import 'package:movie_list_app/screens/movie_edit_screen.dart';
import 'package:provider/provider.dart';

import 'package:movie_list_app/screens/movie_add_screen.dart';
import 'package:movie_list_app/screens/movie_list_screen.dart';

import './providers/movies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: GoogleSignInProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Movies(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie List App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.blueGrey,
        ),
        home: HomePage(),
        routes: {
          MovieListScreen.routeName: (ctx) => MovieListScreen(),
          MovieAddScreen.routeName: (ctx) => MovieAddScreen(),
          MovieEditScreen.routeName: (ctx) => MovieEditScreen(),
        },
      ),
    );
  }
}
