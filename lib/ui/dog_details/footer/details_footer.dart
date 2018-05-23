import 'package:doggo_friends/models/dog.dart';
import 'package:flutter/material.dart';

class DogShowcase extends StatefulWidget {
  final Dog dog;

  DogShowcase(this.dog);

  @override
  _DogShowcaseState createState() => new _DogShowcaseState();
}

class _DogShowcaseState extends State<DogShowcase>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {}
}
