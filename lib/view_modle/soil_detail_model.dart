import 'package:beyond_user/provider/view_state_model.dart';
import 'package:beyond_user/network/api.dart';
import 'package:beyond_user/model/soil_detail_data.dart';
import 'package:convert/convert.dart';

class SoilDetailModel extends ViewStateModel{

  List<NewestListBean> newestListBean;
  List<List<Detail>> details = new List();
  List<String> keys = new List();

  getDetail(String deviceId,String startAt,String endAt) async{

    setBusy(true);
    Map json = await Api.getSoilDetail(deviceId, startAt, endAt);

    ///这里的数据只是获取到一个map 然后手动解析到需要的部分  因为历史数据后台返回了key不确定的数组
    ///把json贴到下面对着看就知道解析过程了
    newestListBean = SoilDetailData.fromJson(json).newest;

    Map detailJson =  json['detail'] as Map;

    details.clear();
    keys.clear();
    detailJson.keys.forEach((key){
      keys.add(key);
      List<Detail> detail= detailJson[key].map<Detail>((item) => Detail.fromJson(item)).toList();
      details.add(detail);
    });

    notifyListeners();
    setOk();
  }

}


/*{
"detail": {
"2019-09-05": [
{
"d": "5",
"ec": null,
"humidity": 0.1875,
"m": "9",
"ph": null,
"temperature": 23.430208,
"tier": 1,
"upDate": "2019-09-05",
"y": "2019"
},
{
"d": "5",
"ec": null,
"humidity": 0.1875,
"m": "9",
"ph": null,
"temperature": 23.546354,
"tier": 2,
"upDate": "2019-09-05",
"y": "2019"
},
{
"d": "5",
"ec": null,
"humidity": 0.282292,
"m": "9",
"ph": null,
"temperature": 23.247395,
"tier": 3,
"upDate": "2019-09-05",
"y": "2019"
}
],
"2019-09-06": [
{
"d": "",
"ec": 0,
"humidity": 0,
"m": "",
"ph": 0,
"temperature": 0,
"tier": 1,
"upDate": "2019-09-06",
"y": ""
},
{
"d": "",
"ec": 0,
"humidity": 0,
"m": "",
"ph": 0,
"temperature": 0,
"tier": 2,
"upDate": "2019-09-06",
"y": ""
},
{
"d": "",
"ec": 0,
"humidity": 0,
"m": "",
"ph": 0,
"temperature": 0,
"tier": 3,
"upDate": "2019-09-06",
"y": ""
}
]
},
"newest": [
{
"id": 2226,
"imei": "16063509",
"moistureRecordDetails": [
{
"ec": null,
"humidity": 0,
"ph": null,
"recordId": 2226,
"temperature": 25,
"tier": 1
},
{
"ec": null,
"humidity": 0,
"ph": null,
"recordId": 2226,
"temperature": 25,
"tier": 2
},
{
"ec": null,
"humidity": 0,
"ph": null,
"recordId": 2226,
"temperature": 24.9,
"tier": 3
}
],
"upDate": 1567752210000
}
]
}*/

