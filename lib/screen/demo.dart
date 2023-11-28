import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 116.0,
            height: 174.0,
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.transparent, Colors.transparent, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.2, 0.8, 1],
              ),
            ),
            child: Image.network('https://i.picsum.photos/id/200/400/600.jpg'),
          ),
        ),
      ),
    );
  }
}