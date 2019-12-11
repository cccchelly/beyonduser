import 'dart:convert';

import 'package:oktoast/oktoast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:beyond_user/provider/view_state.dart';
import 'http.dart';
import 'package:beyond_user/config/app_constans.dart';
export 'package:dio/dio.dart';
import 'package:beyond_user/utlis/log_util.dart';
import 'package:beyond_user/config/app_constans.dart';
import 'package:beyond_user/view_modle/user_model.dart';
import 'package:provider/provider.dart';
import 'package:beyond_user/config/router_config.dart';


///API
class ApiInterceptor extends InterceptorsWrapper {

  @override
  onRequest(RequestOptions options) {
    options.baseUrl = AppConstans.BASE_URL;

    MyLogUtil.log('请求地址：${options.baseUrl}${options.path}');
    MyLogUtil.log('请求头：${options.headers.toString()}');
    MyLogUtil.log('参数：${options.queryParameters}');
    MyLogUtil.log('请求类：${options.data}');

    return options;
  }

  @override
  onResponse(Response response) {

    MyLogUtil.log('获取到数据：\n ${response.toString()}');

    var statusCode = response.statusCode;
    if (statusCode != 200) {
      /// 非200会在http的onError()中
    } else {
//      debugPrint('---api-response--->resp----->${response.data}');
      if (response.data is Map) {

        RespData respData = RespData.fromJson(response.data);

        if (respData.success) {
          if(respData.data == null){ //处理请求成功  然后后台返回高速成功而不需要任何data数据的情况  包装一下高速请求处已成功
            response.data = {'data' : AppConstans.resultSuccess};
          }else if(respData.data is Map) {
            response.data = respData.data;
          }else{
            //data层有可能不是map  而是array，但是请求的数据返回要求是map，又想以map形式返回response.data 这种时候直接将array包成map
            response.data = {'data' : respData.data};
          }

          return http.resolve(response);
        } else {
          return handleFailed(respData);
        }
      } else {
        ///返回的数据类型存在问题
        MyLogUtil.log('返回数据存在问题：\n $response');
        RespData respData = RespData.fromJson(json.decode(response.data));
        return handleFailed(respData);
      }
    }
  }

  //dio 错误  在这里处理http请求错误
  @override
  onError(DioError e) {
    MyLogUtil.log('http 错误${e.message}${e.response}${e.type}${e.stackTrace}');

    switch(e.response.statusCode){
      case 500:
        try{
          var data = json.decode(e.response.toString());
          var resp = RespData.fromJson(data);
          MyLogUtil.log('===${resp.toString()}');
          showToast(resp.message.isEmpty ? '服务器异常' : '${resp.message}');
        }catch (e){
          showToast('服务器异常');
        }
        break;
        //登录失效
      case 401:
        MyLogUtil.log('登录失效');
        reLogin();
        break;
      case 403:
        showToast('无权限');
        break;

    }

  }


  Future<Response> handleFailed(RespData respData) {
    MyLogUtil.log('出现错误：回调handleFailed方法 \n $respData');
    switch(respData.code){
      case 401:
        showToast('登录失效，请重新登录');
        reLogin();
        break;
      case 403:
        showToast('无权限');
        break;
      default:
        showToast(respData.message);
        break;
    }
    return http.reject(respData.message);
  }
}

//清除登录信息重新登录（token失效）
void reLogin(){
  var userModel = Provider.of<UserModel>(AppConstans.navigatorState.currentContext);
  userModel.clearUser();
  AppConstans.navigatorState.currentState.pushNamed(RouteName.login);

}

class RespData {
  dynamic data;
  int code = -1;
  String message;

  //status 老接口status状态码为0表示成功  这里做一下兼容  新接口是使用code 200   上传图片返回code 值为0表示成功
  int status;

  bool get success => 200 == code || code == 0 || status == 0;

  RespData({this.data, this.code, this.message});

  @override
  String toString() {
    return 'RespData{data: $data, code: $code, status： $status msg: $message}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.message;
    data['data'] = this.data;
    data['status'] = this.status;
    return data;
  }

  RespData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['msg'];
    data = json['data'];
    status = json['status'];
  }
}


