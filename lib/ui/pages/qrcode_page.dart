
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/utlis/log_util.dart';
import 'package:oktoast/oktoast.dart';
import 'package:qrcode/qrcode.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';

class QrcodePage extends StatefulWidget {
   @override
   QrcodePageState createState() => new QrcodePageState();
 }

 class QrcodePageState extends State<QrcodePage> {
  QRCaptureController _captureController;

   @override
   Widget build(BuildContext context) {
     return new Scaffold(
       body: _buildWidget(),
     );
   }
   @override
   void initState() {
     super.initState();
     _captureController = QRCaptureController();
     _captureController.onCapture((scanContent){

       String resultContent = "";
       if (scanContent.contains("http://www.cdbeyond.com/?j=")||scanContent.contains("show?j=")){
         resultContent = scanContent.split("?")[1].split("=")[1];
       }else {
         resultContent = scanContent;
       }

       Navigator.of(context).pop(resultContent);

     });
   }

  _buildWidget() {
     return new Column(
       children: [
         CustomAppbarWhite('二维码扫描'),
         Expanded(
           flex: 1,
           child: Stack(
             children: <Widget>[
               Container(
                 width: double.infinity,
                 child: QRCaptureView(
                   controller: _captureController,
                 ),
               ),
               Image.asset('images/kk.png',width: double.infinity,fit: BoxFit.cover,),

             ],
           ),
         ),
       ],
     );

     /*return Center(
       child: Container(
         width: 200,
         height: 200,
         child: QRCaptureView(
           controller: _captureController,
         ),
       ),
     );*/
  }


 }