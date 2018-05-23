import 'package:doggo_friends/models/dog.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class DogDetailsHeader extends StatefulWidget {
  final Dog dog;
  final Object avatarTag;

  DogDetailsHeader(
    this.dog, {
    @required this.avatarTag,
  });

  @override
  _DogDetailsHeaderState createState() => new _DogDetailsHeaderState();
}

class _DogDetailsHeaderState extends State<DogDetailsHeader> {
  @override
  Widget build(BuildContext context) {}
}
