


import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyRefreshFooter extends StatefulWidget {
  @override
  MyRefreshFooterState createState() => new MyRefreshFooterState();
}

class MyRefreshFooterState extends State<MyRefreshFooter> {
  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
      idleIcon: Icon(Icons.arrow_upward,color: Theme.of(context).accentColor,),
      failedText: '加载失败',
      idleText: '上拉加载更多',
      noDataText: '我是有底线的~',
      textStyle: TextStyle(
          fontSize: 13,
          color: Theme.of(context).accentColor
      ),
    );
  }


}