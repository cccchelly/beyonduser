import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:beyond_user/config/app_constans.dart';
import 'package:beyond_user/utlis/permission_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:oktoast/oktoast.dart';

class LampMapLocal extends StatefulWidget {
  @override
  LampMapLocalState createState() => new LampMapLocalState();
}

class LampMapLocalState extends State<LampMapLocal> {
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
      centerCoordinate: LatLng(39, 116),
      // 标记
      markers: <MarkerOption>[
        MarkerOption(
            latLng: LatLng(30.219784, 103.56199),
            infoWindowEnabled: true,
            title: '坐标',
            snippet: '23333',
            iconUri: Uri.parse('images/dl_zh.png'),
          imageConfig: ImageConfiguration(size: Size(20, 20))
        )
      ],
      //地图点击
      onMapClicked: (latlng) {
        showToast('${latlng.latitude},${latlng.longitude}');
        return;
      },
      // 标识点击回调
      onMarkerClicked: (marker) {
        marker.showInfoWindow();
        return;
      },
      // 地图创建完成回调
      onMapCreated: (controller) async {
        // requestPermission是权限请求方法
        if (await requestPermission()) {
          await controller.showMyLocation(true);
        }
      },
    );
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
