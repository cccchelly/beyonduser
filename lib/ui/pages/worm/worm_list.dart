import 'package:flutter/material.dart';
import 'package:beyond_user/config/router_config.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/model/worm_list_data.dart';
import 'package:beyond_user/view_modle/worm_list_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:beyond_user/utlis/log_util.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:beyond_user/ui/widget/refresh_header.dart';
import 'package:beyond_user/ui/widget/refresh_footer.dart';

/*虫情监控列表*/
class WormList extends StatefulWidget {
  @override
  WormListState createState() => new WormListState();
}

class WormListState extends State<WormList> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: [
          CustomAppbarTheme('虫情监控'),
          ProviderWidget<WormListModel>(
            model: WormListModel(),
            onModelReady: (modle) {
              modle.initData();
            },
            builder: (ctx, modle, child) {
              /*if(modle.busy){
                  return Center(child: ViewStateBusyWidget());
                }*/

              return Expanded(
                flex: 1,
                child: SmartRefresher(
                  controller: modle.refreshController,
                  header: MyRefreshHeader(),
                  footer: MyRefreshFooter(),
                  onRefresh: modle.refresh,
                  onLoading: modle.loadMore,
                  enablePullUp: true,
                  enablePullDown: true,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: modle.list.length,
                      itemBuilder: (ctx, index) {
                        WormListData item = modle.list[index];
                        return _buildItem(item);
                      }),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildItem(WormListData item) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
      padding: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: new Column(
        children: [
          new Row(
            children: [
              Container(
                  width: 80,
                  child: Text(
                    '设备imei:',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Color(LocalColors.text_555555), fontSize: 13),
                  )),
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: Text(
                  '${item.imei}',
                  style: TextStyle(
                      color: Color(LocalColors.text_222222), fontSize: 13),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 13),
            child: new Row(
              children: [
                Container(
                    width: 80,
                    child: Text(
                      '设备名称:',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(LocalColors.text_555555), fontSize: 13),
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(
                    item.name == null ? '' : '${item.name}',
                    style: TextStyle(
                        color: Color(LocalColors.text_222222), fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 13),
            child: new Row(
              children: [
                Container(
                    width: 80,
                    child: Text(
                      '位置:',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(LocalColors.text_555555), fontSize: 13),
                    )),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Text(
                      item.address == null ? '' :'${item.address}',
                      style: TextStyle(
                          color: Color(LocalColors.text_222222), fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 13),
            child: new Row(
              children: [
                Container(
                    width: 80,
                    child: Text(
                      '拥有者:',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(LocalColors.text_555555), fontSize: 13),
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(
                    item.owner == null ? '':'${item.owner}',
                    style: TextStyle(
                        color: Color(LocalColors.text_222222), fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 13, bottom: 27),
            child: new Row(
              children: [
                Container(
                    width: 80,
                    child: Text(
                      '联系电话:',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(LocalColors.text_555555), fontSize: 13),
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(
                    item.phone ==null? '':'${item.phone}',
                    style: TextStyle(
                        color: Color(LocalColors.text_222222), fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          new Row(
            children: [
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      _toShowPicture(item);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5))),
                      child: Text(
                        '查看虫情图片',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      _toShowLine(item);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                          color: Color(LocalColors.bg_006F2D),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(5))),
                      child: Text(
                        '查看虫情曲线',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  void _toShowPicture(WormListData item){
    Navigator.of(context).pushNamed(RouteName.worm_pic,arguments: item);
  }

  void _toShowLine(WormListData item){
      Navigator.of(context).pushNamed(RouteName.worm_line,arguments: item);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
