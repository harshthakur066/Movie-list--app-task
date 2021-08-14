import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie List'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
