import 'package:doggo_friends/models/dog.dart';
import 'package:flutter/material.dart';

class AttributesShowcase extends StatelessWidget {
  final Dog dog;
  AttributesShowcase(this.dog);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text(
        "Attributes",
        textAlign: TextAlign.center,
      ),
    );
  }
}
