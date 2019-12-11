import 'package:flutter/material.dart';
import 'package:beyond_user/config/router_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:beyond_user/config/app_constans.dart';
import 'package:beyond_user/view_modle/user_model.dart';
import 'package:provider/provider.dart';
import 'package:beyond_user/view_modle/login_modle.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/utlis/log_util.dart';
import 'package:oktoast/oktoast.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/utlis/platform_utils.dart';

/*登录页*/
class Login extends StatefulWidget {
  @override
  LoginState createState() => new LoginState();
}

class LoginState extends State<Login> {
  var _userController = TextEditingController();
  var _passController = TextEditingController();
  var _codeController = TextEditingController();
  var _isPassHide = true;
  String imageUrl =  '';

  @override
  Widget build(BuildContext context) {
    _getCode();
    return new Scaffold(
      body: SingleChildScrollView(child: _buildLogin()),
    );
  }

  //获取唯一设备码然后拼到图片加载地址里  验证码图片加载需要 这里的timestamp作用只是让地址不一样  避免一直相同框架取缓存
  _getCode() {
    PlatformUtils.getDeviceCode().then((code){
      if(mounted){
        if(imageUrl.isEmpty){
          setState(() {
            imageUrl = '${AppConstans.BASE_URL}${AppConstans.URL_AUTH}code/image?deviceId=${code}&timestamp=${DateTime.now().millisecondsSinceEpoch}';
          });
        }else{
          imageUrl = '${AppConstans.BASE_URL}${AppConstans.URL_AUTH}code/image?deviceId=${code}&timestamp=${DateTime.now().millisecondsSinceEpoch}';
        }
      }
      MyLogUtil.log('url : $imageUrl');
    });
  }

  Widget _buildLogin() {
    return ProviderWidget<LoginModle>(
      model: LoginModle(Provider.of(context)),
      onModelReady: (model) {
        //放个默认账号
        /*_userController.text = 'beadmin';
        _passController.text = 'be123456';*/

        _userController.text = 'cdbeyond';
        _passController.text = 'Aa123456';
      },
      builder: (ctx, model, child) {
        return Form(child: child);
      },
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: <Widget>[
              Image.asset('images/dl_bg.png'),
              Center(
                child: new Column(
                  children: [
                    Container(margin: const EdgeInsets.only(top: 40),child: Image.asset('images/dl_logo.png')),
                    Container(margin: const EdgeInsets.only(top: 18),child: Text('比昂科技',style: TextStyle(fontSize: 18,color: Colors.white),)),
                  ],
                ),
              ),


            ],
          ),

          Container(
            margin: const EdgeInsets.only(left: 21, right: 21,top: 58),
            child: new Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 13),
                    child: Image.asset('images/dl_zh.png')),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: _userController,
                    onChanged: (str) {
                      _refreshBotton();
                    },
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(LocalColors.text_222222),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                        hintText: '请输入账号', hintStyle: TextStyle()),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 21, right: 21),
            child: new Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 13),
                    child: Image.asset('images/dl_mm.png')),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: _passController,
                    obscureText: _isPassHide,
                    onChanged: (str) {
                      _refreshBotton();
                    },
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(LocalColors.text_222222),
                    ),
                    decoration: InputDecoration(
                        hintText: '请输入密码', hintStyle: TextStyle()),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          _isPassHide = !_isPassHide;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Image.asset(
                          _isPassHide ? 'images/zy.png' : 'images/by.png'),
                    )),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 21,right: 21),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: _codeController,
                    maxLines: 1,
                    decoration: InputDecoration(hintText: '请输入验证码'),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    child: Container(
                      width: 108,
                      height: 42,
                      child: CachedNetworkImage(
                          imageUrl:imageUrl,
                      fit: BoxFit.fill,

                      errorWidget: (ctx,str,obj){
                            return Center(child: Text('加载失败，点击重试',style: TextStyle(fontSize: 12,color: Color(LocalColors.text_222222)),));
                      },),
                    ))
              ],
            ),
          ),
          LoginButton(_userController, _passController, _codeController)
        ],
      ),
    );
  }

  //信息输入改变时刷新一下界面  主要是登录按钮根据是否完善信息是否亮色
  void _refreshBotton() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    _codeController.dispose();
    super.dispose();
  }
}

class LoginButton extends StatelessWidget {
  var userController;
  var passController;
  var codeController;

  LoginButton(this.userController, this.passController, this.codeController);

  @override
  Widget build(BuildContext context) {
    //是否可以点击登录
    bool isCanLogin =
        userController.text.isNotEmpty && passController.text.isNotEmpty;
    var modle = Provider.of<LoginModle>(context);

    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 67),
        child: FlatButton(
          child: Text(
            '登录',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          splashColor: Color(LocalColors.botton_click),
          padding:
              const EdgeInsets.only(left: 150, right: 150, top: 12, bottom: 12),
          //如果账号密码有输入内容则亮色并且可以点击
          color: isCanLogin
              ? Theme.of(context).accentColor
              : Color(LocalColors.bg_c9cbc6),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(22))),
          onPressed: () {
            if (isCanLogin) {
              modle
                  .login(userController.text, passController.text,
                      codeController.text)
                  .then((isSuccess) {
                if (isSuccess) {
                  MyLogUtil.log(
                      '获取登录数据$isSuccess${Provider
                          .of<UserModel>(context)
                          .user
                          .access_token}');
                  Navigator.of(context).pop();
                  /*Navigator.of(context).pushReplacementNamed(
                      RouteName.mainfourpage);*/
                }else{
                  MyLogUtil.log('登录错误');
                }

              });
            } else {
              showToast('请输入完整的登录信息');
            }
          },
        ),
      ),
    );
  }
}
