import 'package:beyond_user/config/app_constans.dart';

class ImageUtil{
  
  static getImageUrl(String u){
    if (u==null){
      return "";
    }else if (u.startsWith(AppConstans.picContainsStr)){
      return u;
    }else {
      return AppConstans.PIC_BASE_URL + u;
    }
  }
  
}