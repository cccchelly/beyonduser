import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LampMapNet extends StatefulWidget {
  @override
  LampMapNetState createState() => new LampMapNetState();
}

class LampMapNetState extends State<LampMapNet> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('远程杀虫灯地图'),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
  }

}