import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/model/wea_sta_list_data.dart';
import 'package:beyond_user/ui/widget/refresh_footer.dart';
import 'package:beyond_user/ui/widget/refresh_header.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:oktoast/oktoast.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/model/wea_sta_data_data.dart';
import 'package:beyond_user/view_modle/wea_sta_data_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:beyond_user/ui/widget/my_drawer.dart';
import 'package:beyond_user/ui/widget/lxd_flow_layout.dart';
import 'package:beyond_user/utlis/log_util.dart';
import 'package:common_utils/common_utils.dart';

///气象站数据列表
class WeaStaDataList extends StatefulWidget {
  @override
  WeaStaDataListState createState() => new WeaStaDataListState();
}

class WeaStaDataListState extends State<WeaStaDataList> {
  List<String> checkedString ; //选择的参数key
  List<int> checkedIndex ; //选择的参数下标
  List<int> checkedTemp = new List(); //临时存储的选择下标  选择后赋值  点确定后再赋值个实际的下标集合
  String startAt = '';
  String endAt = '';

  WeaStaDataModel model;
  WeaStaListData deviceData;

  @override
  Widget build(BuildContext context) {
    _initDefaultData(context);

    return Scaffold(
      endDrawer: _buildDrawer(),
      body: Column(
        children: [
          CustomAppbarWhite(
            '历史数据',
            actionWidget: Builder(builder: (ctx) {
              return ChooseBotton(() {
                ScaffoldState scaStatus = Scaffold.of(ctx);
                if (scaStatus.isEndDrawerOpen) {
                  Navigator.of(context).pop();
                } else {
                  scaStatus.openEndDrawer();
                }
              });
            }),
          ),
          Expanded(
            flex: 1,
            child: ProviderWidget<WeaStaDataModel>(
              model: WeaStaDataModel('${deviceData.imei}',startAt,endAt),
              onModelReady: (model) {
                model.initData();
                this.model = model;
              },
              builder: (ctx, model, child) {
                if (model.busy) {
                  return ViewStateBusyWidget();
                }

                return new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(padding: const EdgeInsets.all(12),child: Text('${startAt.replaceAll('-', '.')} - ${endAt.replaceAll('-', '.')} ',style: TextStyle(fontSize: 16,color: Color(LocalColors.text_666666)),)),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(top: 16, bottom: 11),
                      child: new Row(children: _buildShowTitle()),
                    ),
                    Divider(height: 1,color: Color(LocalColors.bg_dddddd),),
                    Expanded(
                      flex: 1,
                      child: SmartRefresher(
                        controller: model.refreshController,
                        onRefresh: model.refresh,
                        onLoading: model.loadMore,
                        enablePullDown: true,
                        enablePullUp: true,
                        header: MyRefreshHeader(),
                        footer: MyRefreshFooter(),
                        child: ListView.builder(
                            itemCount: model.list.length,
                            itemBuilder: (ctx, index) {
                              return _buildItem(model.list[index]);
                            }),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  //根据选择的数据动态显示数据头
  List<Widget> _buildShowTitle() {
    List<Widget> temp = new List();

    temp.add(
      Expanded(
          child: Center(
        child: Text(
          '时间',
          style: TextStyle(fontSize: 13, color: Color(LocalColors.text_555555)),
        ),
      )),
    );

    checkedString.forEach((s) {
      temp.add(
        Expanded(
            child: Center(
          child: Text(
            s,
            style:
                TextStyle(fontSize: 13, color: Color(LocalColors.text_555555)),
          ),
        )),
      );
    });

    return temp;
  }

  ///侧滑选择窗
  Widget _buildDrawer() {
    return MyDrawer(
      widthPercent: 0.8,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 60, bottom: 20,left: 12,right: 12),
            child: Text(
              '时间范围',
              style: TextStyle(
                  fontSize: 15, color: Color(LocalColors.text_666666)),
            ),
          ),
          InkWell(
            onTap: () {
              _chooseStartAt(context);
            },
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 12,right: 12),
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
              _chooseEndAt(context);
            },
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 12,right: 12),
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
              margin: const EdgeInsets.only(top: 30, left: 12),
              child: Text(
                '参数筛选(最多三个)',
                style: TextStyle(
                    fontSize: 14, color: Color(LocalColors.text_222222)),
              )),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 6, right: 6),
              child: LFlowLayout(
                size: _getChooseData().length,
                defaultCheck: checkedIndex,
                maxCheck: 3,
                onCheckChanged: (positions) {
                  //放入临时列表存储选择的参数 点击确定后再赋值
                  checkedTemp = positions;
                },
                builder: (ctx, index, isCheck) {
                  return isCheck
                      ? DefaultCheckWidget(_getChooseData()[index])
                      : DefaultUnCheckWidget(_getChooseData()[index]);
                },
              ),
            ),
          ),
          Divider(
            height: 1,
            color: Color(LocalColors.bg_dddddd),
          ),
          new Row(
            children: [
              Expanded(
                  child: InkWell(
                onTap: () {
                  setState(() {
                    checkedString.clear();
                    checkedIndex.clear();
                  });
                },
                child: Container(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Center(
                        child: Text(
                      '重置',
                      style: TextStyle(
                          fontSize: 16, color: Color(LocalColors.text_666666)),
                    ))),
              )),
              Expanded(
                  child: InkWell(
                onTap: () {
                  setState(() {
                    checkedIndex = checkedTemp;
                    checkedString.clear();
                    checkedIndex.forEach((index) {
                      checkedString.add(_getChooseData()[index]);
                    });
                    _refreshData();
                  });
                  Navigator.of(context).pop();
                },
                child: Container(
                    color: Theme.of(context).accentColor,
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Center(
                      child: Text(
                        '确定',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    )),
              ))
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItem(WeaStaDataData item) {
    List<Widget> dataWidget = new List();

    dataWidget.add(Expanded(
      flex: 1,
      child: Center(
        child: new Column(
          children: [
            Text('${item.year}.${item.mounths}.${item.days}',style: TextStyle(fontSize: 12,color: Color(LocalColors.text_222222)),),
            Text('${item.hours}:00',style: TextStyle(fontSize: 12,color: Color(LocalColors.text_222222)),),
          ],
        ),
      ),
    ));

    checkedString.forEach((key) {
      dataWidget.add(Expanded(
          flex: 1, child: Center(child: Text('${_getListValue(key, item)}',style: TextStyle(fontSize: 13,color: Color(LocalColors.text_222222)),))));
    });

    return Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 15,bottom: 15),
            child: Row(
              children: dataWidget,
            ),
          ),
          Divider(height: 1,color: Color(LocalColors.bg_dddddd),)
        ],
    );
  }

  _getListValue(String content, WeaStaDataData data) {
    switch (content) {
      case '空气温度':
        return '${data.term}℃';
        break;
      case '空气湿度':
        return '${data.hum}%';
        break;
      case '大气压':
        return '${data.airPressure}pa';
        break;
      case '风向':
        return '${data.wdir}';
        break;
      case '风力':
        return '${data.windPower}';
        break;
      case '风速':
        return '${data.windSpeed}m/s';
        break;
      case 'PM2.5':
        return '${data.pm25}ug/m³';
        break;
      case '当前雨量':
        return '${data.currentRainfall}mm';
        break;
      case '环境噪音':
        return '${data.noise}db';
        break;
      case '空气湿度(室内)':
        return '${data.inHum}%';
        break;
      case '空气湿度(室外)':
        return '${data.hum}%';
        break;
      case '光照强度(室内)':
        return '${data.inHv}LX';
      case '光照强度(室外)':
        return '${data.hv}LX';
        break;
      case 'pm2.5(室内)':
        return '${data.inPm25}ug/m³';
        break;
      case 'pm2.5(室外)':
        return '${data.pm25}ug/m³';
        break;
      case '土壤湿度':
        return '${data.soilHum}%';
        break;
      case '土壤温度':
        return '${data.soilTerm}℃';
        break;
      case '土壤Ph':
        return '${data.soilPh}';
        break;
      default:
        return '';
        break;
    }
  }

  /*RK1(2, "山东仁科1代"),
  RK2(3, "山东仁科2代"),
  XPH(4, "新普惠")*/

  static const String rk1 = 'RK1';
  static const String rk2 = 'RK2';
  static const String xph = 'XPH';

  List<String> _getChooseData() {
    String type = deviceData == null ? '' : deviceData.vendor;
    switch (type) {
      case rk1:
        return [
          '空气温度',
          '空气湿度',
          '大气压',
          '风向',
          '风力',
          '风速',
          'PM2.5',
          '当前雨量',
          '环境噪音',
        ];
        break;
      case rk2:
        return [
          '空气温度',
          '空气湿度(室内)',
          '空气湿度(室外)',
          '光照强度(室内)',
          '光照强度(室外)'
              'pm2.5(室内)',
          'pm2.5(室外)',
          '大气压',
          '风向',
          '风力',
          '风速',
          '土壤湿度',
          '土壤温度',
          '土壤Ph',
        ];
        break;
      case xph:
        return [
          '空气温度',
          '空气湿度',
          '大气压',
          '风向',
          '风力',
          '风速',
          '土壤Ph',
        ];
        break;
      default:
        return [];
        break;
    }
  }

  _initDefaultData(BuildContext context) {
    deviceData = ModalRoute.of(context).settings.arguments;

    if(startAt.isEmpty && endAt.isEmpty){
      endAt = DateUtil.formatDate(DateTime.now(), format : 'yyyy-MM-dd');
      startAt = DateUtil.formatDate(DateTime.now().subtract(Duration(days: 7)),format : 'yyyy-MM-dd');
    }

    //如果数据不为空证明不是第一次初始化界面  数据为用户选择的  直接展示选择的选项
    if (checkedString != null && checkedIndex != null) {
      return;
    }else{
      checkedString = new List();
      checkedIndex = new List();
    }

    //如果数据为空  表示是刚进入页面初始化  初始化默认数据
    switch (deviceData.vendor) {
      case rk1:
        checkedString = ['空气温度', '空气湿度', '大气压'];
        checkedIndex = [0, 1, 2];
        break;
      case rk2:
        checkedString = ['空气温度', '大气压', '土壤温度'];
        checkedIndex = [0, 7, 12];
        break;
      case xph:
        checkedString = ['空气温度', '空气湿度', '大气压'];
        checkedIndex = [0, 1, 2];
        break;
    }
    checkedTemp.clear();
    checkedTemp.addAll(checkedIndex);
  }

  //选择开始时间
  void _chooseStartAt(BuildContext ctx) {
    DatePicker.showDatePicker(ctx,
        showTitleActions: true, locale: LocaleType.zh, onConfirm: (date) {
          if (mounted) {
            setState(() {
              startAt = DateUtil.formatDate(date, format: 'yyyy-MM-dd');
            });
          }
        });
  }

  //选择结束时间
  void _chooseEndAt(BuildContext ctx) {
    DatePicker.showDatePicker(ctx,
        showTitleActions: true, locale: LocaleType.zh, onConfirm: (date) {
          if (mounted) {
            setState(() {
              endAt = DateUtil.formatDate(date, format: 'yyyy-MM-dd');
            });
          }
        });
  }


  _refreshData(){
    if(model!=null) {
      model.beginAt = startAt;
      model.endAt = endAt;
      model.refresh();
    }
  }


}
