import 'dart:io';

import 'package:beyond_user/model/qr_device_msg_data.dart';
import 'package:beyond_user/model/upload_picture_data.dart';
import 'package:beyond_user/network/api.dart';
import 'package:beyond_user/provider/view_state_model.dart';
import 'package:beyond_user/utlis/log_util.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:oktoast/oktoast.dart';

class ApplyFixViewModel extends ViewStateModel {
  QrDeviceMsgData detailData;
  List<UploadPictureData> pictures = new List();
  String finalPicUrl = '';

  getDeviceMsg(String code)async{
    setBusy(true);
    detailData =  await Api.getDeviceMsgByQrcode(code);
    setOk();
  }

  /*
  * 报修步骤：
  * 1、判断信息是否完善
  * 2、递归上传照片，同时把已上传的照片存到list里，直到全部上传。
  * 3、全部上传后，把list里面的地址全部拼起来成一个字符串中间用逗号隔开
  * 4、照片地址字符串和其他信息一起上传报修信息
  * */
  Future<bool> applyFix(String sn,String name, String phone, String describetion,
      int type,int requiretime,List<Asset> assets)async{

    try{
      if(detailData == null){
        showToast('未获取到设备信息，请稍后再试');
        return false;
      }
      if(name.isEmpty){
        showToast('请输入报修人姓名');
        return false;
      }
      if(phone.isEmpty){
        showToast('请输入报修人电话');
        return false;
      }
      if(describetion.isEmpty){
        showToast('请输入报修原因');
        return false;
      }
      if(type == 0){
        showToast('请选择故障原因');
        return false;
      }
      if(assets.length == 0){
        showToast('请选择设备照片');
        return false;
      }

      await postPictures(assets);

      return await Api.dealFixOrder({
        'repairType': 'ALLOT',
        'imei' : detailData.sn,
        'type' : type,
        'linkman' : name,
        'linkMobile' : phone,
        'describe' : describetion,
        'requireTime' : requiretime,
        'problemImg' : finalPicUrl,
        'deviceType' : 'LAMP',
        'toCode' : 2,
      });
    }catch (e){
      return false;
    }

  }

  postPictures(List<Asset> assets)async{
      pictures.clear();
      List<Asset> assetsCopy = new List();
      assetsCopy.addAll(assets);
      await cycleUpload(assetsCopy);
  }

  //递归上传照片
  cycleUpload(List<Asset> assets) async{
    if(assets.length <= 0){
      String urlString = '';
      pictures.forEach((picBean){
        urlString = '$urlString${picBean.uri},';
      });
      finalPicUrl =  urlString.substring(0,urlString.length-1);
    }else{
      String filePath = await assets[0].filePath;
      String name = assets[0].name;
      UploadPictureData pictureData = await Api.postPicture(new File(filePath),name);
      pictures.add(pictureData);
      assets.removeAt(0);
      await cycleUpload(assets);
    }
  }



}