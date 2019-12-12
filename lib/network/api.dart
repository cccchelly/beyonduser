import 'dart:io';
import 'package:beyond_user/config/net/http.dart';
import 'package:beyond_user/model/device_num.dart';
import 'package:beyond_user/model/spore_list_data.dart';
import 'package:beyond_user/model/upload_picture_data.dart';
import 'package:dio/dio.dart';
import 'package:beyond_user/config/app_constans.dart';
import 'package:beyond_user/config/storage_manager.dart';
import 'package:beyond_user/model/fix_detail_data.dart';
import 'package:beyond_user/model/fix_list_data.dart';
import 'package:beyond_user/model/lamp_install_detail_model.dart';
import 'package:beyond_user/model/qr_device_msg_data.dart';
import 'package:beyond_user/model/user.dart';
import 'package:beyond_user/utlis/log_util.dart';
import 'package:beyond_user/model/worm_list_data.dart';
import 'package:beyond_user/model/worm_pic_data.dart';
import 'package:beyond_user/model/worm_line_choose_data.dart';
import 'package:beyond_user/model/worm_line_data.dart';
import 'package:beyond_user/model/wea_sta_list_data.dart';
import 'package:beyond_user/model/wea_sta_data_data.dart';
import 'package:beyond_user/model/soil_data.dart';
import 'package:beyond_user/model/video_device_normal_data.dart';
import 'package:beyond_user/model/video_device_ball_data.dart';
import 'package:beyond_user/model/video_normal_show_data.dart';
import 'package:beyond_user/model/video_ball_pic_data.dart';
import 'package:beyond_user/model/main_data.dart';
import 'package:beyond_user/model/main_product_data.dart';
import 'package:beyond_user/model/main_about_data.dart';
import 'package:beyond_user/model/login_old_model.dart';
import 'package:beyond_user/model/user_msg_model.dart';
import 'package:beyond_user/model/lamp_list_model.dart';
import 'package:beyond_user/model/lamp_detail_msg_model.dart';
import 'package:beyond_user/model/lamp_detail_dct_model.dart';


class Api {
  //登录
  static Future<User> login(
      String userName, String passWord, String randomCode) async {
      var response = await http.post<Map>(
          "${AppConstans.URL_AUTH}authentication/form", queryParameters: {
        "username": userName,
        "password": passWord,
        "imageCode": randomCode
      });
      return User.fromJson(response.data);

  }

  //获取虫情设备列表
  static Future getWormDeviceList(int pageNum) async {
    var response =
        await http.post<Map>('${AppConstans.URL_FOREMOOD}forecast/query', data: {"pageNum": pageNum});

    return response.data['records']
        .map<WormListData>((item) => WormListData.fromJson(item))
        .toList();
  }

  //获取虫情图片
  static Future getWormPics(int pageNum, int pageSize, String imei,
      String startAt, String endAt) async {
    var response = await http.post<Map>('${AppConstans.URL_FOREMOOD}forecast/photo/find', data: {
      'pageNum': pageNum,
      'pageSize': pageSize,
      'imei': imei,
      'startAt': startAt,
      'endAt': endAt,
    });

    return response.data['records']
        .map<WormPicData>((item) => WormPicData.fromJson(item))
        .toList();
  }

  //获取虫情图像筛选条件
  static Future getWormLineChoose() async {
    var response = await http.get<Map>('det/photo/report/pulldown');
    return WormLineChooseData.fromJson(response.data);
  }

  //获取虫情曲线数据
  static Future getWormLineData(String crops, String deviceId, String startAt,
      String endAt, String owner, String pest, String type) async {
    var response = await http.post<Map>('${AppConstans.URL_FOREMOOD}forecast/photo/report/daily/chart', data: {
      'crops': crops,
      'deviceId': deviceId,
      'startAt': startAt,
      'endAt': endAt,
      'owner': owner,
      'pest': pest,
      'type': type
    });
    return WormLineData.fromJson(response.data);
  }

  //获取气象站设备列表数据
  static Future getWeaStaDeviceList(int pageNum, int pageSize) async {
    var response = await http.post<Map>('${AppConstans.URL_FOREMOOD}weather/query',
        data: {'pageNum': pageNum, 'pageSize': pageSize});

    return response.data['records']
        .map<WeaStaListData>((item) => WeaStaListData.fromJson(item))
        .toList();
  }

