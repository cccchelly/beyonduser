import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';

class LampMapLocal extends StatefulWidget {
  @override
  LampMapLocalState createState() => new LampMapLocalState();
}

class LampMapLocalState extends State<LampMapLocal> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: [
          CustomAppbarTheme('普通杀虫灯'),
          Expanded(flex: 1,child: _buildMapWidget()),
        ],
      ),
    );
  }

  _buildMapWidget(){
      return Text('222');
  }


  @override
  void initState() {
    super.initState();
  }

}