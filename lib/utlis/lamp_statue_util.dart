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

  String getLampStatues(){
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


  bool isOffline(){
   num lastMills = DateUtil.getDateMsByTimeStr(lastTimeStr);
   num nowMills = DateTime.now().millisecondsSinceEpoch;

   return nowMills - lastMills > 3*24*60*60*1000;

  }


}