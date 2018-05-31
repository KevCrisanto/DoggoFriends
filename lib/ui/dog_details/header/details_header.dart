import 'dart:async';
import 'package:doggo_friends/models/dog.dart';
import 'package:doggo_friends/services/api.dart';
import 'package:doggo_friends/ui/dog_details/header/dog_colored_image.dart';
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
  static const BACKGROUND_IMAGE = 'images/profile_header_background.jpg';
  bool _likeDisabled = true;
  String _likeText = "";
  int _likeCounter = 0;
  StreamSubscription _watcher;

  Future<DogApi> _api;

  @override
  void initState() {
    super.initState();
    _likeCounter = widget.dog.likeCounter;
    _api = DogApi.signInWithGoogle();
    updateLikeState();
  }

  void likeDog() async {
    final api = await _api;
    if (await api.hasLikedDog(widget.dog)) {
      api.unlikeDog(widget.dog);
      setState(() {
        _likeCounter -= 1;
        _likeText = "LIKE";
      });
    } else {
      api.likeDog(widget.dog);
      setState(() {
        _likeCounter += 1;
        _likeText = "UN-LIKE";
      });
    }
  }

  void updateLikeState() async {
    final api = await _api;
    _watcher = api.watch(widget.dog, (dog) {
      if (mounted) {
        setState(() {
          _likeCounter = dog.likeCounter;
        });
      }
    });

    bool liked = await api.hasLikedDog(widget.dog);
    if (mounted) {
      setState(() {
        _likeDisabled = false;
        _likeText = liked ? "UN-LIKE" : "LIKE";
      });
    }
  }

  @override
  void dispose() {
    if (_watcher != null) {
      _watcher.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var screenWidth = MediaQuery.of(context).size.width;

    var diagonalBackground = new DiagonallyCutColoredImage(
      new Image.asset(
        BACKGROUND_IMAGE,
        width: screenWidth,
        height: 280.0,
        fit: BoxFit.cover,
      ),
      color: const Color(0xBB42A5F5),
    );

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
              _likeCounter.toString(),
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
              onPressed: _likeDisabled ? null : likeDog,
              child: new Text(_likeText),
            ),
          ),
        ],
      ),
    );

    return new Stack(
      children: [
        diagonalBackground,
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
