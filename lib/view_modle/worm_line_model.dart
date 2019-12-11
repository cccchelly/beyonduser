import 'package:beyond_user/provider/view_state_model.dart';
import 'package:beyond_user/model/worm_line_choose_data.dart';
import 'package:beyond_user/model/worm_line_data.dart';
import 'package:beyond_user/network/api.dart';
import 'package:beyond_user/utlis/log_util.dart';


class WormLineModel extends ViewStateModel{
  WormLineChooseData chooseData;
  WormLineData lineData;


  //获取筛选条件
  void getPullDown() async{
    chooseData = await Api.getWormLineChoose();
    notifyListeners();
  }

  //获取虫情图表数据
  void getLineData(String crops, String deviceId, String startAt,
      String endAt, String owner, String pest, String type) async {

    setBusy(true);
    try{
      lineData = await Api.getWormLineData(crops, deviceId, startAt, endAt, owner, pest, type);
    }catch(e){
      lineData = null;
      setError('数据为空');
    }
    setOk();
    notifyListeners();
  }



}