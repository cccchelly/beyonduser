import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:beyond_user/config/app_constans.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/config/router_config.dart';
import 'package:beyond_user/utlis/gps_util.dart';
import 'package:beyond_user/utlis/permission_util.dart';
import 'package:beyond_user/view_modle/lamp_map_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:oktoast/oktoast.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class LampMapLocal extends StatefulWidget {
  @override
  LampMapLocalState createState() => new LampMapLocalState();
}

class LampMapLocalState extends State<LampMapLocal> {
  Marker clickMarker;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: [
          CustomAppbarTheme('普通杀虫灯'),
          Expanded(flex: 1, child: _buildMapWidget()),
        ],
      ),
    );
  }

  _buildMapWidget() {
    return ProviderWidget<LampMapViewModel>(
      model: LampMapViewModel('2'),
      onModelReady: (model) {
        model.getLampList();
      },
      builder: (ctx, model, child) {
        if (model.busy) {
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
              : LatLng(model.lampList[0].lat, model.lampList[0].lng),
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
             /* controller.setCenterCoordinate(
                  model.lampList[0].lat, model.lampList[0].lng);*/
            }
            controller.setInfoWindowClickListener((marker) {
              _showMarkDialog(marker);
              return;
            });
          },
        );
      },
    );
  }

  _getMarkers(LampMapViewModel model) {
    List<MarkerOption> markers = new List();

    model.lampList.forEach((item) {
      markers.add(MarkerOption(
        latLng: LatLng(item.lat, item.lng),
        infoWindowEnabled: true,
        title: '设备号:${item.sn}',
        snippet: '标签:${item.label}\r\n地址:${item.location}',
        iconUri: Uri.parse('images/3.0x/location_on.png'),
        imageConfig: ImageConfiguration(size: Size(30, 48)),
      ));
    });

    return markers;
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
                          var sn = title.split(':')[1];
                          Navigator.of(context).pushNamed(
                              RouteName.lamp_install_detail,
                              arguments: sn);
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

  @override
  void initState() {
    AmapCore.init(AppConstans.IOS_GAODE_KEY);
    super.initState();
  }
}
