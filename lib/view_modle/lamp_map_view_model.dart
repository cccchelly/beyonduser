import 'package:beyond_user/model/lamp_list_model.dart';
import 'package:beyond_user/network/api.dart';
import 'package:beyond_user/provider/view_state_model.dart';
import 'package:beyond_user/utlis/ShareUtil.dart';

class LampMapViewModel extends ViewStateModel{
  String type;
  List<LampListModel> lampList = new List();

  LampMapViewModel(this.type);
  
  getLampList({String type,int machineStatus}) async{
    if(type != null){
      this.type = type;
    }
    setBusy(true);
    //1或者不传  远程  2非远程  3远程初始位置
    lampList = await Api.getLampList(ShareUtil.instance().getUserName(), this.type, machineStatus, 1, 10000);
    setOk();
  }


}