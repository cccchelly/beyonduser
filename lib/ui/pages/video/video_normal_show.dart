import 'package:flutter/material.dart';
import 'package:beyond_user/model/video_device_normal_data.dart';
import 'package:beyond_user/model/video_normal_route_bean.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:beyond_user/view_modle/video_normal_show_model.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/ui/widget/choose_widget.dart';
import 'package:beyond_user/utlis/log_util.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:beyond_user/config/router_config.dart';

//普通监控看视频
class VideoNormalShow extends StatefulWidget {
  @override
  VideoNormalShowState createState() => new VideoNormalShowState();
}

class VideoNormalShowState extends State<VideoNormalShow> {
  //String url = 'http://hls01open.ys7.com/openlive/b1f88eae7ab946f8a490af7621b7ab58.m3u8';
  //String url = 'http://hls01open.ys7.com/openlive/b1f88eae7ab946f8a490af7621b7ab58.hd.m3u8';
  //String url = 'rtmp://rtmp01open.ys7.com/openlive/b1f88eae7ab946f8a490af7621b7ab58';
  //String url = 'rtmp://rtmp01open.ys7.com/openlive/b1f88eae7ab946f8a490af7621b7ab58.hd';

  VideoRouteData deviceNormalData;
  List<String> resouceData = new List();
  List<String> addressData = new List();
  int addressIndex = 0;
  FijkPlayer player = new FijkPlayer();

  @override
  Widget build(BuildContext context) {
    deviceNormalData = ModalRoute.of(context).settings.arguments;
    addressIndex = deviceNormalData.addressIndex;

    return new Scaffold(
      body: new Column(
        children: [
          CustomAppbarWhite('苗情监控'),
          ProviderWidget<VideoNormalShowModel>(
            model: VideoNormalShowModel(
                '${deviceNormalData.deviceSerial}:${deviceNormalData.channelNo}'),
            onModelReady: (model) {
              model.getVideo();
            },
            builder: (context, model, child) {
              if (model.busy) {
                return ViewStateBusyWidget();
              }

              _getAddress(model);

              if (model.videoData == null ||
                  model.videoData.length == 0 ||
                  _isSourceEmpty()) {
                return Center(
                  child: Text('无视频流数据'),
                );
              }

              _setSource();

              return new Column(
                children: [
                  Divider(
                    height: 1,
                    color: Color(LocalColors.bg_eeeeee),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showSourceChoose(context);
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 20, bottom: 20),
                      child: new Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              '线路选择',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(LocalColors.text_666666)),
                            ),
                          ),
                          Text(
                            _isSourceEmpty()
                                ? '暂无视频流'
                                : resouceData[addressIndex],
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(LocalColors.text_222222)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset('images/wd_jt.png'),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Color(LocalColors.bg_eeeeee),
                  ),

                  Container(
                    width: double.infinity,
                    height: 254,
                    child: FijkView(
                      player: player,
                      fit: FijkFit.fill,
                    ),
                  )

                ],
              );
            },
          ),
        ],
      ),
    );
  }


  _setSource(){
    player.setDataSource(addressData[addressIndex],autoPlay: true);
    MyLogUtil.log('地址：${addressData[addressIndex]}');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    player.release();
    super.dispose();
  }

  _showSourceChoose(BuildContext context) {
    if (_isSourceEmpty()) return;
    LPicker.showPicker(context, resouceData, onSelect: (index, data) {
      if (mounted) {
        setState(() {
          addressIndex = index;
          deviceNormalData.addressIndex = index;
          Navigator.of(context).pushReplacementNamed(RouteName.video_normal_show,arguments: deviceNormalData);
        });
      }
    });
  }

  //有可能有的线路没有资源  根据是否有资源动态生成map
  _getAddress(VideoNormalShowModel model) {
    if (model.videoData == null || model.videoData.length == 0) return;

    resouceData.clear();
    addressData.clear();
    if (model.videoData[0].rtmp != null) {
      if(model.videoData[0].rtmp.isNotEmpty){
        resouceData.add('线路一：标清');
        addressData.add(model.videoData[0].rtmp);
      }
    }

    if (model.videoData[0].rtmpHd!= null) {
      if(model.videoData[0].rtmpHd.isNotEmpty){
        resouceData.add('线路一：高清');
        addressData.add(model.videoData[0].rtmpHd);
      }
    }

    if (model.videoData[0].hls!= null) {
      if(model.videoData[0].hls.isNotEmpty){
        resouceData.add('线路二：标清');
        addressData.add(model.videoData[0].hls);
      }
    }
    if (model.videoData[0].hlsHd!= null) {
      if(model.videoData[0].hlsHd.isNotEmpty){
        resouceData.add('线路二：高清');
        addressData.add(model.videoData[0].hlsHd);
      }
    }
  }

  //资源是否为空
  bool _isSourceEmpty() {
    return resouceData.isEmpty;
  }


}
