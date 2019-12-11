import 'dart:convert';
import 'dart:io' show ContentType;

import 'package:beyond_user/config/app_constans.dart';
import 'package:beyond_user/view_modle/user_model.dart';

import 'package:beyond_user/utlis/platform_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:beyond_user/utlis/platform_utils.dart';
import 'package:beyond_user/utlis/log_util.dart';


import '../storage_manager.dart';
import 'apiInterceptor.dart';
import 'package:provider/provider.dart';

final Http http = Http();

class Http extends Dio {
  static Http instance;

  factory Http() {
    if (instance == null) {
      instance = Http._().._init();
    }
    return instance;
  }

  Http._();

  /// 初始化 加入app通用处理
  _init() {
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    interceptors
      // 基础设置
      ..add(HeaderInterceptor())
      // JSON处理
      ..add(ApiInterceptor())
      // cookie持久化 异步
      ..add(CookieManager(
          PersistCookieJar(dir: StorageManager.temporaryDirectory.path)));
  }


}

// 必须是顶层函数
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

/// 添加常用Header
class HeaderInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    options.connectTimeout = 1000 * 45;
    options.receiveTimeout = 1000 * 45;

    var user = Provider.of<UserModel>(AppConstans.navigatorState.currentContext).user;

    var appVersion = await PlatformUtils.getAppVersion();
    var version = Map()
      ..addAll({
        'appVerison': appVersion,
      });

    //options.headers['version'] = version;
    //options.headers['platform'] = PlatformUtils.getPlatform();

    if(options.path.contains('auth-server/authentication/form')){
      options.headers['Authorization'] = 'Basic ${base64Encode(utf8.encode('beyond2:secret2'))}';
      options.headers['deviceId'] =  await PlatformUtils.getDeviceCode();
    }else{
      options.headers['Authorization'] = 'Bearer ${user?.access_token}';
      //options.queryParameters.addAll({'access_token' : user?.token});
    }

    return options;
  }

}
