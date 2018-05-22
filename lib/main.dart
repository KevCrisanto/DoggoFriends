import 'package:doggo_friends/ui/dog_list.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(new DoggoFriendsApp());
}

class DoggoFriendsApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.pinkAccent,
        fontFamily: 'Ubuntu',
      ),
      home: new DogList(),
    );
  }
}
