import 'package:beyond_user/provider/view_state_refresh_list_model.dart';
import 'package:beyond_user/model/wea_sta_data_data.dart';
import 'package:beyond_user/network/api.dart';

class WeaStaDataModel extends ViewStateRefreshListModel<WeaStaDataData>{
  String imei;
  String beginAt = '';
  String endAt = '';

  WeaStaDataData currentData;

  WeaStaDataModel(this.imei,this.beginAt,this.endAt);

  @override
  Future<List<WeaStaDataData>> loadData({int pageNum}) async {
    return await Api.getWeaStaData(imei, pageNum ,beginAt,endAt,);
  }
  
  
  Future loadCurrentData()async{
    setBusy(true);
    currentData =  await Api.getWeaStaCurrentData(imei);
    setOk();
  }

  


}
