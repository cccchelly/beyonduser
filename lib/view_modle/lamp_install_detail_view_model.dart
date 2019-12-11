import 'package:beyond_user/model/lamp_install_detail_model.dart';
import 'package:beyond_user/network/api.dart';
import 'package:beyond_user/provider/view_state_model.dart';

class LampInstallDetailViewModel extends ViewStateModel{
  LampInstallDetailModel detailData;
  
  getInstallDetail(String sn) async{
    setBusy(true);
    detailData = await Api.getInstallDetail(sn);
    setOk();
  }
  
}