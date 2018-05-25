import 'package:doggo_friends/models/dog.dart';
import 'package:doggo_friends/models/globals.dart';
import 'package:flutter/material.dart';

class PicturesShowcase extends StatelessWidget {
  final Dog dog;
  PicturesShowcase(this.dog);

  @override
  Widget build(BuildContext context) {
    var items = <Widget>[];
    var a = PictureId;
    for (var i = 0; i < dog.pictures.length; i++) {
      var gestureDetector = new GestureDetector(
        child: new Hero(
          tag: 'imageHero' + [i].toString(),
          child: new Image.network(
            dog.pictures[i],
            width: 200.0,
            height: 200.0,
          ),
        ),
        onTap: () {
          a.i = i;
          Navigator.push(context, new MaterialPageRoute(builder: (_) {
            return new PictureScreen(dog);
          }));
        },
      );
      items.add(gestureDetector);
    }
    var delegate = new SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
    );

    return new GridView(
      padding: const EdgeInsets.only(top: 16.0),
      gridDelegate: delegate,
      children: items,
    );
  }
}

class PictureScreen extends StatelessWidget {
  final Dog dog;
  PictureScreen(this.dog);

  @override
  Widget build(BuildContext context) {
    var a = PictureId;
    return new Scaffold(
      body: new GestureDetector(
        child: new Center(
          child: new Hero(
            tag: 'imageHero' + a.i.toString(),
            child: new Image.network(
              dog.pictures[a.i],
              fit: BoxFit.contain,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
