import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';

///自定义的流式布局选择器，可设置最大显示数量 提供默认的选择和非选择样式可供选择
typedef ItemBuilder(BuildContext context, int index, bool isCheck);
typedef OnCheckChanged(List<int> positions);

class LFlowLayout extends StatefulWidget {
  ItemBuilder _builder;
  OnCheckChanged _onCheckChanged;
  int _itemSize;
  int _maxCheck;

  List<bool> _isClick = new List();

  LFlowLayout(
      {ItemBuilder builder,
      OnCheckChanged onCheckChanged,
      int size,
      int maxCheck,
      List<int> defaultCheck}) {
    _itemSize = size;
    _builder = builder;
    _onCheckChanged = onCheckChanged;
    _maxCheck = maxCheck == null ? 1 : maxCheck;
    _isClick.clear();
    for (int i = 0; i < _itemSize; i++) {
      _isClick.add(false);
    }
    defaultCheck?.forEach((index) {
      _isClick[index] = true;
    });
  }

  @override
  LFlowLayoutState createState() => new LFlowLayoutState();
}

class LFlowLayoutState extends State<LFlowLayout> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _getWidgets(context),
    );
  }

  List<Widget> _getWidgets(BuildContext context) {
    List<Widget> widgetTemp = new List();

    for (int i = 0; i < widget._itemSize; i++) {
      if (widget._builder != null) {
        widgetTemp.add(GestureDetector(
          onTap: () {
            _switchCheckStatus(i);
          },
          child: widget._builder(context, i, widget._isClick[i]),
        ));
      }
    }
    return widgetTemp;
  }

  _switchCheckStatus(int index) {
    int checkCount = 0;
    widget._isClick.forEach((b) {
      if (b) {
        checkCount++;
      }
    });

    if (checkCount >= widget._maxCheck && widget._isClick[index] == false) {
      showToast('最多只能选择${widget._maxCheck}个');
    }
    /*else if(checkCount == 1 && widget._isClick[index] == true){
      showToast('至少选择1个');
    }*/
    else {
      if (mounted) {
        setState(() {
          widget._isClick[index] = !widget._isClick[index];
        });
      }
    }

    //选择下标回调
    if (widget._onCheckChanged != null) {
      List<int> checkIndexs = new List();

      for (int i = 0; i < widget._isClick.length; i++) {
        if (widget._isClick[i]) {
          checkIndexs.add(i);
        }
      }
      widget._onCheckChanged(checkIndexs);
    }
  }
}

class DefaultCheckWidget extends StatelessWidget {
  String content;

  DefaultCheckWidget(this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        margin: const EdgeInsets.all(6),
        padding:
            const EdgeInsets.only(left: 17, right: 17, top: 10, bottom: 10),
        child: Text(
          content,
          style: TextStyle(fontSize: 13, color: Colors.white),
        ));
  }
}

class DefaultUnCheckWidget extends StatelessWidget {
  String content;

  DefaultUnCheckWidget(this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color(0xffF1F1F1),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        margin: const EdgeInsets.all(6),
        padding:
            const EdgeInsets.only(left: 17, right: 17, top: 10, bottom: 10),
        child: Text(
          content,
          style: TextStyle(fontSize: 13, color: Color(0xff222222)),
        ));
  }
}
