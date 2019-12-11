import 'package:beyond_user/provider/view_state_model.dart';
import 'package:beyond_user/network/api.dart';
import 'package:beyond_user/model/main_product_data.dart';

class MainProductModel extends ViewStateModel{
  List<MainProductData> prodectList;

  getCategory() async{
    setBusy(true);
    prodectList =  await Api.getCategory();
    setOk();
    notifyListeners();
  }

}