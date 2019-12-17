import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:beyond_user/config/app_constans.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/config/router_config.dart';
import 'package:beyond_user/model/lamp_list_model.dart';
import 'package:beyond_user/ui/widget/my_drawer.dart';
import 'package:beyond_user/utlis/gps_util.dart';
import 'package:beyond_user/utlis/lamp_statue_util.dart';
import 'package:beyond_user/utlis/log_util.dart';
import 'package:beyond_user/utlis/permission_util.dart';
import 'package:beyond_user/view_modle/lamp_map_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

class LampMapNet extends StatefulWidget {
  @override
  LampMapNetState createState() => new LampMapNetState();
}

class LampMapNetState extends State<LampMapNet>
    with SingleTickerProviderStateMixin {
  LampMapViewModel _lampMapViewModel;
  List<Tab> _tabs;
  TabController _tabController;
  int machineStatus;
  int type = 3; //3初始位置  1实时位置
  Marker clickMarker;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      endDrawer: _buildDrawer(),
      body: new Column(
        children: [
          CustomAppbarTheme('物联网杀虫灯'),
          Container(
            width: double.infinity,
            color: Theme.of(context).accentColor,
            child: new Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TabBar(
                    tabs: _tabs,
                    controller: _tabController,
                    indicatorColor: Color(LocalColors.text_016E2D),
                    indicatorWeight: 1,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Color(LocalColors.text_016E2D),
                    unselectedLabelColor: Colors.white,
                    labelStyle: TextStyle(fontSize: 13),
                    labelPadding: const EdgeInsets.only(left: 0),
                    unselectedLabelStyle: TextStyle(fontSize: 13),
                  ),
                ),
                Builder(
                  builder: (ctx) {
                    return InkWell(
                      onTap: () {
                        ScaffoldState scaffoldState = Scaffold.of(ctx);
                        if (scaffoldState.isEndDrawerOpen) {
                          Navigator.of(context).pop();
                        } else {
                          scaffoldState.openEndDrawer();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: 11),
                        child: new Row(
                          children: [
                            Image.asset('images/suoyou_sxbai.png'),
                            Text(
                              '筛选',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: ProviderWidget<LampMapViewModel>(
              model: LampMapViewModel(type.toString()),
              onModelReady: (model){
                _lampMapViewModel = model;
                model.getLampList(type: type.toString(),machineStatus: machineStatus);
              },
              builder: (context,model,child){
                if(model.busy){
                  return ViewStateBusyWidget();
                }
                return AmapView(
                  // 地图类型
                  mapType: MapType.Standard,
                  // 是否显示缩放控件
                  showZoomControl: true,
                  // 是否显示指南针控件
                  showCompass: true,
                  // 是否显示比例尺控件
                  showScaleControl: true,
                  // 是否使能缩放手势
                  zoomGesturesEnabled: true,
                  // 是否使能滚动手势
                  scrollGesturesEnabled: true,
                  // 是否使能旋转手势
                  rotateGestureEnabled: true,
                  // 是否使能倾斜手势
                  tiltGestureEnabled: true,
                  // 缩放级别
                  zoomLevel: 10,
                  // 中心点坐标
                  centerCoordinate: model.lampList.length == 0
                      ? LatLng(39, 116)
                      : _getExchangedLatlng(model.lampList[0].lng, model.lampList[0].lat),
                  // 标记
                  markers: _getMarkers(model),
                  //地图点击
                  onMapClicked: (latlng) {
                    //showToast('${latlng.latitude},${latlng.longitude}');
                    try {
                      clickMarker.hideInfoWindow();
                    }catch(e){}
                    return;
                  },
                  // 标识点击回调
                  onMarkerClicked: (marker) {
                    clickMarker = marker;
                    marker.showInfoWindow();
                    return;
                  },
                  // 地图创建完成回调
                  onMapCreated: (controller) async {
                    // requestPermission是权限请求方法
                    if (await requestPermission()) {
                      if(model.lampList.length == 0){
                        //定位
                        await controller.showMyLocation(true);
                      }

                    }
                    //有数据  定位完成后把中心点设置到第一组数据的位置
                    if (model.lampList.length != 0) {
                      LatLng latlng = _getExchangedLatlng(model.lampList[0].lng, model.lampList[0].lat);
                      /*controller.setCenterCoordinate(
                          latlng.latitude, latlng.longitude);*/
                    }
                    controller.setInfoWindowClickListener((marker) {
                      _showMarkDialog(marker);
                      return;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _getExchangedLatlng(num lat,num lng){
    LatLng latLng;
    if(type == 3){ //初始位置
      latLng = LatLng(lat, lng);
    }else{//实时位置
      var latlngList = GpsUtil.bd09_To_Gcj02(lat, lng);
      latLng = LatLng(latlngList[0], latlngList[1]);
    }
    return latLng;
  }

  _getMarkers(LampMapViewModel model) {
    List<MarkerOption> markers = new List();

    model.lampList.forEach((item) {

      LatLng latLng = _getExchangedLatlng(item.lng, item.lat);

      markers.add(MarkerOption(
        latLng: LatLng(latLng.latitude, latLng.longitude),
        infoWindowEnabled: true,
        title: '设备号:${item.sn}\r\n设备SN:${item.did}',
        snippet: '当前状态:${_getStatuesStr(item)}\r\n通信时间:${item.updateTime}\r\n标签:${item.label}\r\n地址:${item.location}',
        iconUri: Uri.parse(_getStatueImg(item)),
        imageConfig: ImageConfiguration(size: Size(30, 48)),
      ));
    });

    return markers;
  }

  _getStatuesStr(LampListModel item){
    LampStatueUtil lampStatueUtil = LampStatueUtil(item.status,lastTimeStr: item.time);
    return lampStatueUtil.getLampStatuesStr();
  }

  _getStatueImg(LampListModel item){
    LampStatueUtil lampStatueUtil = LampStatueUtil(item.status,lastTimeStr: item.time);
    switch(lampStatueUtil.getLampStatuesEnum()){
      case LampStatueUtil.normal:
      case LampStatueUtil.wait:
        return 'images/3.0x/location_on.png';
        break;
      case LampStatueUtil.netError:
        return 'images/3.0x/location_off.png';
        break;
      case LampStatueUtil.bad:
      case LampStatueUtil.unknown:
      default:
        return 'images/3.0x/location_erro.png';
        break;
    }
  }

  _showMarkDialog(Marker marker) {
    showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            contentPadding: const EdgeInsets.all(0),
            children: <Widget>[
              new Column(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        marker.title.then((title) {
                          var number = title.split('\r\n')[0].split(':')[1];

                          Navigator.of(context).pushNamed(
                              RouteName.lamp_install_detail,
                              arguments: number);
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(child: Text('安装信息')),
                      )),
                  Divider(
                    height: 1,
                    color: Color(LocalColors.bg_line),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        marker.title.then((title) {
                          var did = title.split('\r\n')[1].split(':')[1];
                          Navigator.of(context).pushNamed(
                              RouteName.lamp_detail_net,
                              arguments: did);
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(child: Text('查看详情')),
                      )),
                  Divider(
                    height: 1,
                    color: Color(LocalColors.bg_line),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        _gaodeGuide(marker);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(child: Text('高德导航')),
                      )),
                  Divider(
                    height: 1,
                    color: Color(LocalColors.bg_line),
                  ),
                  InkWell(
                      onTap: () {
                        showToast('百度导航');
                        Navigator.of(context).pop();
                        _baiduGuide(marker);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(child: Text('百度导航')),
                      )),
                  Divider(
                    height: 1,
                    color: Color(LocalColors.bg_line),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(child: Text('取消')),
                      )),
                ],
              ),
            ],
          );
        });
  }

  _baiduGuide(Marker marker) async {
    LatLng latLng = await marker.location;
    num lat = GpsUtil.gcj02_To_Bd09(latLng.latitude, latLng.longitude)[0];
    num lng = GpsUtil.gcj02_To_Bd09(latLng.latitude, latLng.longitude)[1];
    var url =
        'baidumap://map/direction?destination=latlng:$lat,$lng|name:我的目的地&mode=driving&region=&src=绿色云农#Intent;scheme=bdapp;package=com.baidu.BaiduMap;end';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast('找不到百度地图app');
    }
  }

  _gaodeGuide(Marker marker)async {
    LatLng latLng = await marker.location;
    num lat = latLng.latitude;
    num lng = latLng.longitude;

    var url = 'androidamap://navi?sourceApplication=绿色云农&poiname=我的目的地&lat=$lat&lon=$lng&dev=0';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast('找不到高德地图app');
    }
  }

  Future<bool> requestPermission() async {
    bool hasPermission = await PermissionUtil.requestLocation();

    if (hasPermission) {
      return true;
    } else {
      showToast('需要定位权限!');
      return false;
    }
  }

  _buildDrawer() {
    return MyDrawer(
      widthPercent: 0.5,
      child: Container(
        margin: const EdgeInsets.only(top: 64),
        child: new Column(
          children: [
            FlatButton(
                onPressed: () {
                  type = 3;
                  setState(() {
                    _lampMapViewModel.getLampList(type: '$type',machineStatus: machineStatus);
                    Navigator.of(context).pop();
                  });
                },
                padding: const EdgeInsets.symmetric(horizontal: 40),
                color: type == 3 ? Theme.of(context).accentColor : Color(LocalColors.bg_dddddd),
                child: Text(
                  '初始位置',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                )),
            FlatButton(
                onPressed: () {
                  type = 1;
                  setState(() {
                    _lampMapViewModel.getLampList(type: '$type',machineStatus: machineStatus);
                    Navigator.of(context).pop();
                  });
                },
                padding: const EdgeInsets.symmetric(horizontal: 40),
                color: type == 1 ? Theme.of(context).accentColor :  Color(LocalColors.bg_dddddd),
                child: Text(
                  '实时位置',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                )),
          ],
        ),
      ),
    );
  }

  _initTabs() {
    _tabs = new List();
    _tabs.add(Tab(
      text: '全部',
    ));
    _tabs.add(Tab(
      text: '正常',
    ));
    _tabs.add(Tab(
      text: '待机',
    ));
    _tabs.add(Tab(
      text: '网络异常',
    ));
    _tabs.add(Tab(
      text: '故障',
    ));

    _tabController =
        new TabController(length: _tabs.length, vsync: this, initialIndex: 0);
    _tabController.addListener((){
      if(_tabController.indexIsChanging){
        switch(_tabController.index){
          case 0:
            machineStatus = null;
            break;
          case 1:
            machineStatus = 1;
            break;
          case 2:
            machineStatus = 3;
            break;
          case 3:
            machineStatus = 2;
            break;
          case 4:
            machineStatus = 4;
            break;
        }
        _lampMapViewModel.getLampList(type: '$type',machineStatus: machineStatus);

      }
    });
  }

  @override
  void initState() {
    super.initState();
    AmapCore.init(AppConstans.IOS_GAODE_KEY);
    _initTabs();
  }
}
