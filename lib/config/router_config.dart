
import 'package:beyond_user/ui/pages/apply_fix/apply_fix.dart';
import 'package:beyond_user/ui/pages/apply_fix/fix_evaluate.dart';
import 'package:beyond_user/ui/pages/image_show.dart';
import 'package:beyond_user/ui/pages/lamp_fix/fix_detail.dart';
import 'package:beyond_user/ui/pages/lamp_fix/fix_list.dart';
import 'package:beyond_user/ui/pages/lamp_install/lamp_install_detail.dart';
import 'package:beyond_user/ui/pages/local_lamp/lamp_map_local.dart';
import 'package:beyond_user/ui/pages/net_lamp/lamp_detail_net.dart';
import 'package:beyond_user/ui/pages/qrcode_page.dart';
import 'package:beyond_user/ui/pages/spore/spore_detail.dart';
import 'package:beyond_user/utlis/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:beyond_user/ui/widget/page_route_anim.dart';
import 'package:beyond_user/ui/pages/main_four_page.dart';
import 'package:beyond_user/ui/pages/login.dart';
import 'package:beyond_user/ui/pages/worm/worm_list.dart';
import 'package:beyond_user/ui/pages/weather_station/wea_sta_list.dart';
import 'package:beyond_user/ui/pages/video/video_list.dart';
import 'package:beyond_user/ui/pages/spore/spore.dart';
import 'package:beyond_user/ui/pages/soil/soil.dart';
import 'package:beyond_user/ui/pages/soil/soil_detail.dart';
import 'package:beyond_user/ui/pages/worm/worm_pics.dart';
import 'package:beyond_user/ui/pages/worm/worm_pic_detail.dart';
import 'package:beyond_user/ui/pages/worm/worm_line.dart';
import 'package:beyond_user/ui/pages/weather_station/wea_sta_data_recently.dart';
import 'package:beyond_user/ui/pages/weather_station/wea_sta_data_list.dart';
import 'package:beyond_user/ui/pages/video/video_normal_show.dart';
import 'package:beyond_user/ui/pages/video/video_ball_show.dart';
import 'package:beyond_user/ui/pages/video/video_ball_pic.dart';
import 'package:beyond_user/ui/pages/main/main_page.dart';
import 'package:beyond_user/ui/pages/setting.dart';
import 'package:beyond_user/ui/pages/local_lamp/lamp_list_local.dart';
import 'package:beyond_user/ui/pages/net_lamp/lamp_list_net.dart';
import 'package:beyond_user/ui/pages/net_lamp/lamp_map_net.dart';




class RouteName {

  static const String worm_list = 'wormlist';
  static const String wea_sta_list = 'weastalist';
  static const String soil = 'soil';
  static const String video_list = 'videolist';

  static const String login = '/login';
  static const String login_from_android = 'login'; //android端进来的登录不加"/"

  static const String splash = 'splash';
  static const String mainfourpage = 'mainfourpage';
  static const String mainpage = 'mainpage';

  static const String worm_pic = '/wormpic';
  static const String worm_pic_detail = '/wormpicdetail';
  static const String worm_line = '/wormline';
  static const String wea_sta_data_list = '/weastadatalist';
  static const String wea_sta_data_recently = '/weastadatarecently';
  static const String video_normal_show = '/videonormalshow';
  static const String video_ball_show = '/videoballshow';
  static const String video_ball_pic = '/videoballpic';
  static const String spore_list = '/sporelist';
  static const String spore_detail = '/sporedetail';
  static const String soil_detail = '/soildetail';

  static const String lamp_list_local = '/lamplistlocal';
  static const String lamp_map_local = '/lampmaplocal';
  static const String lamp_list_net = '/lamplistnet';
  static const String lamp_detail_net = '/lampdetailnet';
  static const String lamp_map_net = '/lampmapnet';
  static const String lamp_install_detail = '/lampinstalldetail';

  static const String fix_list = '/fixlist';
  static const String fix_detail = '/fixdetail';
  static const String apply_fix = '/applyfix';

  static const String fix_evaluate = '/fixevaluate';

  static const String setting = '/setting';
  static const String qrcode_page = '/qrcode';
  static const String image_show = '/imageshow';

}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.mainpage:
        return NoAnimRouteBuilder(MainPage());
      case RouteName.mainfourpage:
        return NoAnimRouteBuilder(MainFourPage());
      case RouteName.login:
      case RouteName.login_from_android:
        return NoAnimRouteBuilder(Login());
      case RouteName.worm_list:
        return NoAnimRouteBuilder(WormList());
      case RouteName.worm_pic:
        return NoAnimRouteBuilderWithParms(WormPics(), settings);
      case RouteName.worm_pic_detail:
        return NoAnimRouteBuilderWithParms(WormPicDetail(), settings);
      case RouteName.worm_line:
        return NoAnimRouteBuilderWithParms(WormLine(),settings);
      case RouteName.wea_sta_list:
        return NoAnimRouteBuilder(WeaStaList());
      case RouteName.wea_sta_data_list:
        return NoAnimRouteBuilderWithParms(WeaStaDataList(), settings);
      case RouteName.wea_sta_data_recently:
        return NoAnimRouteBuilderWithParms(WeaStaDataRecently(), settings);
      case RouteName.video_list:
        return NoAnimRouteBuilder(VideoList());
      case RouteName.video_normal_show:
        return NoAnimRouteBuilderWithParms(VideoNormalShow(),settings);
      case RouteName.video_ball_show:
        return NoAnimRouteBuilderWithParms(VideoBallShow(), settings);
      case RouteName.video_ball_pic:
        return NoAnimRouteBuilderWithParms(VideoBallPic(), settings);
      case RouteName.spore_list:
        return NoAnimRouteBuilder(Spore());
      case RouteName.spore_detail:
        return NoAnimRouteBuilderWithParms(SporeDetail(), settings);
      case RouteName.soil:
        return NoAnimRouteBuilder(Soil());
      case RouteName.soil_detail:
        return NoAnimRouteBuilderWithParms(SoilDetail(), settings);
      case RouteName.setting:
        return NoAnimRouteBuilderWithParms(Setting(), settings);
      case RouteName.lamp_list_local:
        return NoAnimRouteBuilderWithParms(LampListLocal(), settings);
      case RouteName.lamp_map_local:
        return NoAnimRouteBuilderWithParms(LampMapLocal(), settings);
      case RouteName.lamp_list_net:
        return NoAnimRouteBuilderWithParms(LampListNet(), settings);
      case RouteName.lamp_detail_net:
        return NoAnimRouteBuilderWithParms(LampDetailNet(), settings);
      case RouteName.lamp_map_net:
        return NoAnimRouteBuilderWithParms(LampMapNet(), settings);
      case RouteName.fix_list:
        return NoAnimRouteBuilderWithParms(FixList(), settings);
      case RouteName.qrcode_page:
        return NoAnimRouteBuilderWithParms(QrcodePage(), settings);
      case RouteName.lamp_install_detail:
        return NoAnimRouteBuilderWithParms(LampInstallDetail(), settings);
      case RouteName.image_show:
        return NoAnimRouteBuilderWithParms(ImageShow(), settings);
      case RouteName.fix_detail:
        return NoAnimRouteBuilderWithParms(FixDetail(), settings);
      case RouteName.apply_fix:
        return NoAnimRouteBuilderWithParms(ApplyFix(), settings);
      case RouteName.fix_evaluate:
        return NoAnimRouteBuilderWithParms(FixEvaluate(), settings);
        break;

      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

/// Pop路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