  //获取气象站列表数据
  static Future getWeaStaData(String imei, int pageNum,String beginAt,String endAt) async {
    var response = await http.post<Map>('${AppConstans.URL_FOREMOOD}weather/info',
        data: {'imei': imei,
          'pageNum': pageNum,
          'beginAt' : beginAt,
          'endAt' : endAt
    });

    return response.data['records']
        .map<WeaStaDataData>((item) => WeaStaDataData.fromJson(item))
        .toList();
  }

  //获取气象站最新数据
  static Future getWeaStaCurrentData(String imei) async {
    var response = await http.post<Map>('${AppConstans.URL_FOREMOOD}weather/current',
        data: {'imei': imei});

    return WeaStaDataData.fromJson(response.data);
  }

  //获取墒情设备列表
  static Future getSoilDevice() async {
    var response = await http.post<Map>('${AppConstans.URL_FOREMOOD}moisture/query',data: {
      'pageNum': 1,
      'moistureVendorType': 'XPH'
    });
    return response.data['records']
        .map<SoilData>((item) => SoilData.fromJson(item))
        .toList();
  }

  //获取墒情设备数据详情
  static Future getSoilDetail(
      String deviceId, String startAt, String endAt) async {
    var response = await http.post<Map>('${AppConstans.URL_FOREMOOD}moisture/statistics', queryParameters: {
      'deviceId': deviceId,
      'startAt': startAt,
      'endAt': endAt
    });
    return response.data;
  }

  //获取普通监控设备列表
  static Future getVDNormal(String pageStart, String pageSize) async {
    var response = await http.post<Map>('${AppConstans.URL_FOREMOOD}ys/list',
        data: {'pageStart': pageStart, 'pageSize': pageSize});

    return response.data['data']
        .map<VideoDeviceNormalData>(
            (item) => VideoDeviceNormalData.fromJson(item))
        .toList();
  }

  //获取球机监控设备列表
  static Future getVDBall(String pageStart, String pageSize) async {
    var response = await http.post<Map>('${AppConstans.URL_FOREMOOD}seedling/device/query',
        data: {'pageStart': pageStart, 'pageSize': pageSize});

    return response.data['records']
        .map<VideoDeviceBallData>((item) => VideoDeviceBallData.fromJson(item))
        .toList();
  }

  //获取普通监控视频流
  static Future getNormalVideo(String source) async {
    var response =
        await http.post<Map>('${AppConstans.URL_FOREMOOD}ys/liveAddress', data: {'source': source});
    return response.data['data']
        .map<VideoNormalShowData>((item) => VideoNormalShowData.fromJson(item))
        .toList();
  }

  //获取苗情图片列表
  static Future getVDBallPic(String imei,int pageNum, int pageSize,String startAt,String endAt) async{
    var response = await http.post<Map>('${AppConstans.URL_FOREMOOD}seedling/query',data: {
      'imei': imei,
      'pageNum': pageNum,
      'pageSize': pageSize,
    });

    return response.data['records']
        .map<VideoBallPicData>((item) => VideoBallPicData.fromJson(item)
    ).toList();
  }


  ///绿色云农部分的接口
  //获取首页数据
  static Future getMainData()async{
    var response = await http.get('${AppConstans.BASE_URL_OLD}api/index');

    return MainData.fromJson(response.data);
  }

  //获取产品分类
  static Future getCategory() async{
    var response = await http.get<Map>('${AppConstans.BASE_URL_OLD}api/commodity/list');

    return response.data['data'].map<MainProductData>((item) => MainProductData.fromJson(item)).toList();
  }

  //获取关于比昂数据
  static Future getAboutData() async{
    var response =  await http.get<Map>('${AppConstans.BASE_URL_OLD}api/about');
    return MainAboutData.fromJson(response.data['data'][0]);
  }


  //获取我的页面个人信息
  static Future getUserMsg() async{
    var response = await http.get<Map>('${AppConstans.URL_SERVICE_USER}user/loginUser');
    return UserMsgModel.fromJson(response.data);
  }

  //获取杀虫灯列表
  static Future getLampList(
      String name,
      String type,
      int machineStatus,
      int pageNum,
      int pageSize
      ) async{
    var response = await http.get<Map>('${AppConstans.URL_LAMP_REST}lamp/list',queryParameters: {
      'owner' : name,
      'type':type,
      'machineStatus' :machineStatus,
      'pageNum' : pageNum,
      'pageSize' : pageSize
    });

    return response.data['records'].map<LampListModel>((item) => LampListModel.fromJson(item)).toList();

  }

