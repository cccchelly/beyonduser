import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/model/time_area_model.dart';
import 'package:beyond_user/view_modle/lamp_controller_view_model.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:beyond_user/provider/provider_widget.dart';

class LampController extends StatefulWidget {
  @override
  LampControllerState createState() => new LampControllerState();
}

class LampControllerState extends State<LampController> {
  LampControllerViewModel _controllerViewModel;

  String did;
  TextEditingController _editingController;
  List<String> statuesList;
  List<String> waveList;
  int statueIndex = 0;
  int waveIndex = 0;
  List<String> modelStrs;
  int modelIndex = 0;
  List<TimeAreaModel> _times;

  @override
  Widget build(BuildContext context) {
    did = ModalRoute
        .of(context)
        .settings
        .arguments;

    return new Scaffold(
      body: Container(
        color: Colors.white,
        child: new Column(
          children: [
            CustomAppbarWhite('设备反控'),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: ProviderWidget<LampControllerViewModel>(
                  model: LampControllerViewModel(),
                  onModelReady: (model) {
                    _controllerViewModel = model;
                  },
                  builder: (context, child, widget) {
                    return Column(
                      children: [
                        Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                left: 13, top: 23, bottom: 4),
                            child: Text('工作状态')),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: RadioListTile(
                                    title: Text(
                                      statuesList[0],
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(
                                              LocalColors.text_222222)),
                                    ),
                                    value: statuesList[0],
                                    groupValue: statuesList[statueIndex],
                                    onChanged: (value) {
                                      setState(() {
                                        statueIndex = 0;
                                      });
                                    })),
                            Expanded(
                                flex: 1,
                                child: RadioListTile(
                                    title: Text(
                                      statuesList[1],
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(
                                              LocalColors.text_222222)),
                                    ),
                                    value: statuesList[1],
                                    groupValue: statuesList[statueIndex],
                                    onChanged: (value) {
                                      setState(() {
                                        statueIndex = 1;
                                      });
                                    })),
                            Expanded(
                                flex: 1,
                                child: RadioListTile(
                                    title: Text(
                                      statuesList[2],
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(
                                              LocalColors.text_222222)),
                                    ),
                                    value: statuesList[2],
                                    groupValue: statuesList[statueIndex],
                                    onChanged: (value) {
                                      setState(() {
                                        statueIndex = 2;
                                      });
                                    })),
                          ],
                        ),
                        _buildModel(),

                        FlatButton(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 98, vertical: 13),
                            color: Theme
                                .of(context)
                                .accentColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5))
                            ),
                            onPressed: () {
                              _controllerViewModel.setControl(
                                  did, _getControllType(), modelIndex+1, _editingController.text,
                                  _times);
                            },
                            child: Text('确定', style: TextStyle(
                                fontSize: 14, color: Colors.white),)),

                        Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                left: 13, top: 23, bottom: 4),
                            child: Text('波段控制')),

                        Container(
                          margin: const EdgeInsets.only(right: 14),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: RadioListTile(
                                      title: Text(
                                        waveList[0],
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(
                                                LocalColors.text_222222)),
                                      ),
                                      value: waveList[0],
                                      groupValue: waveList[waveIndex],
                                      onChanged: (value) {
                                        setState(() {
                                          waveIndex = 0;
                                        });
                                      })),
                              Expanded(
                                  flex: 1,
                                  child: RadioListTile(
                                      title: Text(
                                        waveList[1],
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(
                                                LocalColors.text_222222)),
                                      ),
                                      value: waveList[1],
                                      groupValue: waveList[waveIndex],
                                      onChanged: (value) {
                                        setState(() {
                                          waveIndex = 1;
                                        });
                                      })),
                              Expanded(
                                  flex: 1,
                                  child: RadioListTile(
                                      title: Text(
                                        waveList[2],
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(
                                                LocalColors.text_222222)),
                                      ),
                                      value: waveList[2],
                                      groupValue: waveList[waveIndex],
                                      onChanged: (value) {
                                        setState(() {
                                          waveIndex = 2;
                                        });
                                      })),
                              Expanded(
                                  flex: 1,
                                  child: RadioListTile(
                                      title: Text(
                                        waveList[3],
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(
                                                LocalColors.text_222222)),
                                      ),
                                      value: waveList[3],
                                      groupValue: waveList[waveIndex],
                                      onChanged: (value) {
                                        setState(() {
                                          waveIndex = 3;
                                        });
                                      })),
                            ],
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 100),
                          child: FlatButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 98, vertical: 13),
                              color: Theme
                                  .of(context)
                                  .accentColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5))
                              ),
                              onPressed: () {
                                _controllerViewModel.setBControl(
                                    did, waveIndex + 1);
                              },
                              child: Text('确定', style: TextStyle(
                                  fontSize: 14, color: Colors.white),)),
                        ),

                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getControllType() {
    switch (statueIndex) {
      case 0:
        return 2;
        break;
      case 1:
        return 3;
        break;
      case 2:
        return 1;
        break;
    }
  }

  _buildModel() {
    if (statueIndex == 2) {
      return new Column(
        children: [
          Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 13, top: 23, bottom: 14),
              child: Text('控制模式')),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                color: Color(LocalColors.bg_f4f4f4),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Center(
              child: DropdownButton(
                  items: _getModelData(),
                  value: modelStrs[modelIndex],
                  style: TextStyle(
                      fontSize: 14, color: Color(LocalColors.text_333333)),
                  underline: Container(),
                  onChanged: (content) {
                    switch (content) {
                      case '光控':
                        setState(() {
                          modelIndex = 0;
                        });
                        break;
                      case '时控':
                        setState(() {
                          modelIndex = 1;
                        });
                        break;
                    }
                  }),
            ),
          ),
          _buildControll(),
        ],
      );
    } else {
      return Container();
    }
  }

  _buildControll() {
    if (modelIndex == 1) {
      return new Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: _times.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                  const EdgeInsets.only(left: 12, right: 25, bottom: 16),
                  child: new Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            _chooseTime(index, 1, context);
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 12),
                              decoration: BoxDecoration(
                                color: Color(LocalColors.bg_f4f4f4),
                                borderRadius:
                                BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Text(
                                _times[index].startTime == 0
                                    ? '开始时间'
                                    : DateUtil.formatDateMs(
                                    _times[index].startTime, format: 'HH:mm'),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(LocalColors.text_222222)),
                              )),
                        ),
                      ),
                      Container(
                        width: 17,
                        height: 1,
                        color: Color(LocalColors.bg_999999),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            _chooseTime(index, 2, context);
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 12),
                              decoration: BoxDecoration(
                                color: Color(LocalColors.bg_f4f4f4),
                                borderRadius:
                                BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Text(
                                _times[index].endTime == 0
                                    ? '结束时间'
                                    : DateUtil.formatDateMs(
                                    _times[index].endTime, format: 'HH:mm'),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(LocalColors.text_222222)),
                              )),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            if (_times.length == 1) {
                              showToast('需要至少一个时间段');
                            } else {
                              setState(() {
                                _times.removeAt(index);
                              });
                            }
                          },
                          child: Container(
                              padding: const EdgeInsets.only(left: 15),
                              child: Image.asset('images/sk_sc.png'))),
                    ],
                  ),
                );
              }),
          InkWell(
            onTap: () {
              setState(() {
                _times.add(TimeAreaModel());
              });
            },
            child: Container(
              width: 114,
              padding: const EdgeInsets.symmetric(vertical: 8),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border:
                Border.all(width: 1, color: Theme
                    .of(context)
                    .accentColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/sk_tjsjd.png'),
                  Text(
                    '添加时段',
                    style: TextStyle(
                        fontSize: 14, color: Theme
                        .of(context)
                        .accentColor),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 13, top: 23, bottom: 4),
              child: Text('持续时长')),
          Container(
            margin:
            const EdgeInsets.only(left: 12, right: 12, top: 14, bottom: 20),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            decoration: BoxDecoration(
                color: Color(LocalColors.bg_f4f4f4),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _editingController,
                      style: TextStyle(
                          fontSize: 14, color: Color(LocalColors.text_222222)
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 14,
                            color: Color(LocalColors.text_aaaaaa)),
                        hintText: '0-720分钟',
                      ),
                    )),
                Text(
                  '分钟',
                  style: TextStyle(
                      fontSize: 14, color: Color(LocalColors.text_222222)),
                )
              ],
            ),
          ),
        ],
      );
    }
  }

  //选择时控时间
  _chooseTime(int index, int type, BuildContext context) {
    //type 1开始时间  2结束时间
    DatePicker.showTimePicker(context,
        showTitleActions: true, locale: LocaleType.zh, onConfirm: (date) {
          if (mounted) {
            setState(() {
              if (type == 1) {
                _times[index].startTime = date.millisecondsSinceEpoch;
              } else {
                _times[index].endTime = date.millisecondsSinceEpoch;
              }
            });
          }
        });
  }

  _initData() {
    if (statuesList == null) {
      statuesList = ['强制开机', '强制关机', '正常工作'].toList();
      waveList = ['波段1', '波段2', '波段3', '全部'].toList();
    }
    modelStrs = [
      '光控',
      '时控',
    ];
    _times = new List();
    //预先放置一个时间段  供选择
    _times.add(TimeAreaModel());
  }

  _getModelData() {
    return modelStrs
        .map<DropdownMenuItem<String>>((item) =>
        DropdownMenuItem<String>(
          child: Container(
              width: 250,
              child: Text(
                item,
                style: TextStyle(
                    fontSize: 14, color: Color(LocalColors.text_222222)),
              )),
          value: item,
        ))
        .toList();
  }

  @override
  void initState() {
    _initData();
    _getModelData();
    _editingController = TextEditingController();
    super.initState();
  }
}
