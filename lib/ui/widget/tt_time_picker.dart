import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TimeSpacePicker extends StatefulWidget {
  @override
  _TimeSpacePickerState createState() => _TimeSpacePickerState();
}

class _TimeSpacePickerState extends State<TimeSpacePicker> {
  TimeModel timeModel;
  FixedExtentScrollController _startHoursController;
  FixedExtentScrollController _startSecondsController;
  FixedExtentScrollController _endHoursController;
  FixedExtentScrollController _endSecondsController;
  List<String> startHour, startSecond, endHour, endSecond;
  List<String> flag = ["00", "00", "00", "00"];
  int startOrEnd = 0;

  ///获取控制权 1表示由开始时间控制 -1表示由结束时间控制(未实现由结束时间控制 ，ps 当对CupertinoPicker中的list重新赋值并setstate时，没有显示新list的值，滑动后时有的，这里有问题)
  @override
  void initState() {
    super.initState();
    timeModel = new TimeModel();
    _startHoursController = new FixedExtentScrollController(initialItem: 0);
    _startSecondsController = new FixedExtentScrollController(initialItem: 0);
    _endHoursController = new FixedExtentScrollController(initialItem: 0);
    _endSecondsController = new FixedExtentScrollController(initialItem: 0);
    startHour = timeModel.hours;
    startSecond = timeModel.minute;
    endHour = timeModel.hours;
    endSecond = timeModel.minute;
  }

  @override
  void dispose() {
    _startHoursController.dispose();
    _startSecondsController.dispose();
    _endHoursController.dispose();
    _endSecondsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>false,
      child: _buildTimeSelect(),
    );
  }

  Widget _buildTimeSelect() {
    return Column(
      children: <Widget>[
        Container(
          constraints: BoxConstraints(minHeight: 40, maxHeight: 40),
          child: new Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context,['','','','']);
                },
                child: new Text(
                  '取消',
                  style: new TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Spacer(),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, [
                    startHour[_startHoursController.selectedItem],
                    startSecond[_startSecondsController.selectedItem],
                    endHour[_endHoursController.selectedItem],
                    endSecond[_endSecondsController.selectedItem]
                  ]);
                },
                child: new Text(
                  '确定',
                  style: new TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: CupertinoPicker.builder(
                  scrollController: _startHoursController,
                  backgroundColor: Colors.white,
                  diameterRatio: 1.0,
                  itemExtent: 30,
                  onSelectedItemChanged: (index) {
                    _controlJumpByStart(1);
                  },
                  childCount: startHour.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Text("${startHour[index]}"),
                    );
                  },
                ),
              ),
              Expanded(
                  flex: 1,
                  child: CupertinoPicker.builder(
                    scrollController: _startSecondsController,
                    backgroundColor: Colors.white,
                    diameterRatio: 1.0,
                    itemExtent: 30,
                    onSelectedItemChanged: (index) {
                      _controlJumpByStart(1);
                    },
                    childCount: startSecond.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Text("${startSecond[index]}"),
                      );
                    },
                  )),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text("至"),
                ),
              ),
              Expanded(
                flex: 1,
                child: CupertinoPicker.builder(
                  scrollController: _endHoursController,
                  backgroundColor: Colors.white,
                  diameterRatio: 1.0,
                  itemExtent: 30,
                  onSelectedItemChanged: (index) {
//                    _controlJumpByEnd(-1);
//                    flag[2] = endHour[index];
                  },
                  childCount: endHour.length,
                  itemBuilder: (context, index) {
                    return Center(child: Text("${endHour[index]}"));
                  },
                ),
              ),
              Expanded(
                  flex: 1,
                  child: CupertinoPicker.builder(
                    scrollController: _endSecondsController,
                    backgroundColor: Colors.white,
                    diameterRatio: 1.0,
                    itemExtent: 30,
                    onSelectedItemChanged: (index) {
//                      _controlJumpByEnd(-1);
//                      flag[3] = endSecond[index];
                    },
                    childCount: endSecond.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Text("${endSecond[index]}"),
                      );
                    },
                  )),
            ],
          ),
        )
      ],
    );
  }

  _controlJumpByStart(int type) {
    if (startOrEnd == 0) {
      startOrEnd = type;
    }
    if (startOrEnd == 1) {
      flag[0] = startHour[_startHoursController.selectedItem];
      flag[1] = startSecond[_startSecondsController.selectedItem];
      flag[2] = endHour[_endHoursController.selectedItem];
      flag[3] = endSecond[_endSecondsController.selectedItem];
      endHour = timeModel.hoursTimes(start: flag[0]);
      endSecond = timeModel.minuteTimes(int.parse(flag[0]) < int.parse(flag[2]),
          start: flag[1]);
      _endHoursController.jumpToItem(endHour.indexOf(flag[2]));
      _endSecondsController.jumpToItem(endSecond.indexOf(flag[3]));
    }
    setState(() {});
  }

  ///结束时间控制（列表末尾不显示，弃用）
//   _controlJumpByEnd(int type) {
//     if (startOrEnd == 0) {
//       startOrEnd = type;
//     }
//     if (startOrEnd == -1) {
// //      flag[0] = startHour[_startHoursController.selectedItem];
// //      flag[1] = startSecond[_startSecondsController.selectedItem];
// //      flag[2] = endHour[_endHoursController.selectedItem];
// //      flag[3] = endSecond[_endSecondsController.selectedItem];
// //      endHour = timeModel.hoursTimes(start: flag[0]);
// //      endSecond = timeModel.minuteTimes(int.parse(flag[0])<int.parse(flag[2]),start: flag[1]);
// //      _endHoursController.jumpToItem(endHour.indexOf(flag[2]));
// //      _endSecondsController.jumpToItem(endSecond.indexOf(flag[3]));
// //    startHour = timeModel.hoursTimes(end: flag[2]);
//       print(startHour);
//     }
//     setState(() {});
//   }
}

class TimeModel {
  final List<String> hours = [
    "00",
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
  ];
  final List<String> minute = [
    "00",
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31",
    "32",
    "33",
    "34",
    "35",
    "36",
    "37",
    "38",
    "39",
    "40",
    "41",
    "42",
    "43",
    "44",
    "45",
    "46",
    "47",
    "48",
    "49",
    "50",
    "51",
    "52",
    "53",
    "54",
    "55",
    "56",
    "57",
    "58",
    "59",
  ];

  ///生成hours
  ///start 开始时钟
  ///end 结束时钟
  ///只传一个值
  List<String> hoursTimes({String start, String end}) {
    List time;
    if (start != null) {
      time = hours.getRange(hours.indexOf(start), hours.length).toList();
    }
    if (end != null) {
      time = hours.getRange(0, hours.indexOf(end) + 1).toList();
    }
    if (time == null) {
      time = hours;
    }
    return time;
  }

  ///生成Minute
  ///时钟是否相同主要比较时钟大小
  ///start 开始分钟
  ///end 结束分钟
  List<String> minuteTimes(bool isBig, {String start, String end}) {
    if (isBig) {
      return minute;
    }
    List time;
    if (start != null) {
      time = minute.getRange(minute.indexOf(start), minute.length).toList();
    }
    if (end != null) {
      time = minute.getRange(1, minute.indexOf(end)).toList();
    }
    if (time == null) {
      time = minute;
    }
    return time;
  }
}
