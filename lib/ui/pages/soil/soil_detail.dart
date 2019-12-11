import 'package:fl_chart/fl_chart.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:beyond_user/model/soil_data.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:beyond_user/view_modle/soil_detail_model.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:oktoast/oktoast.dart';
import 'package:beyond_user/utlis/log_util.dart';

class SoilDetail extends StatefulWidget {
  @override
  SoilDetailState createState() => new SoilDetailState();
}

class SoilDetailState extends State<SoilDetail> {
  SoilData device;
  String startAt = '';
  String endAt = '';

  @override
  Widget build(BuildContext context) {
    device = ModalRoute.of(context).settings.arguments;

    return new Scaffold(
      body: new Column(
        children: [
          CustomAppbarWhite('土壤墒情'),
          Expanded(
              flex: 1,
              child: ListView(
                children: <Widget>[
                  ProviderWidget<SoilDetailModel>(
                    model: SoilDetailModel(),
                    onModelReady: (model) {
                      _refreshData(model);
                    },
                    builder: (context, model, child) {
                      if (model.busy) {
                        return ViewStateBusyWidget();
                      }

                      return  Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 12, right: 12,bottom: 15),
                            child: new Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      '最新土壤数据',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(LocalColors.text_222222)),
                                    )),
                                InkWell(
                                  onTap: () {
                                    _refreshData(model);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 2, bottom: 2),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).accentColor,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                    ),
                                    child: new Row(
                                      children: [
                                        Image.asset('images/trsq_sx.png'),
                                        Container(
                                            margin: const EdgeInsets.only(left: 4),
                                            child: Text(
                                              '刷新',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),


                          //最新数据start
                          Container(
                            margin: const EdgeInsets.only(left: 12, right: 12),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(5))),
                            child: new Column(
                              children: [
                                Container(
                                  margin:
                                  const EdgeInsets.only(top: 20, bottom: 13),
                                  child: new Row(
                                    children: [
                                      Expanded(flex: 1, child: SizedBox()),
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: Text(
                                                '表层土',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color:
                                                    Color(LocalColors.text_444444)),
                                              ))),
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: Text(
                                                '浅层土',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color:
                                                    Color(LocalColors.text_444444)),
                                              ))),
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: Text(
                                                '深层土',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color:
                                                    Color(LocalColors.text_444444)),
                                              ))),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  color: Color(LocalColors.bg_dddddd),
                                ),
                                Container(
                                  margin:
                                  const EdgeInsets.only(top: 13, bottom: 13),
                                  child: new Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: Text(
                                                '土壤温度',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color:
                                                    Color(LocalColors.text_444444)),
                                              ))),
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: Text(
                                                _getNewData(model, 1, 0),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                    Theme.of(context).accentColor),
                                              ))),
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: Text(
                                                _getNewData(model, 1, 1),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                    Theme.of(context).accentColor),
                                              ))),
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: Text(
                                                _getNewData(model, 1, 2),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                    Theme.of(context).accentColor),
                                              ))),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  color: Color(LocalColors.bg_dddddd),
                                ),
                                Container(
                                  margin:
                                  const EdgeInsets.only(top: 13, bottom: 13),
                                  child: new Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: Text(
                                                '土壤湿度',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color:
                                                    Color(LocalColors.text_444444)),
                                              ))),
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: Text(
                                                _getNewData(model, 2, 0),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                    Theme.of(context).accentColor),
                                              ))),
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: Text(
                                                _getNewData(model, 2, 1),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                    Theme.of(context).accentColor),
                                              ))),
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: Text(
                                                _getNewData(model, 2, 2),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                    Theme.of(context).accentColor),
                                              ))),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  color: Color(LocalColors.bg_dddddd),
                                ),
                                SizedBox(
                                  height: 26,
                                )
                              ],
                            ),
                          ),
                          //最新数据end

                          Container(
                            margin: const EdgeInsets.only(left: 12,right: 12,top: 25,bottom: 13),
                            child: new Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      '历史土壤数据',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(LocalColors.text_222222)),
                                    )),
                                InkWell(
                                  onTap: () {
                                    _onTimeCheckClick(context, model);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 8, bottom: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(13)),
                                    ),
                                    child: new Row(
                                      children: [
                                        Text(
                                          startAt.isEmpty || endAt.isEmpty
                                              ? '请选择时间'
                                              : '$startAt - $endAt',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color(LocalColors.text_222222)),
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(left: 9),
                                            child: Image.asset('images/cq_xljt.png')),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),

                          //历史土壤数据
                          Container(
                            color: Colors.white,
                            child: new Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 16,left: 12,right: 12),
                                  child: new Row(
                                    children: [
                                      Expanded(flex: 1,child: SizedBox()),
                                      Container(
                                        width: 15,
                                        height: 2,
                                        color: Color(LocalColors.bg_006F2D),
                                      ),
                                      Container(margin: const EdgeInsets.only(left: 2),child: Text('表层土',style: TextStyle(fontSize: 12,color: Color(LocalColors.text_666666)),)),
                                      Container(
                                        margin: const EdgeInsets.only(left: 29),
                                        width: 15,
                                        height: 2,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      Container(margin: const EdgeInsets.only(left: 2),child: Text('浅层土',style: TextStyle(fontSize: 12,color: Color(LocalColors.text_666666)),)),
                                      Container(
                                        margin: const EdgeInsets.only(left: 29),
                                        width: 15,
                                        height: 2,
                                        color: Color(LocalColors.bg_C27209),
                                      ),
                                      Container(margin: const EdgeInsets.only(left: 2),child: Text('深层土',style: TextStyle(fontSize: 12,color: Color(LocalColors.text_666666)),)),


                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 19,bottom: 15),
                                  child: Center(
                                    child: Text('土壤温度',style: TextStyle(fontSize: 14,color: Color(LocalColors.text_006F2D)),),
                                  ),
                                ),
                                Container(width: double.infinity,margin: const EdgeInsets.only(left: 12,bottom: 4),child: Text('温度(℃)',style: TextStyle(fontSize: 12,color: Color(LocalColors.text_666666)),textAlign: TextAlign.start,)),

                                _buildTempLines(context, model),

                                Container(
                                  margin: const EdgeInsets.only(top: 14,bottom: 14),
                                  child: Center(
                                    child: Text('土壤湿度',style: TextStyle(fontSize: 14,color: Color(LocalColors.text_006F2D)),),
                                  ),
                                ),
                                Container(width: double.infinity,margin: const EdgeInsets.only(left: 12,bottom: 4),child: Text('湿度(%)',style: TextStyle(fontSize: 12,color: Color(LocalColors.text_666666)),textAlign: TextAlign.start,)),


                                _buildHumLines(context, model),
                              ],
                            ),
                          )

                        ],
                      );
                    },
                  )
                ],
              ))
        ],
      ),
    );
  }

  //默认进来先展示最近七天的数据
  @override
  void initState() {
    super.initState();
    DateTime nowTime = DateTime.now();
    startAt = DateUtil.formatDate(nowTime.add(Duration(days: -7)), format: 'yyyy-MM-dd');
    endAt = DateUtil.formatDate(nowTime, format: 'yyyy-MM-dd');
  }

  ///温度曲线
  Widget _buildTempLines(BuildContext context,SoilDetailModel model){
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(
          left: 10, right: 30,),
      child: model.busy
          ? Center(
        child: Text('加载数据中。。。'),
      )
          : model.keys == null ||
          model.keys.length == 0
          ? Center(
        child: Text('暂无数据'),
      )
          : FlChart(
        chart: LineChart(
          LineChartData(
            lineTouchData:
            const LineTouchData(enabled: false),
            lineBarsData: [
              //表层土数据
              LineChartBarData(
                spots: _getPoints(model,0,0),
                isCurved: false,
                //线条是否弯曲平滑
              barWidth: 1,

                colors: [
                  //线条颜色  可设置渐变
                  Color(LocalColors.bg_006F2D)
                ],
                belowBarData: BelowBarData(
                  //线条下面的区域着色
                  show: false,
                  colors: [
                    Colors.deepPurple.withOpacity(0.2)
                  ],
                ),
                dotData: FlDotData(
                  //显示的点
                  show: true,
                  dotSize: 1.5,
                  dotColor: Color(LocalColors.bg_006F2D),
                ),
              ),
              //浅层土数据
              LineChartBarData(
                spots: _getPoints(model,0,1),
                isCurved: false,
                //线条是否弯曲平滑
                barWidth: 1,
                colors: [
                  //线条颜色  可设置渐变
                  Theme.of(context).accentColor
                ],
                belowBarData: BelowBarData(
                  //线条下面的区域着色
                  show: false,
                  colors: [
                    Colors.deepPurple.withOpacity(0.2)
                  ],
                ),
                dotData: FlDotData(
                  //显示的点
                  show: true,
                  dotSize: 1.5,
                  dotColor: Theme.of(context).accentColor,
                ),
              ),
              //深层土数据
              LineChartBarData(
                spots: _getPoints(model,0,2),
                isCurved: false,
                //线条是否弯曲平滑
                barWidth: 1,
                colors: [
                  //线条颜色  可设置渐变
                  Color(LocalColors.bg_C27209)
                ],
                belowBarData: BelowBarData(
                  //线条下面的区域着色
                  show: false,
                  colors: [
                    Colors.deepPurple.withOpacity(0.2)
                  ],
                ),
                dotData: FlDotData(
                  //显示的点
                  show: true,
                  dotSize: 1.5,
                  dotColor: Color(LocalColors.bg_C27209),
                ),
              ),

            ],
            minY: 0,
            maxY: _getMaxY(model,0),
            minX: 0,
            maxX: _getMaxX(model),
            titlesData: FlTitlesData(
              //绘制上下左右坐标数
              bottomTitles: SideTitles(
                  showTitles: true,
                  textStyle: TextStyle(
                    fontSize: 11,
                    color: Color(LocalColors.text_888888),
                  ),
                  getTitles: (value) {
                    //value是横坐标的对应数据下标 这里有个问题 比如数据有5条  这个下标是0-5 所以要先判断不然取数据时要越界
                    if ((value %
                        _getXDurtion(
                            model) ==
                        0) &&
                        value <=
                            model.keys.length -
                                1) {
                      return '${model.keys[value.toInt()]}';
                    } else {
                      return '';
                    }
                  }),
              leftTitles: SideTitles(
                showTitles: true,
                textStyle: TextStyle(
                    fontSize: 11,
                    color: Color(LocalColors.text_888888)),
                getTitles: (value) {
                  if (value %
                      _getYDurtion(model,0) ==
                      0) {
                    return '${value.toInt()}';
                  } else {
                    return '';
                  }
                },
              ),
            ),
            gridData: FlGridData(
                show: true,
                drawVerticalGrid: true,
                getDrawingVerticalGridLine: (value) {
                  return FlLine(
                      color: Color(LocalColors.bg_dddddd),
                      strokeWidth: 0.5);
                },
                checkToShowVerticalGrid: (double value) {
                  //要显示的网格
                  return value %
                      _getYDurtion(model,0) ==
                      0;
                }),
            borderData: FlBorderData(
                show: true,
                border: Border(
                  bottom: BorderSide(
                      color: Colors.black, width: 1),
                  left: BorderSide(
                      color: Colors.black, width: 1),
                  right: BorderSide(
                      color: Colors.transparent, width: 1),
                  top: BorderSide(
                    color: Colors.transparent,
                  ),
                )),
          ),
        ),
      ),
    );
  }

  ///湿度曲线
  Widget _buildHumLines(BuildContext context,SoilDetailModel model){
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(
          left: 10, right: 30, bottom: 20),
      child: model.busy
          ? Center(
        child: Text('加载数据中。。。'),
      )
          : model.keys == null ||
          model.keys.length == 0
          ? Center(
        child: Text('暂无数据'),
      )
          : FlChart(
        chart: LineChart(
          LineChartData(
            lineTouchData:
            const LineTouchData(enabled: false),
            lineBarsData: [
              //表层土数据
              LineChartBarData(
                spots: _getPoints(model,1,0),
                isCurved: false,
                //线条是否弯曲平滑
                barWidth: 1,
                colors: [
                  //线条颜色  可设置渐变
                  Color(LocalColors.bg_006F2D)
                ],
                belowBarData: BelowBarData(
                  //线条下面的区域着色
                  show: false,
                  colors: [
                    Colors.deepPurple.withOpacity(0.2)
                  ],
                ),
                dotData: FlDotData(
                  //显示的点
                  show: true,
                  dotSize: 1.5,
                  dotColor: Color(LocalColors.bg_006F2D),
                ),
              ),
              //浅层土数据
              LineChartBarData(
                spots: _getPoints(model,1,1),
                isCurved: false,
                //线条是否弯曲平滑
                barWidth: 1,
                colors: [
                  //线条颜色  可设置渐变
                  Theme.of(context).accentColor
                ],
                belowBarData: BelowBarData(
                  //线条下面的区域着色
                  show: false,
                  colors: [
                    Colors.deepPurple.withOpacity(0.2)
                  ],
                ),
                dotData: FlDotData(
                  //显示的点
                  show: true,
                  dotSize: 1.5,
                  dotColor: Theme.of(context).accentColor,
                ),
              ),
              //深层土数据
              LineChartBarData(
                spots: _getPoints(model,1,2),
                isCurved: false,
                //线条是否弯曲平滑
                barWidth: 1,
                colors: [
                  //线条颜色  可设置渐变
                  Color(LocalColors.bg_C27209)
                ],
                belowBarData: BelowBarData(
                  //线条下面的区域着色
                  show: false,
                  colors: [
                    Colors.deepPurple.withOpacity(0.2)
                  ],
                ),
                dotData: FlDotData(
                  //显示的点
                  show: true,
                  dotSize: 1.5,
                  dotColor: Color(LocalColors.bg_C27209),
                ),
              ),

            ],
            minY: 0,
            maxY: _getMaxY(model,1),
            minX: 0,
            maxX: _getMaxX(model),
            titlesData: FlTitlesData(
              //绘制上下左右坐标数
              bottomTitles: SideTitles(
                  showTitles: true,
                  textStyle: TextStyle(
                    fontSize: 11,
                    color: Color(LocalColors.text_888888),
                  ),
                  getTitles: (value) {
                    //value是横坐标的对应数据下标 这里有个问题 比如数据有5条  这个下标是0-5 所以要先判断不然取数据时要越界
                    if ((value %
                        _getXDurtion(
                            model) ==
                        0) &&
                        value <=
                            model.keys.length -
                                1) {
                      return '${model.keys[value.toInt()]}';
                    } else {
                      return '';
                    }
                  }),
              leftTitles: SideTitles(
                showTitles: true,
                textStyle: TextStyle(
                    fontSize: 11,
                    color: Color(LocalColors.text_888888)),
                getTitles: (value) {
                  if (value %
                      _getYDurtion(model,1) ==
                      0) {
                    return '${value.toInt()}';
                  } else {
                    return '';
                  }
                },
              ),
            ),
            gridData: FlGridData(
                show: true,
                drawVerticalGrid: true,
                getDrawingVerticalGridLine: (value) {
                  return FlLine(
                      color: Color(LocalColors.bg_dddddd),
                      strokeWidth: 0.5);
                },
                checkToShowVerticalGrid: (double value) {
                  //要显示的网格
                  return value %
                      _getYDurtion(model,1) ==
                      0;
                }),
            borderData: FlBorderData(
                show: true,
                border: Border(
                  bottom: BorderSide(
                      color: Colors.black, width: 1),
                  left: BorderSide(
                      color: Colors.black, width: 1),
                  right: BorderSide(
                      color: Colors.transparent, width: 1),
                  top: BorderSide(
                    color: Colors.transparent,
                  ),
                )),
          ),
        ),
      ),
    );
  }

  ///获取Y轴最大值  因为有可能数据全部为0  这种情况框架画不出来数据 需要特殊处理
  ///如果是这种情况就返回固定最大值
  ///type 0 温度  1湿度
  double _getMaxY(SoilDetailModel lineData,int type) {

    num max = 0;
    lineData.details.forEach((item) { //双重循环 找出所有数据中最大值
      item.forEach((inner){
        if(type == 0){
          if (inner.temperature >= max) max = inner.temperature;
        }else if (type == 1){
          if (inner.humidity*100 >= max) max = inner.humidity*100;
        }
      });
    });
    //MyLogUtil.log('Y轴最大值= $max');

    if (max == 0) {
      return 10;
    } else {
      return max.toDouble();
    }

  }

  ///获取X轴最大数量  只有一组数据的时候如果不设置这个会导致表格布局高度错误  感觉是个bug
  double _getMaxX(SoilDetailModel lineData) {
    return lineData.keys.length.toDouble();
  }

  ///获取X轴显示数据的间隔  防止数据过多显示太难看
  ///根据x轴数据的下标长度算
  int _getXDurtion(SoilDetailModel lineData) {
    int showCount = 4; //要显示的数量

    if (lineData.keys.length <= showCount) {
      return 1;
    }

    return (lineData.keys.length) ~/ showCount;
  }

  ///获取Y轴显示数据的间隔  防止数据过多显示太难看
  ///根据y轴的数据的最大值来确定
  int _getYDurtion(SoilDetailModel lineData,int type) {
    int showCount = 5; //要显示的数量

    num max = 0;
    lineData.details.forEach((item) { //双重循环 找出所有数据中最大值
      item.forEach((inner){
        if(type == 0){
          if (inner.temperature >= max) max = inner.temperature;
        }else if (type == 1){
          if (inner.humidity*100 >= max) max = inner.humidity*100;
        }
      });
    });
   
    //数据全是0的时候直接默认间隔是1
    if ( max == 0) {
      return 1;
    }

    return max ~/ showCount;
  }

  /// 将获取到的数据转换成图表框架需要的点 因为后台返回的横坐标为string
  /// 而框架要求传doble  所以这里返回的点不是真实数据  而是数据下标
  /// 真实数据在设置数据的时候从对应的横纵坐标数据中根据下标去取
  /// 纵坐标为真实的数据值
  /// ///type 0 温度  1湿度
  /// index 三组数据下标  分土壤三层  土壤后台返回数据是小数  展示是百分比  所以放大100倍
  List<FlSpot> _getPoints(SoilDetailModel lineData,int type,int index) {
    List<FlSpot> flspots = new List();

    for (int i = 0; i < lineData.keys.length; i++) {
      if(type == 0) {
        flspots.add(FlSpot(i.toDouble(), lineData.details[i][index].temperature.toDouble()));
      }else if(type == 1){
        flspots.add(FlSpot(i.toDouble(), lineData.details[i][index].humidity*100.toDouble()));
      }
    }
    return flspots;
  }


  ///选择时间
  void _onTimeCheckClick(BuildContext context, SoilDetailModel model) {
    DateTime startimeTemp;
    DateTime endTimeTemp;

    showToast('请选择开始时间');

    ///先选择开始时间  再选择结束时间
    DatePicker.showDatePicker(context,
        showTitleActions: true, locale: LocaleType.zh, onConfirm: (startDate) {
          startimeTemp = startDate;

          showToast('请选择结束时间');

          ///开始时间选择完毕马上选择结束时间
          DatePicker.showDatePicker(context,
              showTitleActions: true, locale: LocaleType.zh, onConfirm: (endDate) {
                endTimeTemp = endDate;

                if (startimeTemp.isAfter(endTimeTemp)) {
                  showToast('结束时间应在开始时间之后');
                } else {
                  if (mounted) {
                    setState(() {
                      startAt = DateUtil.formatDate(startimeTemp, format: 'yyyy-MM-dd');
                      endAt = DateUtil.formatDate(endTimeTemp, format: 'yyyy-MM-dd');
                      _refreshData(model);
                    });
                  }
                }
              });
        });
  }

  //获取数据
  _refreshData(SoilDetailModel model){
    model.getDetail(device.id, startAt, endAt);
  }

  //获取最近的温湿度数据  防止后台数据乱给统一try catch
  String _getNewData(SoilDetailModel model, int type, int index) {
    try {
      switch (type) {
        case 1: //温度
          return '${model.newestListBean[0]?.moistureRecordDetails[index]?.temperature}℃';
          break;
        case 2: //湿度
          return '${model.newestListBean[0]?.moistureRecordDetails[index]?.humidity}%';
          break;
        default:
          return '';
          break;
      }
    } catch (e) {
      return '';
    }
  }

}
