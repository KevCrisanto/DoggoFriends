import 'package:doggo_friends/models/dog.dart';
import 'package:doggo_friends/ui/dog_details/footer/showcase_attributes.dart';
import 'package:doggo_friends/ui/dog_details/footer/showcase_details.dart';
import 'package:doggo_friends/ui/dog_details/footer/showcase_pictures.dart';
import 'package:flutter/material.dart';

class DogShowcase extends StatefulWidget {
  final Dog dog;

  DogShowcase(this.dog);

  @override
  _DogShowcaseState createState() => new _DogShowcaseState();
}

class _DogShowcaseState extends State<DogShowcase>
    with TickerProviderStateMixin {
  List<Tab> _tabs;
  List<Widget> _pages;
  TabController _controller;

  @override
  initState() {
    super.initState();
    _tabs = [
      new Tab(
        text: 'Pictures',
      ),
      new Tab(
        text: 'Details',
      ),
      new Tab(
        text: 'Attributes',
      ),
    ];
    _pages = [
      new PicturesShowcase(widget.dog),
      new DetailsShowcase(widget.dog),
      new AttributesShowcase(widget.dog),
    ];
    _controller = new TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(16.0),
      child: new Column(
        children: [
          new TabBar(
            controller: _controller,
            tabs: _tabs,
            indicatorColor: Colors.white,
          ),
          new SizedBox.fromSize(
            size: const Size.fromHeight(300.0),
            child: new TabBarView(
              controller: _controller,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}
