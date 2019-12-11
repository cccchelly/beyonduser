import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


typedef SelectCallback(int index, List<String> datas);
///自定义的滚轮选择  动态添加数据选择
class LPicker {
  static int _selectIndex;
  static FixedExtentScrollController _controller =  FixedExtentScrollController();

  static void showPicker(
    BuildContext context,
    List<String> data, {
    double pickerHeight: 200,
    Color textColor: Colors.black,
    double textSize: 14,
    Color bgColor: Colors.white,
    SelectCallback onSelect,
  }) {
    _selectIndex = 0;

    showCupertinoModalPopup(
        context: context,
        builder: (ctx) {
          return new Column(
            children: [
              Expanded(flex: 1, child: SizedBox()),
              Container(
                color: bgColor,
                child: new Row(
                  children: [
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          '取消',
                          style: TextStyle(color: Colors.black),
                        )),
                    Expanded(flex: 1, child: SizedBox()),
                    FlatButton(
                        onPressed: () {
                          onSelect(_selectIndex,data);
                          Navigator.pop(context);
                        },
                        child: Text(
                          '确定',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        )),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: pickerHeight,
                child: CupertinoPicker.builder(
                  scrollController: _controller,
                  childCount: data.length,
                  itemExtent: 30,
                  backgroundColor: bgColor,
                  onSelectedItemChanged: (index) {
                    _selectIndex = index;
                  },
                  itemBuilder: (context, index) {
                    return Center(
                        child: Text(
                      '${data[index]}',
                      style: TextStyle(fontSize: textSize, color: textColor),
                    ));
                  },
                ),
              )
            ],
          );
        });
  }
}
