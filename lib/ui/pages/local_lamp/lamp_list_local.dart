import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/config/router_config.dart';
import 'package:beyond_user/model/lamp_list_model.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:beyond_user/ui/widget/refresh_footer.dart';
import 'package:beyond_user/ui/widget/refresh_header.dart';
import 'package:beyond_user/view_modle/lamp_list_local_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LampListLocal extends StatefulWidget {
  @override
  LampListLocalState createState() => new LampListLocalState();
}

class LampListLocalState extends State<LampListLocal> {
  LampListLocalViewModel lampModel;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildWidget(),
    );
  }

  _buildWidget() {
    return new Column(
      children: [
        CustomAppbarTheme('普通杀虫灯',actionWidget: InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(RouteName.lamp_map_local);
            },
            child: Image.asset('images/scd_dtzs.png')),),
        Expanded(
          flex: 1,
          child: ProviderWidget<LampListLocalViewModel>(
            model: LampListLocalViewModel(),
            onModelReady: (model) {
              lampModel = model;
              model.initData();
            },
            builder: (context, model, child) {
              if (model.busy) {
                return ViewStateBusyWidget();
              } else if (model.empty) {
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
                    itemBuilder: (context, index) {
                      return _buildListItem(context, model.list[index]);
                    }),
              );
            },
          ),
        ),
      ],
    );
  }

  _buildListItem(BuildContext context, LampListModel data) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: new Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 11, right: 11, top: 16),
            child: new Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 18),
                    child: Text(
                      '编号:',
                      style: TextStyle(
                          fontSize: 13, color: Color(LocalColors.text_555555)),
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      data?.sn,
                      style: TextStyle(
                          fontSize: 13, color: Color(LocalColors.text_212121)),
                    )),
              ],
            ),
          ),

          //这里显示的时间应该是最后通信时间，本地杀虫灯没有最后通信时间
          /*  Container(
              margin: const EdgeInsets.only(left: 11,right: 11,top: 12),
              child: new Row(
                children: [
                  Container(margin: const EdgeInsets.only(right: 18),child: Text('时间:',style: TextStyle(fontSize: 13,color: Color(LocalColors.text_555555)),)),
                  Expanded(flex: 1,child: Text(data?.time,style: TextStyle(fontSize: 13,color: Color(LocalColors.text_212121)),)),
                ],
              ),
            ),*/

          Container(
            margin: const EdgeInsets.only(left: 11, right: 11, top: 12),
            child: new Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 18),
                    child: Text(
                      '标签:',
                      style: TextStyle(
                          fontSize: 13, color: Color(LocalColors.text_555555)),
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      data?.label,
                      style: TextStyle(
                          fontSize: 13, color: Color(LocalColors.text_212121)),
                    )),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 11, right: 11, top: 12),
            child: new Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 18),
                    child: Text(
                      '地址:',
                      style: TextStyle(
                          fontSize: 13, color: Color(LocalColors.text_555555)),
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      data?.location,
                      style: TextStyle(
                          fontSize: 13, color: Color(LocalColors.text_212121)),
                    )),
              ],
            ),
          ),

          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(RouteName.lamp_install_detail,arguments: data.sn);
            },
            child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                margin: const EdgeInsets.only(top: 26),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5))
                ),
                child: Center(child: Text('安装详情',style: TextStyle(fontSize: 15,color: Colors.white),))),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
