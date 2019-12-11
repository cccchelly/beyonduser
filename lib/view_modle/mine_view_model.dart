import 'package:beyond_user/model/device_num.dart';
import 'package:beyond_user/provider/view_state_model.dart';
import 'package:beyond_user/network/api.dart';
import 'package:beyond_user/model/user_msg_model.dart';
import 'package:beyond_user/utlis/ShareUtil.dart';

class MineViewModel extends ViewStateModel {
  UserMsgModel userMsgModel;
  DeviceNumData deviceNumData;

  getUserMsg() async{
    setBusy(true);
    userMsgModel = await Api.getUserMsg();

    ShareUtil.instance().saveUserName(userMsgModel?.username);

    //为了远程杀虫灯数据暂时写死
    //ShareUtil.instance().saveUserName('峨眉山市农业农村局');

    setOk();
    notifyListeners();
  }

  getDevicesAccount()async{
      setBusy(true);
      deviceNumData = await Api.getDeviceNum();
      setOk();
  }

}