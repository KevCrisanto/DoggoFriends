import 'package:doggo_friends/models/dog.dart';
import 'package:flutter/material.dart';

class DetailsShowcase extends StatelessWidget {
  final Dog dog;
  DetailsShowcase(this.dog);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text(
        "Details",
        textAlign: TextAlign.center,
      ),
    );
  }
}
