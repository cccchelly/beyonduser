import 'package:beyond_user/provider/view_state_model.dart';
import 'package:beyond_user/network/api.dart';
import 'package:beyond_user/model/main_data.dart';

class MainModel extends ViewStateModel{
  List<NewsListBean> newsList;
  List<CasusListBean> casusList;
  List<CommoditiesListBean> commoditList;
  List<BannersListBean> bannerList;

   getMainData() async{
     setBusy(true);
     MainData mainData =  await Api.getMainData();
     newsList = mainData.news;
     casusList = mainData.casus;
     commoditList = mainData.commodities;
     bannerList = mainData.banners;

     setOk();
     notifyListeners();

   }

}