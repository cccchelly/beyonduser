import 'package:beyond_user/config/router_config.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:beyond_user/config/app_constans.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/model/lamp_list_model.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:beyond_user/utlis/lamp_statue_util.dart';
import 'package:beyond_user/view_modle/lamp_detail_view_model.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:beyond_user/model/lamp_detail_dct_model.dart';
import 'package:oktoast/oktoast.dart';

class LampDetailNet extends StatefulWidget {
  @override
  LampDetailNetState createState() => new LampDetailNetState();
}

class LampDetailNetState extends State<LampDetailNet>
    with SingleTickerProviderStateMixin {
  List<Tab> _tabs = new List();
  TabController _tabController;
  String did;
  int staticisType = 1;
  String startAt = '2017-01-01';
  String endAt = DateUtil.formatDate(DateTime.now(), format: 'yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    did = ModalRoute.of(context).settings.arguments;
    //临时假数据
    //did = 'SN155748045544222033';

    return new Scaffold(
      body: _buildWidget(),
    );
  }

  _buildWidget() {
    return new Column(
      children: [
        CustomAppbarWhite('杀虫灯状态'),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: ProviderWidget<LampDetailViewModel>(
              model: LampDetailViewModel(),
              onModelReady: (model) {
                model.getDetail(did);
                model.getHourRport(did);
                _refreshStaticisData(model);
              },
              builder: (context, model, child) {
                if (model.busy) {
                  return ViewStateBusyWidget();
                }

                return new Column(
                  children: [
                    //杀虫灯状态
                    Container(
                      margin:
                          const EdgeInsets.only(left: 12, right: 12, top: 19),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('images/scd_dqzt.png'),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  margin: const EdgeInsets.only(left: 7),
                                  child: Text(
                                    '当前状态',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(LocalColors.text_222222)),
                                  ))),
                          InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed(RouteName.lamp_controller,arguments: did);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 10),
                                child: Text(
                                  '设备反控',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(top: 10),
                      padding:
                          const EdgeInsets.only(left: 12, top: 14, bottom: 20),
                      child: new Column(
                        children: [
                          new Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: '${AppConstans.imageUrlTemp}',
                                width: 106,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 15),
                                  child: new Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: new Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      'images/scd_zt.png'),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 12),
                                                    child: new Column(
                                                      children: [
                                                        Text(
                                                          '状态',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Color(
                                                                  LocalColors
                                                                      .text_888888)),
                                                        ),
                                                        Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 4),
                                                            child: Text(
                                                              _getLampStatuesStr(
                                                                  model),
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color(
                                                                      LocalColors
                                                                          .text_222222)),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      'images/scd_zt(1).png'),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 12),
                                                    child: new Column(
                                                      children: [
                                                        Text(
                                                          '电池',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Color(
                                                                  LocalColors
                                                                      .text_888888)),
                                                        ),
                                                        Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 4),
                                                            child: Text(
                                                              '${model?.lampDetailMsg?.vol}V',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color(
                                                                      LocalColors
                                                                          .text_222222)),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        height: 0.5,
                                        color: Color(LocalColors.bg_eeeeee),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: new Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      'images/scd_tyb.png'),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 12),
                                                    child: new Column(
                                                      children: [
                                                        Text(
                                                          '太阳板',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Color(
                                                                  LocalColors
                                                                      .text_888888)),
                                                        ),
                                                        Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 4),
                                                            child: Text(
                                                              '${model?.lampDetailMsg?.sunVol}V',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color(
                                                                      LocalColors
                                                                          .text_222222)),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      'images/scd_dianji.png'),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 12),
                                                    child: new Column(
                                                      children: [
                                                        Text(
                                                          '电击',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Color(
                                                                  LocalColors
                                                                      .text_888888)),
                                                        ),
                                                        Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 4),
                                                            child: Text(
                                                              '${model?.lampDetailMsg?.dct}次',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color(
                                                                      LocalColors
                                                                          .text_222222)),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        height: 0.5,
                                        color: Color(LocalColors.bg_eeeeee),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: new Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      'images/scd_wd.png'),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 12),
                                                    child: new Column(
                                                      children: [
                                                        Text(
                                                          '温度',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Color(
                                                                  LocalColors
                                                                      .text_888888)),
                                                        ),
                                                        Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 4),
                                                            child: Text(
                                                              '${model?.lampDetailMsg?.temp}℃',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color(
                                                                      LocalColors
                                                                          .text_222222)),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      'images/scd_sd.png'),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 12),
                                                    child: new Column(
                                                      children: [
                                                        Text(
                                                          '湿度',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Color(
                                                                  LocalColors
                                                                      .text_888888)),
                                                        ),
                                                        Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 4),
                                                            child: Text(
                                                              '${model?.lampDetailMsg?.humidity}%',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color(
                                                                      LocalColors
                                                                          .text_222222)),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 0.5,
                            color: Color(LocalColors.bg_eeeeee),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 21),
                            child: new Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset('images/scd_zxzb.png'),
                                      Container(
                                        margin: const EdgeInsets.only(left: 12),
                                        child: new Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '最新坐标',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(
                                                      LocalColors.text_888888)),
                                            ),
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    top: 4),
                                                child: Text(
                                                  '${model?.lampDetailMsg?.lat},${model?.lampDetailMsg?.lng}',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color(LocalColors
                                                          .text_222222)),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('images/scd_gy.png'),
                                      Container(
                                        margin: const EdgeInsets.only(left: 12),
                                        child: new Column(
                                          children: [
                                            Text(
                                              '高压',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(
                                                      LocalColors.text_888888)),
                                            ),
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    top: 4),
                                                child: Text(
                                                  '${model?.lampDetailMsg?.highVol}V',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color(LocalColors
                                                          .text_222222)),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 0.5,
                            color: Color(LocalColors.bg_eeeeee),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, left: 21),
                            child: new Row(
                              children: [
                                Image.asset('images/scd_txsj.png'),
                                Container(
                                  margin: const EdgeInsets.only(left: 12),
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '通信时间',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Color(LocalColors.text_888888)),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(top: 4),
                                          child: Text(
                                            '${DateUtil.formatDateMs(model?.lampDetailMsg?.time)}',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Color(
                                                    LocalColors.text_222222)),
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //当日时报
                    Container(
                      margin: const EdgeInsets.only(
                          left: 12, right: 12, top: 19, bottom: 7),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('images/scd_rb.png'),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  margin: const EdgeInsets.only(left: 7),
                                  child: Text(
                                    '当日时报',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(LocalColors.text_222222)),
                                  ))),
                        ],
                      ),
                    ),

                    _buildHourReportLines(model),

                    //报表查询
                    Container(
                      margin: const EdgeInsets.only(
                          left: 12, right: 12, top: 19, bottom: 14),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('images/scd_bbcx.png'),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  margin: const EdgeInsets.only(left: 7),
                                  child: Text(
                                    '报表查询',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(LocalColors.text_222222)),
                                  ))),
                          _buildTimeSwitchWidget(model),
                        ],
                      ),
                    ),

                    Container(
                      color: Colors.white,
                      child: new Row(
                        children: [
                          Expanded(flex: 1, child: Container()),
                          InkWell(
                            onTap: () {
                              _onTimeCheckClick(context, model);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 14, right: 12),
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 8, bottom: 8),
                              decoration: BoxDecoration(
                                color: Color(LocalColors.bg_f1f1f1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13)),
                              ),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.end,
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

                    _buildStatistics(model),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  _buildHourReportLines(LampDetailViewModel model) {
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: model.hourData.length == 0
          ? Center(
              child: Text('暂无数据'),
            )
          : FlChart(
              chart: LineChart(
                LineChartData(
                  lineTouchData: const LineTouchData(enabled: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _getPoints(model.hourData),
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
                        colors: [Colors.deepPurple.withOpacity(0.2)],
                      ),
                      dotData: FlDotData(
                        //显示的点
                        show: true,
                        dotSize: 1.5,
                        dotColor: Color(LocalColors.bg_006F2D),
                      ),
                    ),
                  ],
                  minY: 0,
                  maxY: _getMaxY(model.hourData),
                  minX: 0,
                  maxX: _getMaxX(model.hourData),
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
                          if ((value % _getXDurtion(model.hourData) == 0) &&
                              value <= model.hourData.length - 1) {
                            return '${DateUtil.formatDateMs(model.hourData[value.toInt()].statDate, format: 'yyyy-MM-dd')}';
                          } else {
                            return '';
                          }
                        }),
                    leftTitles: SideTitles(
                      showTitles: true,
                      textStyle: TextStyle(
                          fontSize: 11, color: Color(LocalColors.text_888888)),
                      getTitles: (value) {
                        if (value % _getYDurtion(model.hourData) == 0) {
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
                            color: Color(LocalColors.bg_85C226),
                            strokeWidth: 0.5);
                      },
                      checkToShowVerticalGrid: (double value) {
                        //要显示的网格
                        return value % _getYDurtion(model.hourData) == 0;
                      }),
                  borderData: FlBorderData(
                      show: true,
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 1),
                        left: BorderSide(color: Colors.black, width: 1),
                        right: BorderSide(color: Colors.transparent, width: 1),
                        top: BorderSide(
                          color: Colors.transparent,
                        ),
                      )),
                ),
              ),
            ),
    );
  }

  _buildStatistics(LampDetailViewModel model) {
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: model.staticisData.length == 0
          ? Center(
              child: Text('暂无数据'),
            )
          : FlChart(
              chart: LineChart(
                LineChartData(
                  lineTouchData: const LineTouchData(enabled: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _getPoints(model.staticisData),
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
                        colors: [Colors.deepPurple.withOpacity(0.2)],
                      ),
                      dotData: FlDotData(
                        //显示的点
                        show: true,
                        dotSize: 1.5,
                        dotColor: Color(LocalColors.bg_006F2D),
                      ),
                    ),
                  ],
                  minY: 0,
                  maxY: _getMaxY(model.staticisData),
                  minX: 0,
                  maxX: _getMaxX(model.staticisData),
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
                          if ((value % _getXDurtion(model.staticisData) == 0) &&
                              value <= model.staticisData.length - 1) {
                            return '${DateUtil.formatDateMs(model.staticisData[value.toInt()].statDate, format: 'yyyy-MM-dd')}';
                          } else {
                            return '';
                          }
                        }),
                    leftTitles: SideTitles(
                      showTitles: true,
                      textStyle: TextStyle(
                          fontSize: 11, color: Color(LocalColors.text_888888)),
                      getTitles: (value) {
                        if (value % _getYDurtion(model.staticisData) == 0) {
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
                            color: Color(LocalColors.bg_85C226),
                            strokeWidth: 0.5);
                      },
                      checkToShowVerticalGrid: (double value) {
                        //要显示的网格
                        return value % _getYDurtion(model.staticisData) == 0;
                      }),
                  borderData: FlBorderData(
                      show: true,
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 1),
                        left: BorderSide(color: Colors.black, width: 1),
                        right: BorderSide(color: Colors.transparent, width: 1),
                        top: BorderSide(
                          color: Colors.transparent,
                        ),
                      )),
                ),
              ),
            ),
    );
  }

  //日月年报表切换
  _buildTimeSwitchWidget(LampDetailViewModel model) {
    return new Row(
      children: [
        InkWell(
          onTap: (){
            setState(() {
              staticisType = 1;
              _refreshStaticisData(model);
            });
          },
          child: Container(
              decoration: BoxDecoration(
                color: staticisType == 1
                    ? Theme.of(context).accentColor : Color(LocalColors.bg_eeeeee),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
              child: Text('日报表',style: TextStyle(fontSize: 13,color: staticisType == 1
                  ? Colors.white : Color(LocalColors.text_222222)),),),
        ),
        InkWell(
          onTap: (){
            setState(() {
              staticisType = 2;
              _refreshStaticisData(model);
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: staticisType == 2
                  ? Theme.of(context).accentColor : Color(LocalColors.bg_eeeeee),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
            child: Text('月报表',style: TextStyle(fontSize: 13,color: staticisType == 2
                ? Colors.white : Color(LocalColors.text_222222)),),),
        ),
        InkWell(
          onTap: (){
            setState(() {
              staticisType = 3;
              _refreshStaticisData(model);
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: staticisType == 3
                  ? Theme.of(context).accentColor : Color(LocalColors.bg_eeeeee),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
            child: Text('年报表',style: TextStyle(fontSize: 13,color: staticisType == 3
                ? Colors.white : Color(LocalColors.text_222222)),),),
        ),
      ],
    );
  }

  ///获取Y轴最大值  因为有可能数据全部为0  这种情况框架画不出来数据 需要特殊处理
  ///如果是这种情况就返回固定最大值
  double _getMaxY(List<LampDetailDctModel> lineData) {
    int max = 0;
    lineData.forEach((item) {
      if (item.dct >= max) max = item.dct;
    });
    if (max == 0) {
      return 10;
    } else {
      return max.toDouble();
    }
  }

  ///获取X轴最大值  只有一组数据的时候如果不设置这个会导致表格布局高度错误  感觉是个bug
  double _getMaxX(List<LampDetailDctModel> lineData) {
    return lineData.length.toDouble();
  }

  ///获取X轴显示数据的间隔  防止数据过多显示太难看
  ///根据x轴数据的下标长度算
  int _getXDurtion(List<LampDetailDctModel> lineData) {
    int showCount = 4; //要显示的数量

    if (lineData.length <= showCount) {
      return 1;
    }

    return (lineData.length) ~/ showCount;
  }

  ///获取Y轴显示数据的间隔  防止数据过多显示太难看
  ///根据y轴的数据的最大值来确定
  int _getYDurtion(List<LampDetailDctModel> lineData) {
    int showCount = 5; //要显示的数量

    int max = 0;
    lineData.forEach((item) {
      if (item.dct >= max) max = item.dct;
    });

    //数据全是0的时候直接默认间隔是1
    if (max == 0) {
      return 1;
    }

    return max ~/ showCount;
  }

  /// 将获取到的数据转换成图表框架需要的点 因为后台返回的横坐标为string
  /// 而框架要求传doble  所以这里返回的点不是真实数据  而是数据下标
  /// 真实数据在设置数据的时候从对应的横纵坐标数据中根据下标去取
  /// 纵坐标为真实的数据值
  List<FlSpot> _getPoints(List<LampDetailDctModel> lineData) {
    List<FlSpot> flspots = new List();

    for (int i = 0; i < lineData.length; i++) {
      flspots.add(FlSpot(i.toDouble(), lineData[i].dct.toDouble()));
    }
    return flspots;
  }

  ///选择时间
  void _onTimeCheckClick(BuildContext context, LampDetailViewModel model) {
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
              _refreshStaticisData(model);
            });
          }
        }
      });
    });
  }

  //获取统计报表数据
  _refreshStaticisData(LampDetailViewModel model) {
    model.getStaticis(startAt, endAt, did, staticisType);
  }

  _getLampStatuesStr(LampDetailViewModel model) {
    LampStatueUtil statueUtil = LampStatueUtil(model.lampDetailMsg.status,
        lastTimeMills: model.lampDetailMsg.time);
    switch (statueUtil.getLampStatuesEnum()) {
      case LampStatueUtil.normal:
        return '正常';
      case LampStatueUtil.wait:
        return '待机';
      case LampStatueUtil.netError:
        return '网络异常';
      case LampStatueUtil.bad:
        return '故障';
      case LampStatueUtil.unknown:
        return '未知';
    }
  }

  @override
  void initState() {
    super.initState();
  }
}
