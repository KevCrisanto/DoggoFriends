import 'package:doggo_friends/models/dog.dart';
import 'package:doggo_friends/ui/dog_details/header/details_header.dart';
import 'package:doggo_friends/ui/dog_details/footer/details_footer.dart';
import 'package:doggo_friends/ui/dog_details/details_body.dart';
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
    var linearGradient = new BoxDecoration(
      gradient: new LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: [
          Colors.teal,
          Colors.teal,
        ],
      ),
    );
    return new Scaffold(
      body: new SingleChildScrollView(
          child: new Container(
              decoration: linearGradient,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new DogDetailsHeader(
                    widget.dog,
                    avatarTag: widget.avatarTag,
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: new DogDetailsBody(widget.dog),
                  ),
                  new DogShowcase(widget.dog),
                ],
              ))),
    );
  }
}
