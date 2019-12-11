import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class MyRefreshHeader extends StatefulWidget {
  @override
  MyRefreshHeaderState createState() => new MyRefreshHeaderState();
}

class MyRefreshHeaderState extends State<MyRefreshHeader> {
  @override
  Widget build(BuildContext context) {
    return ClassicHeader(
      idleIcon: Icon(Icons.file_download,color: Theme.of(context).accentColor,),
      //refreshingIcon: Icon(Icons.refresh,),
      releaseIcon: Icon(Icons.refresh,color: Theme.of(context).accentColor,),
      completeIcon: Icon(Icons.done,color: Theme.of(context).accentColor,),
      failedText: '刷新失败',
      completeText: '刷新完成',
      refreshingText: '刷新中，请稍后~',
      releaseText: '松手以刷新',
      idleText: '继续下拉刷新',
      textStyle: TextStyle(
        fontSize: 13,
        color: Theme.of(context).accentColor
      ),
    );
  }


}