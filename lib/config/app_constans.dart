import 'package:flutter/material.dart';

class AppConstans{

  //绿色云农url
  static const String BASE_URL_OLD = "http://service.scyphr.com:41008/";
  static const String PIC_BASE_URL = "http://service.scyphr.com:41008/api/";

  static String picContainsStr = "http://"; //图片是否是完整路径的判断开始标准

  //四情url
  //赵延本地
  //static const String BASE_URL = "http://192.168.1.33:8769/v1/";
  //公司本地服务器
  //static const String BASE_URL = "http://192.168.1.128:8769/v1/";
  //线上
  static const String BASE_URL = "https://wechat.scyphr.com/v1/";

  static const String IOS_GAODE_KEY = '288a51b7895f37d149b441b57454e5c1';

  static const String URL_AUTH = 'auth-server/';
  static const String URL_FOREMOOD = 'fourmood-web/';
  static const String URL_AFTER_SALES = "after-sales/";
  static const String URL_LAMP_REST = "lamp-rest/";
  static const String URL_SERVICE_USER = "service-user/";


  static GlobalKey<NavigatorState> navigatorState = new GlobalKey();

  static BuildContext context;
  
  static const bool isDebug = true;  //是否是debug模式  调试打日志
  static const int resultSuccess = 200;  //请求数据成功  后台不需要返回data的时候   包装的成功标志  给请求处判断

  
  static const imageUrlTemp = 'http://img1.imgtn.bdimg.com/it/u=3150283855,4248783514&fm=26&gp=0.jpg';

/*  http://192.168.1.33:8769/v1/fourmood-web/v2/api-docs
//杀虫灯
  http://192.168.1.33:8769/v1/lamp-rest/v2/api-docs

  http://192.168.1.33:8769/v1/service-user/v2/api-docs

//杀虫灯售后
  http://192.168.1.33:8769/v1/after-sales/v2/api-docs*/

}


class IntentKey{
  

}

class FixListDefaultType{
  static final int defaultType = 0;
  static final int checkType = 3;

}

class FixStatue{
  static const String daifenpei = "ONE"; //待分配
  static const String daixieshang = "TWO"; //待协商
  static const String xieshangquxiao = "THREE";  //协商取消
  static const String daiweixiu = "FOUR";  //协商通过 待维修
  static const String daikehuqueren = "FIVE"; //待客户确认
  static const String daizhuguanqueren = "SIX"; //主管确认
  static const String jiean = "SEVEN"; //结案
  static const String houtaiquxiao = "MINUS_ONE"; //后台取消
}

class Authority {
//报修
  static final String apply_fix = "app:device:reportmal:apply";

//查看维修记录
  static final String get_fix_history = "app:device:malfunclist";

//安装
  static final String install = "app:device:savedetail";

//查看安装记录
  static final String get_install_hostory = "app:device:myinstall";

//安装审核
  static final String install_audit = "app:device:audit";

//维修分配
  static final String fix_allocation = "app:device:reportmal:allocation";

//协商接单、拒单、维修
  static final String save_fix_msg = "app:device:reportmal:repair";

//维修审核
  static final String fix_audit = "app:device:reportmal:examine";

//安装建立二级客户(添加联系人)
  static final String add_link_man = "app:archive:addmanager";

//查看杀虫灯
  static final String get_lamp_list = "app:lamp:list";
}