  //搜索杀虫灯
  static Future searchLamp (String code)async{
    //todo 这个接口还没弄好  弄好后再建实体类  在远程杀虫灯界面搜索杀虫灯
    var response = await http.get<Map>('${AppConstans.URL_LAMP_REST}lamp/ewm',queryParameters: {'code': code});
    

  }

  //根据二维码内容获取设备信息
  static Future getDeviceMsgByQrcode(String code) async{
    var response = await http.get<Map>('${AppConstans.URL_AFTER_SALES}ewm',queryParameters: {
      'qrCode' : code,
    });

    return QrDeviceMsgData.fromJson(response.data);
  }
  
  //获取杀虫灯当前状态
static Future getLampStatus(String lampNo,
    String start,
    String end,
    int pageNum,
    int pageSize) async{
    var response = await http.post<Map>('${AppConstans.URL_LAMP_REST}lamp/details',queryParameters: {
      'sn':lampNo,
      'start':start,
      'end':end,
      'pageNum':pageNum,
      'pageSize':pageSize
    });
    
    return response.data['records'].map<LampDetailMsgModel>((item) => LampDetailMsgModel.fromJson(item)).toList();
    
}

//获取杀虫灯时报
static Future getHourReport(String lampNo) async{
    var response = await http.get<Map>('${AppConstans.URL_LAMP_REST}lamp/hour_statistics/$lampNo');

    return response.data['records'].map<LampDetailDctModel>((item) => LampDetailDctModel.fromJson(item)).toList();
}

//获取杀虫灯报表
static Future getLampStaticis(String startTime, 
    String endTime,
    String lampNo,
    String type,
    num pageNum,
    num pageSize) async{
    var response = await http.post<Map>('${AppConstans.URL_LAMP_REST}lamp/statistics',queryParameters: {
      'start': startTime,
      'end': endTime,
      'sn': lampNo,
      'type': type,
      'pageNum': pageNum ,
      'pageSize': pageSize,
      
    });
  return response.data['records'].map<LampDetailDctModel>((item) => LampDetailDctModel.fromJson(item)).toList();
  
}

//获取安装详情
static Future getInstallDetail(String sn) async{
    var response = await http.get<Map>('${AppConstans.URL_AFTER_SALES}device/detail',queryParameters: {'sn':sn});
    return LampInstallDetailModel.fromJson(response.data);
}

//获取维修列表
static Future getFixList(int pageNum,int pageSize,String statue)async{
    var response = await http.post<Map>('${AppConstans.URL_AFTER_SALES}device/malfuncList',data: {
      'pageNum':pageNum,
      'pageSize' : pageSize,
      'states' : statue,
      'aboutme' : 0    //设置这个参数   大于0表示筛选除去自己报修的维修中的订单  原本用来排除维修工人自己的保修单  这里都是用户可以写死
    });
    return response.data['records'].map<FixListData>((item) => FixListData.fromJson(item)).toList();

}

//获取维修详情
static Future getFixDetail(String mno)async{
    var response = await http.get<Map>('${AppConstans.URL_AFTER_SALES}device/malfunction/$mno');
    return FixDetailData.fromJson(response.data);
}

//上传照片
static Future postPicture(List<int> bytes,String name)async{
    FormData formData = FormData.from({'file': UploadFileInfo.fromBytes(bytes, name)});

    var response = await http.post<Map>('${AppConstans.URL_AFTER_SALES}upload/fileObj',data: formData);
    return UploadPictureData.fromJson(response.data);
}

//工单处理
static Future dealFixOrder(var requestData)async{
    var response = await http.post('${AppConstans.URL_AFTER_SALES}device/report',data: requestData);
    return response.data['data'] == AppConstans.resultSuccess;
}

//我的  设备数据
static Future getDeviceNum()async{
    var response = await http.get('${AppConstans.URL_FOREMOOD}index/deviceNum');
    return DeviceNumData.fromJson(response.data);

}

//获取孢子设备数据
static Future getSporeList()async{
    var response = await http.post<Map>('${AppConstans.URL_FOREMOOD}spore/query');
    return response.data['data'].map<SporeListData>((item) => SporeListData.fromJson(item)).toList();
}



}
