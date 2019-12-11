import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/config/router_config.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:beyond_user/view_modle/user_model.dart';
import 'package:oktoast/oktoast.dart';

class Setting extends StatefulWidget {
  @override
  SettingState createState() => new SettingState();
}

class SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildWidget(),
    );
  }

  Widget _buildWidget() {
    return Container(
      child: new Column(
        children: [
          CustomAppbarWhite('设置'),
          Divider(
            height: 0.5,
            color: Color(LocalColors.bg_line),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 17),
            color: Colors.white,
            child: new Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      '修改密码',
                      style: TextStyle(
                          fontSize: 15, color: Color(LocalColors.text_212121)),
                    )),
                Image.asset('images/wd_jt.png'),
              ],
            ),
          ),
          Divider(
            height: 0.5,
            color: Color(LocalColors.bg_line),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 17),
            color: Colors.white,
            child: new Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      '关于我们',
                      style: TextStyle(
                          fontSize: 15, color: Color(LocalColors.text_212121)),
                    )),
                Image.asset('images/wd_jt.png'),
              ],
            ),
          ),
          Divider(
            height: 0.5,
            color: Color(LocalColors.bg_line),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 17),
            color: Colors.white,
            child: new Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      '清理缓存',
                      style: TextStyle(
                          fontSize: 15, color: Color(LocalColors.text_212121)),
                    )),
                Image.asset('images/wd_jt.png'),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                      onPressed: () {
                        _unLogin();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 32),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 10),
                          color: Theme.of(context).accentColor,
                          child: Text('退出登录',style: TextStyle(fontSize: 15,color: Colors.white),)))
                ],
              ))
        ],
      ),
    );
  }

  _unLogin(){
    var user = Provider.of<UserModel>(context);
    user?.clearUser();
    showToast('已退出登录');
    Navigator.of(context).pushNamed(RouteName.login);
  }

  @override
  void initState() {
    super.initState();
  }
}
