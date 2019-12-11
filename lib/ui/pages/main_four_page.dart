import 'package:flutter/material.dart';
import 'package:beyond_user/config/app_constans.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/config/router_config.dart';
import 'package:beyond_user/view_modle/user_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';



/*首页*/
class MainFourPage extends StatefulWidget {
  @override
  MainFourPageState createState() => new MainFourPageState();
}

class MainFourPageState extends State<MainFourPage> {
  @override
  Widget build(BuildContext context) {
    AppConstans.context = context;

    return new Scaffold(
        body: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/sy_tq_bg.png'),
                        fit: BoxFit.fill),
                  ),
                  child: new Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 32, bottom: 22),
                          child: Text(
                            '比昂智慧农业',
                            style: TextStyle(
                                color: Color(LocalColors.text_016E2D),
                                fontSize: 16),
                          )),
                      Text('成都',
                          style: TextStyle(color: Colors.white, fontSize: 24)),
                      Container(
                          padding: const EdgeInsets.only(top: 9, bottom: 10),
                          child: Text(
                            '38.6518,104.07642',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )),
                      Image.asset('images/sy_tq_tb.png'),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 18, bottom: 18, left: 10, right: 10),
                        child: new Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text(
                                  '温度：18℃~28℃',
                                  style: TextStyle(
                                      color: Color(LocalColors.text_FEFEFE),
                                      fontSize: 15),
                                )),
                            Text('天气：雷阵雨',
                                style: TextStyle(
                                  color: Color(LocalColors.text_FEFEFE),
                                  fontSize: 15,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                _buildFunGrid(),

                _buildExitWidget(),
              ],
            ),
          ],
        ));
  }


  ///提供一个测试用的退出登录功能
  Widget _buildExitWidget(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('这里是退出登录的功能，用来测试的'),
        FlatButton(
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed(RouteName.login);
            },
            child: Text(Provider.of<UserModel>(context).hasUser ? '登录过，重新登录':'未登录，去登录')),
        FlatButton(
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            onPressed: (){
              Provider.of<UserModel>(context).clearUser();
            },
            child: Text('清除登录信息')
        ),

      ],
    );
  }


  Widget _buildFunGrid() {
    return Container(
      padding: const EdgeInsets.only(top: 18,bottom: 18),
      child: GridView.builder(physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4),
          itemCount: funPics.length,
          itemBuilder: (ctx,index){
            return InkWell(
              onTap: (){
                _onFunClicked(index);
              },
              child: Center(
                child: new Column(
                  children: [
                    Image.asset(funPics[index]),
                    Text(funText[index],style: TextStyle(
                      fontSize: 13,
                      color: Color(LocalColors.text_222222)
                    ),),
                  ],
                ),
              ),
            );
          }),
    );
  }

  //功能选项点击事件
  void _onFunClicked(int index){
    switch(funText[index]){
      case '虫情监控':
        Navigator.of(context).pushNamed(RouteName.worm_list);
        break;
      case '气象站':
        Navigator.of(context).pushNamed(RouteName.wea_sta_list);
        break;
      case '杀虫灯':
       // Navigator.of(context).pushNamed(RouteName.lamp_list);
        break;
      case '视频监控':
        Navigator.of(context).pushNamed(RouteName.video_list);
        break;
      case '孢子捕捉仪':
        AppConstans.navigatorState.currentState.pushNamed(RouteName.spore_list);
        break;
      case '追溯系统':
        showToast('功能开发中');
        break;
      case '土壤墒情':
        Navigator.of(context).pushNamed(RouteName.soil);
        break;
    }
  }



  var funPics = [
    'images/sy_cqjk.png',
    'images/sy_qxz.png',
    'images/sy_scd.png',
    'images/sy_spjk.png',
    'images/sy_bzbzy.png',
    'images/sy_zsxt.png',
    'images/sy_trsq.png',
  ];

  var funText = [
    '虫情监控',
    '气象站',
    '杀虫灯',
    '视频监控',
    '孢子捕捉仪',
    '追溯系统',
    '土壤墒情',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(MainFourPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}

