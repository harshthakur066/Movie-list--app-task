import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_list_app/providers/google_signin.dart';
import 'package:movie_list_app/providers/movies.dart';
import 'package:movie_list_app/screens/intro_ios_screen.dart';
import 'package:movie_list_app/screens/intro_screen.dart';
import 'package:movie_list_app/screens/movie_list_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider = Provider.of<GoogleSignInProvider>(context);

            if (provider.isSigningIn) {
              return buildLoading();
            } else if (snapshot.hasData) {
              return RefreshIndicator(
                onRefresh: () async {
                  await Provider.of<Movies>(context, listen: false).fetchData();
                },
                child: MovieListScreen(),
              );
            } else {
              return Platform.isIOS ? IntroIosScreen() : IntroScreen();
              // return IntroIosScreen();
            }
          },
        ),
      );

  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          Center(child: CircularProgressIndicator()),
        ],
      );
}
