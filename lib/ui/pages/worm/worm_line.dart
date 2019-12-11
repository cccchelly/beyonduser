import 'package:flutter/material.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/config/router_config.dart';
import 'package:beyond_user/model/worm_list_data.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:flustars/flustars.dart';
import 'package:beyond_user/ui/widget/my_drawer.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/model/worm_line_data.dart';
import 'package:beyond_user/model/worm_line_choose_data.dart';
import 'package:beyond_user/view_modle/worm_line_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:beyond_user/utlis/log_util.dart';
import 'package:beyond_user/ui/widget/choose_widget.dart';

class WormLine extends StatefulWidget {
  @override
  WormLineState createState() => new WormLineState();
}

class WormLineState extends State<WormLine> {
  WormListData defaultData;
  String crop = '';
  String cropCode = '';
  String insectTypes = '';
  String insectTypesCode = '';
  String stages = '';
  String stagesCode = '';
  String startAt = '';
  String endAt = '';

  @override
  Widget build(BuildContext context) {
    defaultData = ModalRoute.of(context).settings.arguments;

    return new ProviderWidget<WormLineModel>(
      model: WormLineModel(),
      onModelReady: (model) {
        model.getPullDown();
        _refreshLineData(model);
      },
      builder: (ctx, model, child) {
        return Scaffold(
          endDrawer: MyDrawer(
            widthPercent: 0.66,
            child: Container(
              width: 120,
              height: double.infinity,
              child: Center(
                child: _buildDrawer(model),
              ),
            ),
          ),
          body: new Column(
            children: [
              CustomAppbarWhite(
                '虫情曲线',
                actionWidget: Builder(builder: (ctx) {
                  return ChooseBotton(() {
                    var scaffoldStatus = Scaffold.of(ctx);
                    if (scaffoldStatus.isEndDrawerOpen) {
                      Navigator.of(context).pop();
                    } else {
                      scaffoldStatus.openEndDrawer();
                    }
                  });
                }),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 13, bottom: 13),
                child: new Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                          '当前虫情数据',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(LocalColors.text_222222)),
                        )),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 200,
                padding: const EdgeInsets.only(
                    left: 10, right: 30, top: 20, bottom: 20),
                child: model.busy
                    ? Center(
                        child: Text('加载数据中。。。'),
                      )
                    : model.lineData == null ||
                            model.lineData.xData == null ||
                            model.lineData.xData.length == 0
                        ? Center(
                            child: Text('暂无数据'),
                          )
                        : FlChart(
                            chart: LineChart(
                              LineChartData(
                                lineTouchData:
                                    const LineTouchData(enabled: false),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: _getPoints(model.lineData),
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
                                ],
                                minY: 0,
                                maxY: _getMaxY(model.lineData),
                                minX: 0,
                                maxX: _getMaxX(model.lineData),
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
                                                        model.lineData) ==
                                                0) &&
                                            value <=
                                                model.lineData.xData.length -
                                                    1) {
                                          return '${model.lineData.xData[value.toInt()]}';
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
                                              _getYDurtion(model.lineData) ==
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
                                          color: Color(LocalColors.bg_85C226),
                                          strokeWidth: 0.5);
                                    },
                                    checkToShowVerticalGrid: (double value) {
                                      //要显示的网格
                                      return value %
                                              _getYDurtion(model.lineData) ==
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
              ),
              new Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '农作物：',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(LocalColors.text_666666)),
                          ),
                          Text(
                            crop.isEmpty ? '所有' : crop,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(LocalColors.text_222222)),
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '虫种：',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(LocalColors.text_666666)),
                          ),
                          Text(
                            insectTypes.isEmpty ? '所有' : insectTypes,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(LocalColors.text_222222)),
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '虫型：',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(LocalColors.text_666666)),
                          ),
                          Text(
                            stages.isEmpty ? '所有' : stages,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(LocalColors.text_222222)),
                          ),
                        ],
                      )),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  ///获取Y轴最大值  因为有可能数据全部为0  这种情况框架画不出来数据 需要特殊处理
  ///如果是这种情况就返回固定最大值
  double _getMaxY(WormLineData lineData) {
    int max = 0;
    lineData.yData.forEach((item) {
      if (item >= max) max = item;
    });
    if (max == 0) {
      return 10;
    } else {
      return max.toDouble();
    }
  }

  ///获取X轴最大值  只有一组数据的时候如果不设置这个会导致表格布局高度错误  感觉是个bug
  double _getMaxX(WormLineData lineData) {
    return lineData.xData.length.toDouble();
  }

  ///获取X轴显示数据的间隔  防止数据过多显示太难看
  ///根据x轴数据的下标长度算
  int _getXDurtion(WormLineData lineData) {
    int showCount = 4; //要显示的数量

    if (lineData.xData.length <= showCount) {
      return 1;
    }

    return (lineData.xData.length) ~/ showCount;
  }

  ///获取Y轴显示数据的间隔  防止数据过多显示太难看
  ///根据y轴的数据的最大值来确定
  int _getYDurtion(WormLineData lineData) {
    int showCount = 5; //要显示的数量

    int max = 0;
    lineData.yData.forEach((item) {
      if (item >= max) max = item;
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
  List<FlSpot> _getPoints(WormLineData lineData) {
    List<FlSpot> flspots = new List();

    for (int i = 0; i < lineData.xData.length; i++) {
      flspots.add(FlSpot(i.toDouble(), lineData.yData[i].toDouble()));
    }
    return flspots;
  }

  ///筛选侧滑栏
  Widget _buildDrawer(WormLineModel model) {
    return ListView(
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.only(left: 21, top: 0, right: 12, bottom: 48),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  '农作物',
                  style: TextStyle(
                      fontSize: 15, color: Color(LocalColors.text_666666)),
                ),
              ),
              InkWell(
                onTap: () {
                  _chooseCrops(model, context);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      left: 14, right: 11, top: 11, bottom: 11),
                  decoration: BoxDecoration(
                      color: Color(LocalColors.bg_f4f4f4),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: new Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            crop.isEmpty ? '所有' : crop,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(LocalColors.text_222222)),
                          )),
                      Image.asset('images/wd_jt.png'),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  '虫种',
                  style: TextStyle(
                      fontSize: 15, color: Color(LocalColors.text_666666)),
                ),
              ),
              InkWell(
                onTap: () {
                  _chooseInsectTypes(model);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      left: 14, right: 11, top: 11, bottom: 11),
                  decoration: BoxDecoration(
                      color: Color(LocalColors.bg_f4f4f4),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: new Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            insectTypes.isEmpty ? '所有' : insectTypes,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(LocalColors.text_222222)),
                          )),
                      Image.asset('images/wd_jt.png'),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  '虫型',
                  style: TextStyle(
                      fontSize: 15, color: Color(LocalColors.text_666666)),
                ),
              ),
              InkWell(
                onTap: () {
                  _chooseStages(model);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      left: 14, right: 11, top: 11, bottom: 11),
                  decoration: BoxDecoration(
                      color: Color(LocalColors.bg_f4f4f4),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: new Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            stages.isEmpty ? '所有' : stages,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(LocalColors.text_222222)),
                          )),
                      Image.asset('images/wd_jt.png'),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  '时间范围',
                  style: TextStyle(
                      fontSize: 15, color: Color(LocalColors.text_666666)),
                ),
              ),
              InkWell(
                onTap: () {
                  _chooseStartAt(context, model);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      left: 14, right: 11, top: 11, bottom: 11),
                  decoration: BoxDecoration(
                      color: Color(LocalColors.bg_f4f4f4),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: new Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            startAt.isEmpty ? '开始时间' : startAt,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(LocalColors.text_222222)),
                          )),
                      Image.asset('images/wd_jt.png'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  _chooseEndAt(context, model);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      left: 14, right: 11, top: 11, bottom: 11),
                  decoration: BoxDecoration(
                      color: Color(LocalColors.bg_f4f4f4),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: new Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            endAt.isEmpty ? '结束时间' : endAt,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(LocalColors.text_222222)),
                          )),
                      Image.asset('images/wd_jt.png'),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 40),
                child: Center(
                  child: FlatButton(
                      onPressed: () {
                        _refreshLineData(model);
                        Navigator.of(context).pop();
                      },
                      color: Color(LocalColors.bg_85C226),
                      padding: const EdgeInsets.only(
                          left: 72, right: 72, top: 12, bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Text(
                        '确定',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  //选择农作物
  void _chooseCrops(WormLineModel model, BuildContext context) {
    List<String> cropStrings = new List();
    model.chooseData.crops.forEach((item) {
      cropStrings.add(item.value);
    });

    LPicker.showPicker(context, cropStrings, onSelect: (index, datas) {
      if (mounted) {
        setState(() {
          crop = model.chooseData.crops[index].value;
          cropCode = model.chooseData.crops[index].code;
        });
      }
    });
  }

  //选择虫种
  void _chooseInsectTypes(WormLineModel model) {
    List<String> insectTypesStrings = new List();
    model.chooseData.insectTypes.forEach((item) {
      insectTypesStrings.add(item.value);
    });

    LPicker.showPicker(context, insectTypesStrings, onSelect: (index, datas) {
      if (mounted) {
        setState(() {
          insectTypesCode = model.chooseData.insectTypes[index].code;
          insectTypes = model.chooseData.insectTypes[index].value;
        });
      }
    });
  }

  //选择虫型
  void _chooseStages(WormLineModel model) {
    List<String> stagesStrings = new List();
    model.chooseData.stages.forEach((item) {
      stagesStrings.add(item.value);
    });

    LPicker.showPicker(context, stagesStrings, onSelect: (index, datas) {
      if (mounted) {
        setState(() {
          stagesCode = model.chooseData.stages[index].code;
          stages = model.chooseData.stages[index].value;
        });
      }
    });
  }

  //选择开始时间
  void _chooseStartAt(BuildContext ctx, WormLineModel model) {
    DatePicker.showDatePicker(ctx,
        showTitleActions: true, locale: LocaleType.zh, onConfirm: (date) {
      if (mounted) {
        setState(() {
          startAt = DateUtil.formatDate(date, format: 'yyyy-MM-dd');
          _refreshLineData(model);
        });
      }
    });
  }

  //选择结束时间
  void _chooseEndAt(BuildContext ctx, WormLineModel model) {
    DatePicker.showDatePicker(ctx,
        showTitleActions: true, locale: LocaleType.zh, onConfirm: (date) {
      if (mounted) {
        setState(() {
          endAt = DateUtil.formatDate(date, format: 'yyyy-MM-dd');
          _refreshLineData(model);
        });
      }
    });
  }

  //查询曲线数据
  void _refreshLineData(WormLineModel model) {
    model.getLineData(cropCode, '${defaultData.imei}', startAt, endAt,
        '', insectTypesCode, stagesCode);
  }
}
