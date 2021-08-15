import 'package:flutter/material.dart';
import 'package:movie_list_app/screens/movie_list_screen.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text('Hello',
                        style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                    child: Text('There',
                        style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          // color: Theme.of(context).accentColor,
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                    child: Text('.',
                        style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 270.0, 0.0, 0.0),
                    child: Text('Have your movies at one place.',
                        style: TextStyle(
                          fontSize: 22,
                          // fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                        )),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 235.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            MovieListScreen.routeName,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Center(
                                  child: Image.asset('assets/download.png'),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Center(
                                child: Text('LOGIN WITH GOOGLE',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ));
  }
}
