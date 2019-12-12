
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:beyond_user/config/app_constans.dart';
import 'package:beyond_user/model/spore_list_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SporeDetail extends StatefulWidget {
  @override
  SporeDetailState createState() => new SporeDetailState();
}

class SporeDetailState extends State<SporeDetail> {
  SporeListData sporeListData;

  @override
  Widget build(BuildContext context) {
    sporeListData = ModalRoute.of(context).settings.arguments;

    return new Scaffold(
      body: Text('222222'),
    );
  }
  @override
  void initState(){
    super.initState();
  }


}