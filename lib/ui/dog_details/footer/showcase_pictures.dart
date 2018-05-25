import 'package:doggo_friends/models/dog.dart';
import 'package:flutter/material.dart';

class PicturesShowcase extends StatelessWidget {
  final Dog dog;
  PicturesShowcase(this.dog);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text(
        "Pictures",
        textAlign: TextAlign.center,
      ),
    );
  }
}
