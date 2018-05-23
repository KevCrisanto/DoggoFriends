import 'dart:async';

import 'package:doggo_friends/models/dog.dart';
import 'package:doggo_friends/services/api.dart';
import 'package:doggo_friends/ui/dog_details/details_page.dart';
import 'package:doggo_friends/utils/routes.dart';
import 'package:flutter/material.dart';

class DogList extends StatefulWidget {
  @override
  _DogListState createState() => new _DogListState();
}

class _DogListState extends State<DogList> {
  List<Dog> _dogs = [];

  @override
  void initState() {
    super.initState();
    _loadDogs();
  }

  _loadDogs() async {
    String fileData =
        await DefaultAssetBundle.of(context).loadString("assets/dogs.json");
    setState(() {
      _dogs = DogApi.allDogsFromJson(fileData);
    });
  }

  _navigateToDogDetails(Dog dog, Object avatarTag) {
    Navigator.of(context).push(new FadePageRoute(
          builder: (d) {
            return new DogDetailsPage(
              dog,
              avatarTag: avatarTag,
            );
          },
          settings: new RouteSettings(),
        ));
  }

  Widget _getAppTitleWidget() {
    return new Text(
      'Dogs',
      style: new TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 32.0,
      ),
    );
  }

  Widget _buildBody() {
    return new Container(
      margin: const EdgeInsets.fromLTRB(8.0, 56.0, 8.0, 0.0),
      child: new Column(
        children: <Widget>[
          _getAppTitleWidget(),
          _getListViewWidget(),
        ],
      ),
    );
  }

  Widget _buildDogItem(BuildContext context, int index) {
    Dog dog = _dogs[index];
    return new Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              onTap: () => _navigateToDogDetails(dog, index),
              leading: new Hero(
                tag: index,
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(dog.avatarUrl),
                ),
              ),
              title: new Text(
                dog.name,
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              subtitle: new Text(dog.description),
              isThreeLine: true,
              dense: false,
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> refresh() {
    _loadDogs();
    return new Future<Null>.value();
  }

  Widget _getListViewWidget() {
    return new Flexible(
        child: new RefreshIndicator(
      onRefresh: refresh,
      child: new ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _dogs.length,
        itemBuilder: _buildDogItem,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blue,
      body: _buildBody(),
    );
  }
}
