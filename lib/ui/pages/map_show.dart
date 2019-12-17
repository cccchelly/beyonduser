
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:beyond_user/config/app_constans.dart';
import 'package:beyond_user/utlis/permission_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:amap_core_fluttify/amap_core_fluttify.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:oktoast/oktoast.dart';

class MapShow extends StatefulWidget {
  @override
  MapShowState createState() => new MapShowState();
}

class MapShowState extends State<MapShow> {
  LatLng latLng;

  @override
  Widget build(BuildContext context) {
    latLng = ModalRoute.of(context).settings.arguments;

    return new Scaffold(
      body: new Column(
        children: [
          CustomAppbarWhite('位置'),
          Expanded(
            flex: 1,
            child: AmapView(
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
              centerCoordinate: LatLng(latLng.latitude, latLng.longitude),
              // 标记
              markers: [MarkerOption(
                latLng: LatLng(latLng.latitude, latLng.longitude),
                infoWindowEnabled: false,
                iconUri: Uri.parse('images/3.0x/location_on.png'),
                imageConfig: ImageConfiguration(size: Size(30, 48)
                ),
              )],
              //地图点击
              onMapClicked: (latlng) {
                //showToast('${latlng.latitude},${latlng.longitude}');
                return;
              },
              // 标识点击回调
              onMarkerClicked: (marker) {
                //marker.showInfoWindow();
                return;
              },
              // 地图创建完成回调
              onMapCreated: (controller) async {
                if(await requestPermission()){
                 //controller.showMyLocation(true);
                }
              },
            ),
          ),

        ],
      ),
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