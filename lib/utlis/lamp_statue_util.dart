import 'package:flustars/flustars.dart';

class LampStatueUtil{
  int statusCode;
  String lastTimeStr;

  static  const  String  normal= 'normal';
  static  const  String  netError= 'netError';
  static  const  String  wait= 'wait';
  static  const  String  bad= 'bad';
  static  const  String  unknown= 'unknown';


  LampStatueUtil(this.statusCode,{String lastTimeStr,num lastTimeMills}){
    if(lastTimeStr !=null){
      this.lastTimeStr = lastTimeStr;
    }
    if(lastTimeMills !=null){
      this.lastTimeStr = DateUtil.formatDateMs(lastTimeMills);
    }
  }

  String getLampStatuesEnum(){
    if (isOffline()&&statusCode==0){
      return netError;
    }else if (!isOffline() && statusCode==0){
      return normal;
    }else if (statusCode == 1){
     return wait;
    }else{
      return unknown;
    }

    //没有故障   某一次跟杨露堃他们讨论了后说我们的灯不会故障👏👏
  }
  
  String getLampStatuesStr(){
    switch(getLampStatuesEnum()){
      case netError:
        return '网络异常';
        break;
      case normal:
        return '正常';
        break;
      case wait:
        return '待机';
        break;
      case unknown:
      default:
        return '未知';
        break;
    }
  }


  bool isOffline(){
   num lastMills = DateUtil.getDateMsByTimeStr(lastTimeStr);
   num nowMills = DateTime.now().millisecondsSinceEpoch;

   return nowMills - lastMills > 3*24*60*60*1000;

  }


}