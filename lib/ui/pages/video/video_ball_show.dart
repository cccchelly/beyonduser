import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/config/router_config.dart';
import 'package:beyond_user/model/video_device_ball_data.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/model/video_ball_pic_data.dart';
import 'package:beyond_user/ui/widget/refresh_footer.dart';
import 'package:beyond_user/ui/widget/refresh_header.dart';
import 'package:beyond_user/view_modle/video_ball_pic_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideoBallShow extends StatefulWidget {
  @override
  VideoBallShowState createState() => new VideoBallShowState();
}

class VideoBallShowState extends State<VideoBallShow> {
  VideoDeviceBallData deviceBallData;

  @override
  Widget build(BuildContext context) {
    deviceBallData = ModalRoute.of(context).settings.arguments;

    return new Scaffold(
      body: new Column(
        children: [
          CustomAppbarWhite('苗情监控视频'),

        ],
      ),
    );
  }




}