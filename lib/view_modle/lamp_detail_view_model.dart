import 'package:flustars/flustars.dart';
import 'package:beyond_user/network/api.dart';
import 'package:beyond_user/provider/view_state_model.dart';
import 'package:beyond_user/model/lamp_detail_msg_model.dart';
import 'package:beyond_user/model/lamp_detail_dct_model.dart';
import 'package:oktoast/oktoast.dart';


class LampDetailViewModel extends ViewStateModel{
  LampDetailMsgModel lampDetailMsg;
  List<LampDetailDctModel> staticisData = List();
  List<LampDetailDctModel> hourData = List();

  getDetail(String lampNo) async{
    setBusy(true);
    String nowTime = DateUtil.formatDate(DateTime.now(),format: 'yyyy-MM-dd');
    List<LampDetailMsgModel> lampMsgs =  await Api.getLampStatus(lampNo, '1970-01-01', nowTime, 1, 1);
    if(lampMsgs==null || lampMsgs.length<=0){
      showToast('暂无详情数据');
      
      return;
    }
    lampDetailMsg = lampMsgs[0];
    setOk();
    notifyListeners();
  }

  getHourRport(String lampNo) async{
  hourData = await Api.getHourReport(lampNo);
  notifyListeners();
  }

  getStaticis(String startTime, String endTime, String lampNo, int type) async{
   staticisData = await Api.getLampStaticis(startTime, endTime, lampNo, type.toString(), 1, 1<<20);
   notifyListeners();
  }
  
  
  
}