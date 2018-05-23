import 'package:doggo_friends/models/dog.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class DogDetailsPage extends StatefulWidget {
  final Dog dog;
  final Object avatarTag;

  DogDetailsPage(
    this.dog, {
    @required this.avatarTag,
  });

  @override
  _DogDetailsPageState createState() => new _DogDetailsPageState();
}

class _DogDetailsPageState extends State<DogDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SingleChildScrollView(
          child: new Container(
              // TODO Decoration
              child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ))),
    );
  }
}
