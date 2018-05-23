import 'package:doggo_friends/models/dog.dart';
import 'package:doggo_friends/services/api.dart';
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
    for (Dog dog in DogApi.allDogsFromJson(fileData)) {
      _dogs.add(dog);
    }
    print(_dogs.toString());
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blue,
      body: _getAppTitleWidget(),
    );
  }
}
