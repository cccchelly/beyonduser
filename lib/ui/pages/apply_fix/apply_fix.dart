import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/config/router_config.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:beyond_user/utlis/image_util.dart';
import 'package:beyond_user/utlis/log_util.dart';
import 'package:beyond_user/view_modle/apply_fix_view_model.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:oktoast/oktoast.dart';


class ApplyFix extends StatefulWidget {
  @override
  ApplyFixState createState() => new ApplyFixState();
}

class ApplyFixState extends State<ApplyFix> {
  String qrcode;
  List<Asset> applyImages = new List();
  List<String> dealTimeList;
  int dealTimeCheckIndex = 0;

  bool isRequest = false;

  String radCheckText = '';
  int radCheckType = 0;

  TextEditingController _applyManController;
  TextEditingController _linkMobileController;
  TextEditingController _applyReasonController;

  @override
  Widget build(BuildContext context) {
    qrcode = ModalRoute.of(context).settings.arguments;
    return new Scaffold(
      body: _buildWidget(),
    );
  }

  _buildWidget() {
    return new Column(
      children: [
        CustomAppbarWhite('申请维修'),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: ProviderWidget<ApplyFixViewModel>(
              model: ApplyFixViewModel(),
              onModelReady: (model) {
                model.getDeviceMsg(qrcode);
              },
              builder: (context, model, child) {
                if (model.busy) {
                  return ViewStateBusyWidget();
                }

                return new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 12, right: 12, top: 18, bottom: 14),
                      child: new Row(
                        children: [
                          Image.asset('images/azjl_scdxx.png'),
                          Container(
                              margin: const EdgeInsets.only(left: 4),
                              child: Text(
                                '杀虫灯信息',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(LocalColors.text_222222)),
                              )),
                        ],
                      ),
                    ),

                    //杀虫灯信息
                    Container(
                      padding: const EdgeInsets.only(
                          left: 12, right: 25, top: 16, bottom: 21),
                      color: Colors.white,
                      child: new Column(
                        children: [
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 25),
                                  child: new Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model?.detailData?.name,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color:
                                            Color(LocalColors.text_111111)),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 23),
                                        child: Row(
                                          children: [
                                            Text(
                                              '设  备  号:',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color(
                                                      LocalColors.text_888888)),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Container(
                                                    margin:
                                                    const EdgeInsets.only(
                                                        left: 18),
                                                    child: Text(
                                                      '${model?.detailData?.sn}',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Color(
                                                              LocalColors
                                                                  .text_444444)),
                                                    ))),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 12),
                                        child: new Row(
                                          children: [
                                            Text(
                                              '所  属  人:',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color(
                                                      LocalColors.text_888888)),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Container(
                                                    margin:
                                                    const EdgeInsets.only(
                                                        left: 18),
                                                    child: Text(
                                                      '${model?.detailData?.owner}',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Color(
                                                              LocalColors
                                                                  .text_444444)),
                                                    ))),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      RouteName.image_show,
                                      arguments: ImageUtil.getImageUrl(
                                          model?.detailData?.deviceImg));
                                },
                                child: Container(
                                    width: 106,
                                    height: 119,
                                    child: CachedNetworkImage(
                                        imageUrl: ImageUtil.getImageUrl(
                                            model?.detailData?.deviceImg))),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            child: Row(
                              children: [
                                Text(
                                  '安装时间:',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(LocalColors.text_888888)),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        margin: const EdgeInsets.only(left: 18),
                                        child: Text(
                                          '${DateUtil.formatDateMs(model?.detailData?.lampDeviceDetail?.installTime, format: 'yyyy-MM-dd')}',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color(
                                                  LocalColors.text_444444)),
                                        ))),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            child: Row(
                              children: [
                                Text(
                                  '保修截止日期:',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(LocalColors.text_888888)),
                                ),
                                Container(
                                    margin: const EdgeInsets.only(left: 18),
                                    child: Text(
                                      '${DateUtil.formatDateMs(model?.detailData?.lampDeviceDetail?.expireTime, format: 'yyyy-MM-dd')}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color:
                                          Color(LocalColors.text_444444)),
                                    )),
                                Container(
                                  margin: const EdgeInsets.only(left: 22),
                                  child: Text(
                                    model?.detailData?.lampDeviceDetail
                                        ?.expireTime >=
                                        DateUtil.getNowDateMs()
                                        ? '保修期内'
                                        : '保修期外',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Theme.of(context).accentColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //报修内容
                    Container(
                      margin: const EdgeInsets.only(
                          left: 12, right: 12, top: 18, bottom: 14),
                      child: new Row(
                        children: [
                          Image.asset('images/bxnr.png'),
                          Container(
                              margin: const EdgeInsets.only(left: 4),
                              child: Text(
                                '报修内容',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(LocalColors.text_222222)),
                              )),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 19, bottom: 30),
                      color: Colors.white,
                      //width: double.infinity,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          new Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '温馨提示：请填写真实有效信息，以便我们及时快速完成维修。',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(LocalColors.text_FFb033)),
                                ),
                              )
                            ],
                          ),

                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '报修人:',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(LocalColors.text_666666)),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(LocalColors.text_666666)),
                                  controller: _applyManController,
                                  decoration: InputDecoration(
                                      hintText: '请输入报修人',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Color(LocalColors.text_c4c5c9)),
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Divider(
                            height: 0.5,
                            color: Color(LocalColors.bg_dddddd),
                          ),

                          new Row(
                            children: [
                              Text(
                                '联系电话:',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(LocalColors.text_666666)),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(LocalColors.text_666666)),
                                  controller: _linkMobileController,
                                  decoration: InputDecoration(
                                      hintText: '请输入联系电话',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Color(LocalColors.text_c4c5c9)),
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Divider(
                            height: 0.5,
                            color: Color(LocalColors.bg_dddddd),
                          ),

                          new Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '要求处理时间:',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(LocalColors.text_666666)),
                                ),
                              ),
                              DropdownButton(
                                  items: _getDropDownItems(),
                                  value: dealTimeList[dealTimeCheckIndex],
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(LocalColors.text_333333)),
                                  underline: Container(),
                                  onChanged: (content) {
                                    _dealTimeSwitch(content);
                                  })
                            ],
                          ),

                          Divider(
                            height: 0.5,
                            color: Color(LocalColors.bg_dddddd),
                          ),

                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Text(
                              '故障原因:',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(LocalColors.text_666666)),
                            ),
                          ),

                          new Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: RadioListTile<String>(
                                    title: Text(
                                      '自身故障',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color:
                                          Color(LocalColors.text_666666)),
                                    ),
                                    value: '自身故障',
                                    groupValue: radCheckText,
                                    onChanged: (value) {
                                      radCheckType = 1;
                                      setState(() {
                                        radCheckText = value;
                                      });
                                    }),
                              ),
                              Expanded(
                                flex: 1,
                                child: RadioListTile<String>(

                                    title: Text('人为损坏',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(
                                                LocalColors.text_666666))),
                                    value: '人为损坏',
                                    groupValue: radCheckText,
                                    onChanged: (value) {
                                      radCheckType = 2;
                                      setState(() {
                                        radCheckText = value;
                                      });
                                    }),
                              ),
                            ],
                          ),
                          Divider(
                            height: 0.5,
                            color: Color(LocalColors.bg_dddddd),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 18),
                            child: Text(
                              '报修原因:',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(LocalColors.text_666666)),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 12,right: 12),
                            margin: const EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(LocalColors.text_c4c5c9),width: 0.5),
                            ),
                            child: TextField(
                              maxLines: 10,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(LocalColors.text_666666)),
                              controller: _applyReasonController,
                              decoration: InputDecoration(
                                  hintText: '请输入报修原因',
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color(LocalColors.text_c4c5c9)),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none

                              ),
                            ),
                          ),

                          //选择照片
                          Container(margin: const EdgeInsets.only(top: 17,bottom: 15),child: Text('报修照片',style: TextStyle(fontSize: 14,color: Color(LocalColors.text_666666)),)),

                          GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: applyImages.length+1,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 0.8,mainAxisSpacing: 8,crossAxisSpacing: 11),
                              itemBuilder: (context,index){
                                if(index == applyImages.length){
                                  return InkWell(
                                      onTap: (){
                                        loadAssets();
                                      },
                                      child: Image.asset('images/wx_tpsc.png',width: 96,height: 115,fit: BoxFit.cover,));
                                }else{
                                  return AssetThumb(asset: applyImages[index], width: 96, height: 115,quality: 100,);
                                }
                              })


                        ],
                      ),
                    ),

                    _buildSureWidget(model),

                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }

  _buildSureWidget(ApplyFixViewModel model){
    if(isRequest){
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 45,bottom: 60),
        child: Center(
          child:Container(
                padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 12),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: CircularProgressIndicator()
            ),
        ),
      );
    }else{
      //确认报修
     return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 45,bottom: 60),
        child: Center(
          child: InkWell(
            onTap: (){
              _applyFixSure(model);
            },
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 12),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: Text('申请报修',style: TextStyle(color: Colors.white,fontSize: 16),)
            ),
          ),
        ),
      );
    }
  }

  //选择照片
  Future<void> loadAssets() async {
    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      applyImages.addAll(resultList);
      //if (error == null) _error = 'No Error Dectected';
    });
  }

  //申请维修
  _applyFixSure(ApplyFixViewModel model)async{
    String applyMan = _applyManController.text.toString();
    String linkMobile = _linkMobileController.text.toString();
    String applyReason = _applyReasonController.text.toString();
    int time =  4-dealTimeCheckIndex;


    model.setBusy(true);
    var isSuccess = await model.applyFix(qrcode,applyMan, linkMobile, applyReason, radCheckType, time ,applyImages);
    model.setBusy(false);
    MyLogUtil.log('是否成功$isSuccess');
    if(isSuccess){
      showToast('申请维修成功');
      Navigator.of(context).pop();
    }

  }

  _dealTimeSwitch(String checkStr) {
    switch (checkStr) {
      case '一个月内':
        dealTimeCheckIndex = 0;
        break;
      case '两周内':
        dealTimeCheckIndex = 1;
        break;
      case '一周内':
        dealTimeCheckIndex = 2;
        break;
      case '三天内':
        dealTimeCheckIndex = 3;
        break;
    }
    setState(() {});
  }

  _getDropDownItems() {
    return dealTimeList
        .map<DropdownMenuItem<String>>((str) => DropdownMenuItem<String>(
              value: str,
              child: Text(str,
                  style: TextStyle(
                      fontSize: 14, color: Color(LocalColors.text_333333))),
            ))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    dealTimeList = ['一个月内', '两周内', '一周内', '三天内'];
    _applyManController = TextEditingController();
    _linkMobileController = TextEditingController();
    _applyReasonController = TextEditingController();
  }
}
