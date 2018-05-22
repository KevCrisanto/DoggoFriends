import 'package:flutter/material.dart';

class DogList extends StatefulWidget {
  @override
  _DogListState createState() => new _DogListState();
}

class _DogListState extends State<DogList> {
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
