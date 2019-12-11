import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/config/app_constans.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/config/router_config.dart';
import 'package:beyond_user/model/fix_list_arg_bean.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/utlis/image_util.dart';
import 'package:beyond_user/view_modle/lamp_install_detail_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LampInstallDetail extends StatefulWidget {
  @override
  LampInstallDetailState createState() => new LampInstallDetailState();
}

class LampInstallDetailState extends State<LampInstallDetail> {
  String lampSn;

  @override
  Widget build(BuildContext context) {
    lampSn = ModalRoute.of(context).settings.arguments;
    return new Scaffold(
      body: _buildWidget(),
    );
  }

  _buildWidget() {
    return new Column(
      children: [
        CustomAppbarWhite('安装记录'),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: ProviderWidget<LampInstallDetailViewModel>(
              model: LampInstallDetailViewModel(),
              onModelReady: (model) {
                model.getInstallDetail(lampSn);
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
                                '杀虫灯详情',
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model?.detailData?.model,
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
                                                    margin: const EdgeInsets.only(
                                                        left: 18),
                                                    child: Text(
                                                      '${model?.detailData?.sn}',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Color(LocalColors
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
                                                    margin: const EdgeInsets.only(
                                                        left: 18),
                                                    child: Text(
                                                      '${model?.detailData?.baseUser}',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Color(LocalColors
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
                                onTap: (){
                                  Navigator.of(context).pushNamed(RouteName.image_show,arguments: ImageUtil.getImageUrl(model
                                      ?.detailData?.device?.deviceImg));
                                },
                                child: Container(
                                    width: 106,
                                    height: 119,
                                    child: CachedNetworkImage(
                                        imageUrl: ImageUtil.getImageUrl(model
                                            ?.detailData?.device?.deviceImg))),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            child: Row(
                              children: [
                                Text(
                                  '安  装  人:',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(LocalColors.text_888888)),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        margin: const EdgeInsets.only(left: 18),
                                        child: Text(
                                          '${model?.detailData?.creator}',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color:
                                                  Color(LocalColors.text_444444)),
                                        ))),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            child: Row(
                              children: [
                                Text(
                                  '电        话:',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(LocalColors.text_888888)),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        margin: const EdgeInsets.only(left: 18),
                                        child: Text(
                                          '${model?.detailData?.baseUserMobile}',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color:
                                                  Color(LocalColors.text_444444)),
                                        ))),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            child: Row(
                              children: [
                                Text(
                                  '安装地址:',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(LocalColors.text_888888)),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        margin: const EdgeInsets.only(left: 18),
                                        child: Text(
                                          '${model?.detailData?.address}',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color:
                                                  Color(LocalColors.text_444444)),
                                        ))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //设备信息
                    Container(color: Colors.white,width: double.infinity,padding: const EdgeInsets.only(left: 12,top: 21,bottom: 15),child: Text('设备定位',style: TextStyle(fontSize: 14,color: Color(LocalColors.text_222222)),)),

                    _buildMap(model),

                    //安装详情图
                    Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(top:10),
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 18, bottom: 14),
                      child: new Row(
                        children: [
                          Image.asset('images/azjl_azxgt.png'),
                          Container(
                              margin: const EdgeInsets.only(left: 4),
                              child: Text(
                                '安装详情图',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(LocalColors.text_222222)),
                              )),
                        ],
                      ),
                    ),
                    
                    Container(
                      padding: const EdgeInsets.only(left: 3,right: 12,bottom: 32),
                      height: 152,
                      width: double.infinity,
                      color: Colors.white,
                      child: ListView.builder(
                        shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                      itemCount: model?.detailData?.attachments?.length,
                      itemBuilder: (context,index){
                        return Container(
                          margin: const EdgeInsets.only(left: 9),
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed(RouteName.image_show,arguments: model?.detailData?.attachments[index].url);
                            },
                            child: CachedNetworkImage(imageUrl: '${ImageUtil.getImageUrl(model?.detailData?.attachments[index].url)}',
                            width: 110,height: 120,fit: BoxFit.cover,),
                          ),
                        );
                      }),
                    ),

                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(bottom: 28),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed(RouteName.fix_list,arguments: FixListArgBean(FixListDefaultType.defaultType,lampSn));
                            },
                            child: Container(decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              border: Border.all(width: 0.5,color: Theme.of(context).accentColor)
                            ),padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 8),child: Text('查看维护信息',style: TextStyle(fontSize: 14,color: Theme.of(context).accentColor),)),
                          )
                        ],
                      ),
                    ),

                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }


  _buildMap(LampInstallDetailViewModel model){
    return Text('地图');
  }

  @override
  void initState() {
    super.initState();
  }
}
