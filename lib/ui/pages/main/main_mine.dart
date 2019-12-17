import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/config/router_config.dart';
import 'package:beyond_user/model/fix_list_arg_bean.dart';
import 'package:beyond_user/model/user_data.dart';
import 'package:beyond_user/utlis/permission_util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:beyond_user/view_modle/user_model.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/utlis/ShareUtil.dart';
import 'package:beyond_user/utlis/log_util.dart';
import 'package:beyond_user/config/app_constans.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/view_modle/mine_view_model.dart';

import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

class MainMine extends StatefulWidget {
  @override
  MainMineState createState() => new MainMineState();
}

class MainMineState extends State<MainMine> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      /*appBar: new AppBar(
        title: new Text(
          '我的',
          style: TextStyle(fontSize: 16,color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
        leading: Text(''),
      ),*/
      body: _loadLayout(),
    );
  }

  Widget _loadLayout() {
    UserData userData = Provider.of<UserModel>(context).user;
    if (userData?.access_token == null) {
      return _buildUnLogin();
    } else if (userData.access_token.isEmpty) {
      return _buildUnLogin();
    } else {
      MyLogUtil.log(userData.access_token);
      return _buildLogined();
    }
  }

  Widget _buildLogined() {
    MyLogUtil.log('已登录');
    return SingleChildScrollView(
      child: ProviderWidget<MineViewModel>(
        model: MineViewModel(),
        onModelReady: (model) {
          model.getUserMsg();
          model.getDevicesAccount();
        },
        builder: (context, model, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*我的，申请维修，联系客服，设备档案*/
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  Image.asset('images/dl_bg.png'),
                  Container(
                    margin: const EdgeInsets.only(top: 31),
                    child: Text(
                      '我的',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 77, left: 12, right: 20),
                    child: new Row(
                      children: [
                        Image.asset(
                          'images/dl_logo.png',
                          width: 68,
                          height: 68,
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                                margin: const EdgeInsets.only(left: 19),
                                child: Text(
                                  '${ShareUtil.instance().getUserName()}',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ))),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(RouteName.setting);
                            },
                            child: Image.asset('images/wd_sz.png')),
                      ],
                    ),
                  ),
                  Container(
                    height: 98,
                    margin:
                        const EdgeInsets.only(top: 170, left: 12, right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.white,
                    ),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              _applyToFix();
                            },
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/wd_wdfw_sqwx.png'),
                                Text(
                                  '申请维修',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(LocalColors.text_555555)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              _connectUs();
                            },
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/wd_lxkf.png'),
                                Text(
                                  '联系客服',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(LocalColors.text_555555)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              _showCloseToast();
                            },
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/wd_wdfw_sbda.png'),
                                Text(
                                  '帮助中心',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(LocalColors.text_555555)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //产品中心
              Container(
                color: Colors.white,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(left: 13, right: 13, top: 15),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '产品中心',
                      style: TextStyle(
                          fontSize: 16, color: Color(LocalColors.text_222222)),
                    ),

                    //虫情监控、墒情监测
                    new Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 18, top: 30, bottom: 18),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(RouteName.worm_list);
                              },
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/wd_cqjk.png',
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 7),
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '虫情监控',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(
                                                  LocalColors.text_222222)),
                                        ),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                                '${model?.deviceNumData?.forecast}台',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(LocalColors
                                                        .text_666666)))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 18, top: 18, bottom: 18),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(RouteName.soil);
                              },
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/wd_sqjc.png',
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 7),
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '墒情监测',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(
                                                  LocalColors.text_222222)),
                                        ),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                                '${model?.deviceNumData?.moisture}台',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(LocalColors
                                                        .text_666666)))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    //视频监控 气象站
                    new Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 18, top: 18, bottom: 18),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(RouteName.video_list);
                              },
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/wd_spjk.png',
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 7),
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '视频监控',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(
                                                  LocalColors.text_222222)),
                                        ),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                                '${model?.deviceNumData?.seedling}台',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(LocalColors
                                                        .text_666666)))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 18, top: 18, bottom: 18),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(RouteName.wea_sta_list);
                              },
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/wd_qxz.png',
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 7),
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '气象站',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(
                                                  LocalColors.text_222222)),
                                        ),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                                '${model?.deviceNumData?.weather}台',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(LocalColors
                                                        .text_666666)))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    //物联网杀虫灯  非物联网杀虫灯
                    new Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 18, top: 18, bottom: 25),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(RouteName.lamp_list_net);
                              },
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/wd_wlwscd.png',
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 7),
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '物联网杀虫灯',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(
                                                  LocalColors.text_222222)),
                                        ),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                                '${model?.deviceNumData?.lamp}台',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(LocalColors
                                                        .text_666666)))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(RouteName.lamp_list_local);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 18, top: 18, bottom: 18),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/wd_scd.png',
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 7),
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('非物联网杀虫灯',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(
                                                    LocalColors.text_222222))),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                                '${model?.deviceNumData?.localLamp}台',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(LocalColors
                                                        .text_666666)))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    //孢子捕捉仪 LED大屏
                    new Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 18, top: 18, bottom: 25),
                            child: InkWell(
                              onTap: () {
                                /*Navigator.of(context)
                                    .pushNamed(RouteName.spore_list);*/
                                _noDevice(model);
                              },
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/bzbzy.png',
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 7),
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '孢子捕捉仪',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(
                                                  LocalColors.text_222222)),
                                        ),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                                '${model?.deviceNumData?.spore}台',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(LocalColors
                                                        .text_666666)))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              _noDevice(model);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 18, top: 18, bottom: 18),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/leddp.png',
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 7),
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('LED大屏',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(
                                                    LocalColors.text_222222))),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Text('0台',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(LocalColors
                                                        .text_666666)))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    //水肥一体化  产品追溯
                    new Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 18, top: 18, bottom: 25),
                            child: InkWell(
                              onTap: () {
                                _noDevice(model);
                              },
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/sfyth.png',
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 7),
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '水肥一体化',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(
                                                  LocalColors.text_222222)),
                                        ),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Text('0台',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(LocalColors
                                                        .text_666666)))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              _noDevice(model);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 18, top: 18, bottom: 18),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/cpzs.png',
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 7),
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('产品追溯',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(
                                                    LocalColors.text_222222))),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Text('0台',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(LocalColors
                                                        .text_666666)))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //售后服务
              Container(
                color: Colors.white,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 13, bottom: 13),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding:
                            const EdgeInsets.only(left: 13, right: 13, top: 15),
                        child: Text(
                          '售后服务',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(LocalColors.text_222222)),
                        )),
                    Container(
                      padding: const EdgeInsets.only(top: 30, bottom: 25),
                      child: new Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                _applyToFix();
                              },
                              child: new Column(
                                children: [
                                  Image.asset('images/wd_sqwx.png'),
                                  Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        '申请维修',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Color(LocalColors.text_444444)),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    RouteName.fix_list,
                                    arguments: FixListArgBean(
                                        FixListDefaultType.defaultType, ''));
                              },
                              child: new Column(
                                children: [
                                  Image.asset('images/wd_wxjl.png'),
                                  Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        '维修记录',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Color(LocalColors.text_444444)),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    RouteName.fix_list,
                                    arguments: FixListArgBean(
                                        FixListDefaultType.checkType, ''));
                              },
                              child: new Column(
                                children: [
                                  Image.asset('images/wd_dsh.png'),
                                  Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        '待审核',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Color(LocalColors.text_444444)),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //增值服务
              Container(
                color: Colors.white,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 13, bottom: 13),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding:
                            const EdgeInsets.only(left: 13, right: 13, top: 15),
                        child: Text(
                          '增值服务',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(LocalColors.text_222222)),
                        )),
                    Container(
                      padding: const EdgeInsets.only(top: 30, bottom: 25),
                      child: new Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(RouteName.worm_indentify);
                              },
                              child: new Column(
                                children: [
                                  Image.asset('images/wd_hcjb.png'),
                                  Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        '害虫鉴别',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Color(LocalColors.text_444444)),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(RouteName.orange_indentify);
                              },
                              child: new Column(
                                children: [
                                  Image.asset(
                                    'images/gcbcjb.png',
                                    width: 28,
                                    height: 28,
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        '柑橘病虫害鉴别',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Color(LocalColors.text_444444)),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                _showCloseToast();
                              },
                              child: new Column(
                                children: [
                                  Image.asset('images/wd_sbda.png'),
                                  Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        '专家服务',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Color(LocalColors.text_444444)),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                _showCloseToast();
                              },
                              child: new Column(
                                children: [
                                  Image.asset('images/wd_zszx.png'),
                                  Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        '知识中心',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Color(LocalColors.text_444444)),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  //无设备提醒
  _noDevice(MineViewModel model) {
    showDialog(
      context: context,
      builder: (context){
        return SimpleDialog(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 18,right: 18),
              child: new Column(
                children: [
                  Text('暂未购买此设备，请联系销售人员购买，或点击刷新按钮获取最新数据',style: TextStyle(fontSize: 15,color: Color(LocalColors.text_666666)),),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: new Row(
                      children: [
                        Expanded(flex: 1,child: InkWell(onTap: (){
                          model.getDevicesAccount();
                          Navigator.of(context).pop();
                        },child: Center(child: Text('刷新',style: TextStyle(fontSize: 15,color: Theme.of(context).accentColor),)))),
                        Expanded(flex: 1,child: InkWell(onTap: (){
                          _connectUs();
                          Navigator.of(context).pop();
                        },child: Center(child: Text('联系客服',style: TextStyle(fontSize: 15,color: Theme.of(context).accentColor),)))),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        );
      }
    );
  }

  //联系客服
  _connectUs() async{
    const url = "tel:13228103000";
    if(await canLaunch(url)){
    launch(url);
    }else{
    throw "can not launch url $url";
    }
  }

  //暂未开通功能
  _showCloseToast() {
    showToast('暂未开通');
  }

  //申请维修
  _applyToFix() async {
    bool b = await PermissionUtil.requestCameraPermission();
    if (b) {
      var qrcode = await Navigator.of(context).pushNamed(RouteName.qrcode_page);

      if (qrcode != null) {
        Navigator.of(context).pushNamed(RouteName.apply_fix, arguments: qrcode);
      }
    }
  }

  //未登录界面
  Widget _buildUnLogin() {
    MyLogUtil.log('未登录');
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 80, height: 80, child: Image.asset("images/dl_logo.png")),
          Container(
              margin: const EdgeInsets.only(top: 12, bottom: 12),
              child: Text(
                "您还未登录，登陆查看更多精彩内容？",
                style: TextStyle(
                    fontSize: 13, color: Color(LocalColors.text_666666)),
              )),
          InkWell(
            onTap: () {
              _toLogin(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.only(
                  top: 8, bottom: 10, left: 100, right: 100),
              child: Text(
                "去登陆",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _toLogin(BuildContext context) {
    Navigator.of(context).pushNamed(RouteName.login);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
