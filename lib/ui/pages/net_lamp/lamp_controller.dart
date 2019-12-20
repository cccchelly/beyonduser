import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/model/time_area_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';

class LampController extends StatefulWidget {
  @override
  LampControllerState createState() => new LampControllerState();
}

class LampControllerState extends State<LampController> {
  String did;
  List<String> statuesList;
  List<String> waveList;
  int statueIndex = 0;
  int waveIndex = 0;
  List<String> modelStrs;
  int modelIndex = 0;
  List<TimeAreaModel> _times;

  @override
  Widget build(BuildContext context) {
    did = ModalRoute.of(context).settings.arguments;

    return new Scaffold(
      body: Container(
        color: Colors.white,
        child: new Column(
          children: [
            CustomAppbarWhite('设备反控'),
            Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 13, top: 23, bottom: 4),
                child: Text('工作状态')),
            new Row(
              children: [
                Expanded(
                    flex: 1,
                    child: RadioListTile(
                        title: Text(
                          statuesList[0],
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(LocalColors.text_222222)),
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
                              color: Color(LocalColors.text_222222)),
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
                              color: Color(LocalColors.text_222222)),
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
          ],
        ),
      ),
    );
  }

  _buildModel() {
    if (statueIndex == 2) {
      return new Column(
        children: [
          Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 13, top: 23, bottom: 4),
              child: Text('控制模式')),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
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
                      case '时控':
                        setState(() {
                          modelIndex = 0;
                        });
                        break;
                      case '光控':
                        setState(() {
                          modelIndex = 1;
                        });
                        break;
                    }
                  }),
            ),
          ),

          ListView.builder(
            shrinkWrap: true,
              itemCount: _times.length,
              itemBuilder: (context,index){
                return new Row(
                  children: [
                    TextField(
                      onChanged: (s){

                    },)
                  ],
                );
              })

        ],
      );
    } else {
      return Container();
    }
  }

  _initData() {
    if (statuesList == null) {
      statuesList = ['强制开机', '强制关机', '正常工作'].toList();
      waveList = ['波段1', '波段2', '波段3', '全部'].toList();
    }
    modelStrs = [
      '时控',
      '光控',
    ];
    _times = new List();
  }

  _getModelData() {
    return modelStrs
        .map<DropdownMenuItem<String>>((item) => DropdownMenuItem<String>(
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
    super.initState();
  }
}
