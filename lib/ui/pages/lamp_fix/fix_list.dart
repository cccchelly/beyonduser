import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/config/app_constans.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/config/router_config.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:beyond_user/view_modle/fix_list_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:beyond_user/ui/widget/refresh_footer.dart';
import 'package:beyond_user/ui/widget/refresh_header.dart';
import 'package:beyond_user/model/fix_list_data.dart';
import 'package:beyond_user/model/fix_list_arg_bean.dart';


class FixList extends StatefulWidget {
  @override
  FixListState createState() => new FixListState();
}

class FixListState extends State<FixList> with SingleTickerProviderStateMixin {
  List<Tab> _tabs = new List();
  TabController _tabController;
  FixListViewModel model;

  //不同入口不同初始化状态
  String defaultStatue = '';

  //可能是从设备详情来的  会带有sn  筛选出该设备的维修信息   正常从我的页面进入的没有该参数
  String fitterSn;

  //维修状态筛选条件
  int fixType;

  @override
  Widget build(BuildContext context) {
    FixListArgBean fixArgs = ModalRoute.of(context).settings.arguments;
    fitterSn = fixArgs.sn;
    fixType = fixArgs.fixType;

    _initTabs();

    return new Scaffold(
      body: _buildWidget(),
    );
  }

  _buildWidget(){
   return new Column(
      children: [
        CustomAppbarWhite('维修记录'),
        Container(
          color: Colors.white,
          width: double.infinity,
          child: TabBar(
            tabs: _tabs,
            controller: _tabController,
            //isScrollable: true,
            indicatorColor: Theme.of(context).accentColor,
            indicatorWeight: 1,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Color(LocalColors.text_222222),
            labelStyle: TextStyle(fontSize: 13),
            labelPadding: const EdgeInsets.only(left: 0),
            unselectedLabelStyle: TextStyle(fontSize: 13),
          ),
        ),

        Expanded(
          flex: 1,
          child: ProviderWidget<FixListViewModel>(
            model: FixListViewModel(),
            onModelReady: (model){
              this.model = model;
              model.statue = defaultStatue;
              model.initData();
            },
            builder: (context,model,child){
              if(model.busy){
                return ViewStateBusyWidget();
              }
              if(model.empty){
                return ViewStateEmptyWidget();
              }

              return SmartRefresher(
                controller: model.refreshController,
                header: MyRefreshHeader(),
                footer: MyRefreshFooter(),
                onRefresh: model.refresh,
                onLoading: model.loadMore,
                child: ListView.builder(
                  itemCount: model.list.length,
                  itemBuilder: (context,index){
                  return _buildListItem(model.list[index]);
                },),
              );
            },
          ),
        ),


      ],
    );
  }

