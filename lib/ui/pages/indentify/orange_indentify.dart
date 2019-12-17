
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrangeIndentify extends StatefulWidget {
  @override
  OrangeIndentifyState createState() => new OrangeIndentifyState();
}

class OrangeIndentifyState extends State<OrangeIndentify> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('柑橘识别'),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
  }

}