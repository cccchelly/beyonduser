import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/config/router_config.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:beyond_user/utlis/lamp_statue_util.dart';
import 'package:beyond_user/utlis/log_util.dart';
import 'package:beyond_user/utlis/permission_util.dart';
import 'package:beyond_user/view_modle/lamp_list_view_modle.dart';
import 'package:beyond_user/model/lamp_list_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:beyond_user/ui/widget/refresh_header.dart';
import 'package:beyond_user/ui/widget/refresh_footer.dart';

class LampListNet extends StatefulWidget {
  @override
  LampListNetState createState() => new LampListNetState();
}

class LampListNetState extends State<LampListNet> with SingleTickerProviderStateMixin {
  var _searchEdtController = TextEditingController();
  List<Tab> _tabs = new List();
  TabController _tabController;
  LampListViewModel lampModel;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildWidget(),
    );

  }

  _buildWidget(){
    return new Column(
      children: [
        CustomAppbarTheme('杀虫灯'),
        Container(
          color: Theme.of(context).accentColor,
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: new Row(
            children: [
              InkWell(onTap: (){
                _toMapShow();
              },child: Container(margin: const EdgeInsets.only(left: 20),child: Image.asset('images/scd_dtzs.png'))),
              Expanded(flex: 1,
                  child: Container(
                    height: 38,
                    margin: const EdgeInsets.only(left: 12,right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextField(
                            maxLines: 1,
                            style: TextStyle(fontSize: 12,color: Color(LocalColors.text_222222)),
                            decoration: InputDecoration(
                              hintText: '请输入设备编码',
                              hintStyle: TextStyle(fontSize: 12,color: Color(LocalColors.text_bbbbbb)),
                              border: InputBorder.none
                            ),
                            controller: _searchEdtController,
                          ),
                        ),
                        InkWell(onTap: (){
                          _searchDevice();
                        },child: Container(padding: const EdgeInsets.only(left: 8),child: Image.asset('images/scd_ss.png')))
                      ],
                    ),
              )),
              InkWell(onTap: (){
                _scanQrCode();
              },child: Container(margin: const EdgeInsets.only(right: 20),child: Image.asset('images/scd_sys.png')))

            ],
          ),
        ),

        Container(
          color: Theme.of(context).accentColor,
          width: double.infinity,
          child: TabBar(
            tabs: _tabs,
            controller: _tabController,
            //isScrollable: true,
            indicatorColor: Color(LocalColors.text_016E2D),
            indicatorWeight: 1,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Color(LocalColors.text_016E2D),
            unselectedLabelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 13),
            labelPadding: const EdgeInsets.only(left: 0),
            unselectedLabelStyle: TextStyle(fontSize: 13),
          ),
        ),

        Expanded(
          flex: 1,
          child: ProviderWidget<LampListViewModel>(
            model: LampListViewModel(),
            onModelReady: (model){
              lampModel = model;
              model.initData();
            },
            builder: (context,model,child){
              if(model.busy){
                return ViewStateBusyWidget();
              }else if(model.empty){
                return ViewStateEmptyWidget();
              }
                return SmartRefresher(
                  controller: model.refreshController,
                  enablePullUp: true,
                  enablePullDown: true,
                  header: MyRefreshHeader(),
                  footer: MyRefreshFooter(),
                  onRefresh: model.refresh,
                  onLoading: model.loadMore,
                  child: ListView.builder(
                    shrinkWrap: true,
                      itemCount: model.list.length,
                      itemBuilder: (context,index){
                      return _buildListItem(context,model.list[index]);
                  }),

                );

            },

          ),
        ),

      ],
    );
  }

  initTabData(){
    //0全部  1.正常 2.网络异常 3.待机 4.故障
    _tabs.clear();
    _tabs.add(Tab(text :'全部'));
    _tabs.add(Tab(text :'正常'));
    _tabs.add(Tab(text :'网络异常'));
    _tabs.add(Tab(text :'待机'));
    _tabs.add(Tab(text :'故障'));

   _tabController = TabController(length: _tabs.length,vsync: this,initialIndex: 0,);
   _tabController.addListener((){
     MyLogUtil.log('下标 ${_tabController.index}');
     if(!_tabController.indexIsChanging){
       return;
     }
       switch(_tabController.index){
         case 0:
           lampModel?.machineStatus = 0;
           break;
         case 1:
           lampModel?.machineStatus = 1;
           break;
         case 2:
           lampModel?.machineStatus = 3;
           break;
         case 3:
           lampModel?.machineStatus = 2;
           break;
         case 4:
           lampModel?.machineStatus = 4;
           break;
       }
       lampModel?.refresh();

   });
  }

  _buildListItem(BuildContext context,LampListModel data){
      return InkWell(
        onTap: (){
           _toLampDetail(data);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child: new Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 11,right: 11,top: 16),
                child: new Row(
                  children: [
                    Container(margin: const EdgeInsets.only(right: 18),child: Text('编号:',style: TextStyle(fontSize: 13,color: Color(LocalColors.text_555555)),)),
                    Expanded(flex: 1,child: Text(data.sn,style: TextStyle(fontSize: 13,color: Color(LocalColors.text_212121)),)),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 11,right: 11,top: 12),
                child: new Row(
                  children: [
                    Container(margin: const EdgeInsets.only(right: 18),child: Text('时间:',style: TextStyle(fontSize: 13,color: Color(LocalColors.text_555555)),)),
                    Expanded(flex: 1,child: Text(data.time,style: TextStyle(fontSize: 13,color: Color(LocalColors.text_212121)),)),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 11,right: 11,top: 12),
                child: new Row(
                  children: [
                    Container(margin: const EdgeInsets.only(right: 18),child: Text('标签:',style: TextStyle(fontSize: 13,color: Color(LocalColors.text_555555)),)),
                    Expanded(flex: 1,child: Text(data.label,style: TextStyle(fontSize: 13,color: Color(LocalColors.text_212121)),)),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 11,right: 11,top: 12),
                child: new Row(
                  children: [
                    Container(margin: const EdgeInsets.only(right: 18),child: Text('地址:',style: TextStyle(fontSize: 13,color: Color(LocalColors.text_555555)),)),
                    Expanded(flex: 1,child: Text(data.location,style: TextStyle(fontSize: 13,color: Color(LocalColors.text_212121)),)),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 11,right: 11,top: 12,bottom: 25),
                child: new Row(
                  children: [
                    Container(margin: const EdgeInsets.only(right: 18),child: Text('状态:',style: TextStyle(fontSize: 13,color: Color(LocalColors.text_555555)),)),
                    _getStatueWidget(data),
                  ],
                ),
              ),

              new Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          _toLampDetail(data);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5))),
                          child: Text(
                            '查看杀虫灯数据',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(RouteName.lamp_install_detail,arguments: data.sn);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          decoration: BoxDecoration(
                              color: Color(LocalColors.bg_006F2D),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(5))),
                          child: Text(
                            '查看杀虫灯详情',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      )),
                ],
              ),

            ],
          ),
        ),
      );
  }

  _getStatueWidget(LampListModel data){
    LampStatueUtil lampStatueUtil = new LampStatueUtil(data.status, lastTimeStr: data.time);
    String statueStr = '';
    String image = '';

    switch(lampStatueUtil.getLampStatuesEnum()){
      case LampStatueUtil.normal:
        statueStr = '正常';
        image = 'images/scd_zc.png';
        break;
      case LampStatueUtil.netError:
        statueStr = '待机';
        image = 'images/scd_dj.png';
        break;
      case LampStatueUtil.wait:
        statueStr = '网络异常';
        image = 'images/scd_wlyc.png';
        break;
      case LampStatueUtil.bad:
        statueStr = '故障';
        image = 'images/scd_gz.png';
        break;
      case LampStatueUtil.unknown:
        break;
    }

   return new Row(
     crossAxisAlignment: CrossAxisAlignment.center,
     children: [
       Container(margin: const EdgeInsets.only(right: 7),child: Text(statueStr,style: TextStyle(fontSize: 13,color: Color(LocalColors.text_212121)),)),
       Image.asset(image)
     ],
   );
  }


  //查看详情
  _toLampDetail(LampListModel data){
    if(data.did.isEmpty){
      showToast('非远程设备');
    }else{
      Navigator.of(context).pushNamed(RouteName.lamp_detail_net,arguments: data.did);
    }
  }

  //地图展示
  _toMapShow(){
    Navigator.of(context).pushNamed(RouteName.lamp_map_net);
  }

  //扫描二维码查找设备
  _scanQrCode() async{
    bool b = await PermissionUtil.requestCameraPermission();
    if(b){
      var code = await Navigator.of(context).pushNamed(RouteName.qrcode_page);
      if(code == null){
        return;
      }
      showToast('二维码：$code');
      var s = lampModel.searchLamp(code);
    }
    //MyLogUtil.log('二维码内容:$code');
  }

  //搜索设备跳转到详情
  _searchDevice(){
    if(_searchEdtController.text.isEmpty){
      showToast('请输入设备编码');
      return;
    }
    showToast('开发中');
    //var s = lampModel.searchLamp(_searchEdtController.text);

  }

  @override
  void initState() {
    initTabData();
    super.initState();
  }

}