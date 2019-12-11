import 'package:flutter/material.dart';
import 'package:beyond_user/config/router_config.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:beyond_user/ui/widget/refresh_footer.dart';
import 'package:beyond_user/ui/widget/refresh_header.dart';
import 'package:beyond_user/view_modle/video_device_model.dart';
import 'package:beyond_user/model/video_device_ball_data.dart';
import 'package:beyond_user/model/video_device_normal_data.dart';
import 'package:beyond_user/model/video_normal_route_bean.dart';

/*视频监控列表*/
class VideoList extends StatefulWidget {
  @override
  VideoListState createState() => new VideoListState();
}

class VideoListState extends State<VideoList> {
  int mode = 0; //切换页面 0普通模式  1球机模式

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: [
          CustomAppbarTheme('苗情监控'),
          new Row(
            children: [
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        if (mode == 0) return;
                        if (mounted) {
                          setState(() {
                            mode = 0;
                          });
                        }
                      },
                      child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          child: Center(
                              child: Text(
                            '普通模式',
                            style: TextStyle(
                                fontSize: 13,
                                color: mode == 0
                                    ? Theme.of(context).accentColor
                                    : Color(LocalColors.text_444444)),
                          ))))),
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        if (mode == 1) return;
                        if (mounted) {
                          setState(() {
                            mode = 1;
                          });
                        }
                      },
                      child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          child: Center(
                              child: Text(
                            '球机模式',
                            style: TextStyle(
                                fontSize: 13,
                                color: mode == 1
                                    ? Theme.of(context).accentColor
                                    : Color(LocalColors.text_444444)),
                          ))))),
            ],
          ),
          Expanded(flex: 1, child: _buildList(context)),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return mode == 0
        ? ProviderWidget<VDNormalModel>(
            model: VDNormalModel(),
            onModelReady: (model) {
              model.initData();
            },
            builder: (context, model, child) {
              if (model.busy) {
                return ViewStateBusyWidget();
              }

              return SmartRefresher(
                controller: model.refreshController,
                enablePullDown: true,
                enablePullUp: true,
                header: MyRefreshHeader(),
                footer: MyRefreshFooter(),
                onRefresh: model.refresh,
                onLoading: model.loadMore,
                child: ListView.builder(
                    itemCount: model.list.length,
                    itemBuilder: (context, index) {
                      return _buildItemNormal(model.list[index]);
                    }),
              );
            },
          )
        : ProviderWidget<VDBallModel>(
            model: VDBallModel(),
            onModelReady: (model) {
              model.initData();
            },
            builder: (context, model, child) {
              if (model.busy) {
                return ViewStateBusyWidget();
              }

              return SmartRefresher(
                controller: model.refreshController,
                enablePullDown: true,
                enablePullUp: true,
                header: MyRefreshHeader(),
                footer: MyRefreshFooter(),
                onRefresh: model.refresh,
                onLoading: model.loadMore,
                child: ListView.builder(
                    itemCount: model.list.length,
                    itemBuilder: (context, index) {
                      return _buildItemBall(model.list[index]);
                    }),
              );
            },
          );
  }

  Widget _buildItemNormal(VideoDeviceNormalData item) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: new Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: new Row(
              children: [
                Container(
                    width: 80,
                    child: Text(
                      '设备序列号:',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(LocalColors.text_555555), fontSize: 13),
                    )),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Text(
                      '${item.deviceSerial}',
                      style: TextStyle(
                          color: Color(LocalColors.text_222222), fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 13),
            child: new Row(
              children: [
                Container(
                    width: 80,
                    child: Text(
                      '通道号:',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(LocalColors.text_555555), fontSize: 13),
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(
                    '${item.channelNo}',
                    style: TextStyle(
                        color: Color(LocalColors.text_222222), fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 13),
            child: new Row(
              children: [
                Container(
                    width: 80,
                    child: Text(
                      '设备名称:',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(LocalColors.text_555555), fontSize: 13),
                    )),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Text(
                      '${item.channelName}',
                      style: TextStyle(
                          color: Color(LocalColors.text_222222), fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 13),
            child: new Row(
              children: [
                Container(
                    width: 80,
                    child: Text(
                      '在线状态:',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(LocalColors.text_555555), fontSize: 13),
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(
                    item.status == 1 ? '在线' : '离线',
                    style: TextStyle(
                        color: item.status == 1
                            ? Theme.of(context).accentColor
                            : Color(LocalColors.text_222222),
                        fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 13),
            child: new Row(
              children: [
                Container(
                    width: 80,
                    child: Text(
                      '是否加密:',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(LocalColors.text_555555), fontSize: 13),
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(
                    item.isEncrypt == 1 ? '加密' : '未加密',
                    style: TextStyle(
                        color: Color(LocalColors.text_222222), fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 13, bottom: 27),
            child: new Row(
              children: [
                Container(
                    width: 80,
                    child: Text(
                      '视频质量:',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(LocalColors.text_555555), fontSize: 13),
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Text(
                      item.videoLevel == 0
                          ? '流畅'
                          : item.videoLevel == 1
                              ? '均衡'
                              : item.videoLevel == 2
                                  ? '高清'
                                  : item.videoLevel == 3 ? '超清' : '',
                      style: TextStyle(
                          color: Color(LocalColors.text_222222), fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(RouteName.video_normal_show, arguments: VideoRouteData(item.deviceSerial, item.channelNo, 0));
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 13, bottom: 13),
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              child: Center(
                  child: Text(
                '实时监控查看',
                style: TextStyle(fontSize: 15, color: Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItemBall(VideoDeviceBallData item) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
      padding: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: new Column(
        children: [
          new Row(
            children: [
              Container(
                  width: 80,
                  child: Text(
                    '设备序列号:',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Color(LocalColors.text_555555), fontSize: 13),
                  )),
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(
                    '${item.imei}',
                    style: TextStyle(
                        color: Color(LocalColors.text_222222), fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 13, bottom: 27),
            child: new Row(
              children: [
                Container(
                    width: 80,
                    child: Text(
                      '设备名称:',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(LocalColors.text_555555), fontSize: 13),
                    )),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Text(
                      '${item.alias}',
                      style: TextStyle(
                          color: Color(LocalColors.text_222222), fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Row(
            children: [
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      _toSeeVideo(item);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5))),
                      child: Text(
                        '实时监控查看',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      _toSeePicture(item);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                          color: Color(LocalColors.bg_006F2D),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(5))),
                      child: Text(
                        '监控图片查看',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  _toSeeVideo(VideoDeviceBallData item) {
    //目前球机视频怎么接未定  暂时跳普通相机随便给个地址  反正无数据
    Navigator.of(context)
        .pushNamed(RouteName.video_normal_show, arguments: VideoRouteData('C57795544', 30 , 0));
    //Navigator.of(context).pushNamed(RouteName.video_ball_show, arguments: item);
  }

  _toSeePicture(VideoDeviceBallData item) {
    Navigator.of(context).pushNamed(RouteName.video_ball_pic, arguments: item);
  }
}