  _buildListItem(FixListData fixdata){
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(RouteName.fix_detail,arguments: fixdata);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
        padding: const EdgeInsets.only(top: 12,bottom: 20,left: 14,right: 28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: new Column(
          children: [
            new Row(
              children: [
                Expanded(flex: 1,child: Container(child: Text('工单号:${fixdata?.mno}',style: TextStyle(fontSize: 13,color: Color(LocalColors.text_222222)),))),
                _getStatuesWidget(fixdata.state),
              ],
            ),

            Container(
              margin: const EdgeInsets.only(top: 17),
              child: new Row(
                children: [
                  Container(width: 80,child: Text('设备号:',style: TextStyle(fontSize: 12,color: Color(LocalColors.text_888888)),)),
                  Expanded(
                    flex: 1,
                    child: Text(fixdata.imei,style: TextStyle(fontSize: 12,color: Color(LocalColors.text_222222)),),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 17),
              child: new Row(
                children: [
                  Container(width: 80,child: Text('报修人:',style: TextStyle(fontSize: 12,color: Color(LocalColors.text_888888)),)),
                  Expanded(
                    flex: 1,
                    child: Text(fixdata.linkman,style: TextStyle(fontSize: 12,color: Color(LocalColors.text_222222)),),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 17),
              child: new Row(
                children: [
                  Container(width: 80,child: Text('联系电话:',style: TextStyle(fontSize: 12,color: Color(LocalColors.text_888888)),)),
                  Expanded(
                    flex: 1,
                    child: Text(fixdata.linkMobile,style: TextStyle(fontSize: 12,color: Color(LocalColors.text_222222)),),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 17),
              child: new Row(
                children: [
                  Container(width: 80,child: Text('故障原因:',style: TextStyle(fontSize: 12,color: Color(LocalColors.text_888888)),)),
                  Expanded(
                    flex: 1,
                    child: Text(fixdata.describe,style: TextStyle(fontSize: 12,color: Color(LocalColors.text_222222)),),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 17),
              child: new Row(
                children: [
                  Container(width: 80,child: Text('地址:',style: TextStyle(fontSize: 12,color: Color(LocalColors.text_888888)),)),
                  Expanded(
                    flex: 1,
                    child: Text(fixdata.address,style: TextStyle(fontSize: 12,color: Color(LocalColors.text_222222)),),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 17),
              child: new Row(
                children: [
                  Container(width: 80,child: Text('时间:',style: TextStyle(fontSize: 12,color: Color(LocalColors.text_888888)),)),
                  Expanded(
                    flex: 1,
                    child: Text(DateUtil.formatDateMs(fixdata.reportTime,format: 'yyyy-MM-dd'),style: TextStyle(fontSize: 12,color: Color(LocalColors.text_222222)),),
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );    
  }

  _getStatuesWidget(String statue){
    //-1.后台取消 1.待分配 2.待维修 3.协商取消 4.协商通过（开始维修） 5.待客户确认  6.待主管确认 7.结案
    String statusStr = '';
    Color textColor = Colors.white;
    switch(statue){
      case FixStatue.houtaiquxiao:
        statusStr = '已取消'; //后台取消
        textColor = Color(LocalColors.text_EF5B5B);
        break;
      case FixStatue.daifenpei:
        statusStr = '待分配';
        textColor = Color(LocalColors.text_FF9E02);
        break;
      case FixStatue.daixieshang:
        statusStr = '待协商';
        textColor = Color(LocalColors.text_EF5B5B);
        break;
      case FixStatue.xieshangquxiao:
        statusStr = '已取消';  //协商取消
        textColor = Color(LocalColors.text_EF5B5B);
        break;
      case FixStatue.daiweixiu:
        statusStr = '待维修';
        textColor = Color(LocalColors.text_2498EB);
        break;
      case FixStatue.daikehuqueren:
        statusStr = '待客户确认';  //待客户确认
        textColor = Color(LocalColors.text_EF5B5B);
        break;
      case FixStatue.daizhuguanqueren:
        statusStr = '待主管确认';  //待主管确认
        textColor = Color(LocalColors.text_EF5B5B);
        break;
      case FixStatue.jiean:
        statusStr = '结案';
        textColor = Color(LocalColors.text_666666);
        break;
    }

    return Text(statusStr,style: TextStyle(fontSize: 13,color: textColor),);
    
  }

  @override
  void initState() {
    super.initState();
  }

  _initTabs(){
    if(_tabs.length==0){
      _tabs.add(Tab(text: '全部',));
      _tabs.add(Tab(text: '维修中',));
      _tabs.add(Tab(text: '已取消',));
      _tabs.add(Tab(text: '待确认',));
      _tabs.add(Tab(text: '完成',));
    }


    if(_tabController == null){
      //入口不同 初始化不同状态
      switch(fixType){
        case 0:
          defaultStatue = '';
          break;
        case 1:
          defaultStatue = '1,2,4';
          break;
        case 2:
          defaultStatue = '-1,3';
          break;
        case 3:
          defaultStatue = '5';
          break;
        case 4:
          defaultStatue = '6,7';
          break;
      }

      _tabController = TabController(length: _tabs.length, vsync: this,initialIndex: fixType);
      _tabController.addListener((){
        if(!_tabController.indexIsChanging){
          return;
        }
        switch(_tabController.index){
          case 0:
            model.statue = '';
            break;
          case 1:
            model.statue = '1,2,4';
            break;
          case 2:
            model.statue = '-1,3';
            break;
          case 3:
            model.statue = '5';
            break;
          case 4:
            model.statue = '6,7';
            break;
        }
        model.refresh();
      });
    }

  }

}