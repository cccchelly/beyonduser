import 'package:beyond_user/model/fix_detail_data.dart';
import 'package:beyond_user/network/api.dart';
import 'package:beyond_user/provider/view_state_model.dart';
import 'package:oktoast/oktoast.dart';

class FixDetailViewModel extends ViewStateModel {
  FixDetailData fixDetailData;

  getFixDetail(String mno) async {
    setBusy(true);
    fixDetailData = await Api.getFixDetail(mno);
    setOk();
  }

  cancleOrder(String reason) async {
    if(reason.isEmpty){
      showToast('请输入原因');
      return false;
    }

    try{
      return await Api.dealFixOrder({
        'id': fixDetailData.id,
        'repairType': 'CUSTOMER_CANCEL',
        'mno': fixDetailData.mno,
        'newestMaintain': {'id': _getFixId(), 'remark': reason}
      });
    }catch(e){
      return false;
    }
  }

  _getFixId() {
    int fixId = 0;
    fixDetailData.maintains.forEach((item) {
      if (item.status == 2) {
        fixId = item.id;
      }
    });
    return fixId;
  }
}
