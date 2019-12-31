import 'package:beyond_user/model/time_area_model.dart';
import 'package:beyond_user/network/api.dart';
import 'package:beyond_user/provider/view_state_model.dart';
import 'package:beyond_user/utlis/log_util.dart';
import 'package:flustars/flustars.dart';
import 'package:oktoast/oktoast.dart';

class LampControllerViewModel extends ViewStateModel{

  setControl(String sn,int controlType,int lightOrTimeType,String lightTime,List<TimeAreaModel> timesBeans){

    if (controlType == 1 && lightOrTimeType == 1 && lightTime.isEmpty){
      showToast("请填写光控时间");
      return;
    }
    if (controlType == 1 && lightOrTimeType == 1 && (double.parse(lightTime)<=0 || double.parse(lightTime) >720)){
      showToast("光控时间应在0-720之间");
      return;
    }
    if (controlType == 1&&lightOrTimeType == 2 && !isTimesComplete(timesBeans)){
      showToast("请完善时控时间");
      return;
    }

    String command = "";

    switch (controlType) { ////0未选择  2强制开机 3 强制关机   1 正常工作
      case 2:
      case 3:
      //强制开关机command
        command = "{\"S$controlType\":\"111\",\"T1011111111\",\"T2011111111\",\"T3011111111\"}";
        //command = '{"S' + controlType + '":"111","T1011111111","T2011111111","T3011111111"}';

        break;
      case 1:
        if (lightOrTimeType == 1){ //光控 s0
          command = "{\"S0" + "\":\"" + formatTime(lightTime) + "\",\"T1011111111\",\"T2011111111\",\"T3011111111\"}";
          // command = '{"S' + '":"' + (0—720分钟,不足3位数前面加0补齐三位数)+ '","T1011111111","T2011111111","T3011111111"}';
        }else if (lightOrTimeType == 2){ //时控 s1
          String command;
          command = "{\"S1" + "\":\"111\"";
          for(var i=0;i<timesBeans.length;i++){
            command = "$command,T${i+1}1"
                "${DateUtil.formatDateMs(timesBeans[i].startTime,format: "HH")}"
                "${DateUtil.formatDateMs(timesBeans[i].startTime,format: "mm")}"
                "${DateUtil.formatDateMs(timesBeans[i].endTime,format: "HH")}"
                "${DateUtil.formatDateMs(timesBeans[i].endTime,format: "mm")}";
          }
          command = "$command}";
          /*Command = '{"S' + controlType + '":"111",'"T' + count（时间条数）+ "1" + 00(开始时，两位数) + 00(开始分，两位数) +
                    00(结束时，两位数)+ 00(结束分，两位数) + '",'"T' + count + '011111111",'+'}'*/
        }
        break;
      default:
        break;
    }

    if (command.isEmpty){
      showToast("请选择控制操作");
      return;
    }
    MyLogUtil.log("===="+command);
    postControl(sn,command);
  }

  setBControl(String sn,int type ){
    if (type == 0 ){
      showToast("请选择波段");
      return;
    }
    String str = "{WAVE:$type}";
    MyLogUtil.log("====$str");
    postControl(sn,str);
  }

  postControl(String sn,String msg)async{
    var isSuccess = await Api.lampControll(sn, msg);
    if(isSuccess){
      showToast('命令已发送');
    }else{
      showToast('发送失败');
    }
  }

  formatTime(String time){
    String t = "000";
    switch (time.length){
      case 1:
        t =  "00"+time;
        break;
      case 2:
        t = "0"+time;
        break;
      case 3:
        t = time;
        break;
    }
    return  t;
  }


  isTimesComplete(List<TimeAreaModel> timesBeans) {
    bool isComplete = true;

    timesBeans.forEach((time){
      if(time.startTime ==0 || time.endTime == 0){
        isComplete = false;
      }
    });
    return isComplete;
  }




}