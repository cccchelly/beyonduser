import 'package:beyond_user/provider/view_state_model.dart';
import 'package:beyond_user/network/api.dart';
import 'package:beyond_user/model/main_about_data.dart';


class MainAboutModel extends ViewStateModel{
  MainAboutData aboutData;

  getAboutData()async{
    setBusy(true);
    aboutData =  await Api.getAboutData();
    setOk();
    notifyListeners();

  }

}