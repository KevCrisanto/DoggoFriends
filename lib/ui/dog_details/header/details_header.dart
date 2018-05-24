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
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    var avatar = new Hero(
      tag: widget.avatarTag,
      child: new CircleAvatar(
        backgroundImage: new NetworkImage(widget.dog.avatarUrl),
        radius: 75.0,
      ),
    );

    var likeInfo = new Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Icon(
            Icons.thumb_up,
            color: Colors.white,
            size: 16.0,
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: new Text(
              widget.dog.likeCounter.toString(),
              style: textTheme.subhead.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    var actionButtons = new Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new ClipRRect(
            borderRadius: new BorderRadius.circular(30.0),
            child: new MaterialButton(
              minWidth: 140.0,
              color: theme.accentColor,
              textColor: Colors.white,
              onPressed: () async {
                //TODO Handle Adopt
              },
              child: new Text('ADOPT ME'),
            ),
          ),
          new ClipRRect(
            borderRadius: new BorderRadius.circular(30.0),
            child: new RaisedButton(
              color: Colors.lightGreen,
              disabledColor: Colors.grey,
              textColor: Colors.white,
              onPressed: () async {
                //TODO Handle Like
              },
              child: new Text('LIKE'),
            ),
          ),
        ],
      ),
    );

    return new Stack(
      children: [
        //TODO Background Image
        new Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.4,
          child: new Column(
            children: [
              avatar,
              likeInfo,
              actionButtons,
            ],
          ),
        ),
        new Positioned(
          top: 26.0,
          left: 4.0,
          child: new BackButton(color: Colors.white),
        ),
      ],
    );
  }
}
