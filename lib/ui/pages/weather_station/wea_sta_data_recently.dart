import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/model/wea_sta_list_data.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:beyond_user/view_modle/wea_sta_data_model.dart';
import 'package:beyond_user/model/wea_sta_data_data.dart';

///气象站最近气象数据
class WeaStaDataRecently extends StatefulWidget {
  @override
  WeaStaDataRecentlyState createState() => new WeaStaDataRecentlyState();
}

class WeaStaDataRecentlyState extends State<WeaStaDataRecently> {
  WeaStaListData deviceData;

  @override
  Widget build(BuildContext context) {
    deviceData = ModalRoute.of(context).settings.arguments;

    return new Scaffold(
      body: new Column(
        children: [
          CustomAppbarWhite('气象站'),
          Expanded(
            flex: 1,
            child: ProviderWidget<WeaStaDataModel>(
              model: WeaStaDataModel('${deviceData.imei}','',''),
              onModelReady: (model) {
                model.loadCurrentData();
              },
              builder: (ctx, model, child) {
                if (model.busy) {
                  return ViewStateBusyWidget();
                }

                return new Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 20, bottom: 14),
                      child: new Row(
                        children: [
                          Text('最新气象数据'),
                          Expanded(
                              flex: 1,
                              child: Text(
                                _getTime(model),
                                textAlign: TextAlign.right,
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/station_bg.png'),
                                  fit: BoxFit.cover)),
                          child: new Column(
                            children: [
                              //第一行数据s
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 14, bottom: 14),
                                child: new Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: new Column(
                                        children: [
                                          new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${_getData(model).term}℃',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 4),
                                                child: Text(
                                                  '正常',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 6),
                                            child: Text(
                                              '空气温度',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 35,
                                        child: VerticalDivider(
                                          width: 1,
                                          color: Colors.white,
                                        )),
                                    Expanded(
                                      flex: 1,
                                      child: new Column(
                                        children: [
                                          new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${_getData(model).hum}%',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 4),
                                                child: Text(
                                                  '正常',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 6),
                                            child: Text(
                                              '空气湿度',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 35,
                                        child: VerticalDivider(
                                          width: 1,
                                          color: Colors.white,
                                        )),
                                    Expanded(
                                      flex: 1,
                                      child: new Column(
                                        children: [
                                          new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${_getData(model).airPressure}pa',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 4),
                                                child: Text(
                                                  '正常',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 6),
                                            child: Text(
                                              '大气压',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //第一行数据结束
                              Divider(
                                height: 1,
                                color: Colors.white,
                              ),

                              //第二行数据开始
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 14, bottom: 14),
                                child: new Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: new Column(
                                        children: [
                                          new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${_getData(model).wdir}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 4),
                                                child: Text(
                                                  '正常',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 6),
                                            child: Text(
                                              '风向',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 35,
                                        child: VerticalDivider(
                                          width: 1,
                                          color: Colors.white,
                                        )),
                                    Expanded(
                                      flex: 1,
                                      child: new Column(
                                        children: [
                                          new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${_getData(model).windSpeed}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 4),
                                                child: Text(
                                                  '正常',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 6),
                                            child: Text(
                                              '风速',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 35,
                                        child: VerticalDivider(
                                          width: 1,
                                          color: Colors.white,
                                        )),
                                    Expanded(
                                      flex: 1,
                                      child: new Column(
                                        children: [
                                          new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${_getData(model).warn == null ? '无数据' : '正常'}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 4),
                                                child: Text(
                                                  '',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 6),
                                            child: Text(
                                              '雨雪',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //第二行数据结束
                              Divider(
                                height: 1,
                                color: Colors.white,
                              ),
                              //第三行数据开始
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 14, bottom: 14),
                                child: new Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: new Column(
                                        children: [
                                          new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${_getData(model).currentRainfall}mm',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 4),
                                                child: Text(
                                                  '正常',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 6),
                                            child: Text(
                                              '当日雨量',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 35,
                                        child: VerticalDivider(
                                          width: 1,
                                          color: Colors.white,
                                        )),
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(),
                                    ),
                                    Expanded(flex: 1, child: SizedBox()),
                                  ],
                                ),
                              ),
                              //第三行数据结束
                              Divider(
                                height: 1,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ))
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  //获取数据  这里暂时说是取列表数据的第一条  写个方法防止有变化
  WeaStaDataData _getData(WeaStaDataModel model) {
    return model.currentData;
  }

  String _getTime(WeaStaDataModel model) {
    //不想搞几层判空了
    try {
      WeaStaDataData data = model.currentData;
      return DateUtil.formatDateMs(data.recordTime,format: 'yyyy-MM-dd HH:mm');
    } catch (e) {
      return '';
    }
  }
}
