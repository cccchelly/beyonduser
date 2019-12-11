import 'package:flutter/material.dart';
import 'package:beyond_user/model/worm_list_data.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:beyond_user/config/local_colors.dart';
import 'package:provider/provider.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/model/worm_pic_data.dart';
import 'package:beyond_user/view_modle/worm_pics_modle.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:beyond_user/ui/widget/refresh_header.dart';
import 'package:beyond_user/ui/widget/refresh_footer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:beyond_user/config/router_config.dart';

class WormPics extends StatefulWidget {
  @override
  WormPicsState createState() => new WormPicsState();
}

class WormPicsState extends State<WormPics> {
  String startAt = '';
  String endAt = '';

  @override
  Widget build(BuildContext context) {
    WormListData defaultData = ModalRoute.of(context).settings.arguments;

    return new Scaffold(
        body: ProviderWidget<WormPicsModel>(
      model: WormPicsModel(defaultData.imei, startAt, endAt),
      onModelReady: (model) {
        model.initData();
      },
      builder: (ctx, model, child) {

        return Column(
          children: [
            CustomAppbarWhite('虫情图像'),
            Container(
              margin: const EdgeInsets.only(
                  left: 12, right: 12, top: 21, bottom: 21),
              child: new Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        '最新虫情图像',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(LocalColors.text_222222)),
                      )),
                  InkWell(
                    onTap: () {
                      _onTimeCheckClick(context, model);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 8, bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                      ),
                      child: new Row(
                        children: [
                          Text(
                            startAt.isEmpty || endAt.isEmpty
                                ? '请选择时间'
                                : '$startAt - $endAt',
                            style: TextStyle(
                                fontSize: 13,
                                color: Color(LocalColors.text_222222)),
                          ),
                          Container(
                              margin: const EdgeInsets.only(left: 9),
                              child: Image.asset('images/cq_xljt.png')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: _buildGridDataWidget(model),
              ),
            )
          ],
        );
      },
    ));
  }

  Widget _buildGridDataWidget(WormPicsModel model){
    if(model.empty){
      return ViewStateEmptyWidget(onPressed: (){
        model.refresh();
      });
    }else{
     return SmartRefresher(
        controller: model.refreshController,
        header: MyRefreshHeader(),
        footer: MyRefreshFooter(),
        onRefresh: model.refresh,
        onLoading: model.loadMore,
        enablePullUp: true,
        enablePullDown: true,
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 11,
                childAspectRatio: 1.44),
            itemCount: model.list.length,
            itemBuilder: (ctx, index) {
              return _buildPicItem(model.list[index]);
            }),
      );
    }
  }

  Widget _buildPicItem(WormPicData item) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(RouteName.worm_pic_detail,arguments: item);
            },
            child: Stack(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: item.urlTo10P != null ? item.urlTo10P : item.url,
                  fit: BoxFit.fill,
                ),
                Positioned(
                    right: 0,
                    child: Container(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 1, bottom: 1),
                        decoration:
                            BoxDecoration(color: Theme.of(context).accentColor),
                        child: Text(
                          item?.upDown ==null ?'未知':'${item.upDown}',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ))),
              ],
            ),
          ),
        ),
        Container(
            width: 168,
            padding: const EdgeInsets.only(left: 20, top: 9, bottom: 9),
            color: Color(LocalColors.bg_f5f5f5),
            child: Text(
              '${DateUtil.formatDateMs(item.photoTime)}',
              style: TextStyle(
                  fontSize: 13, color: Color(LocalColors.text_666666)),
            )),
      ],
    );
  }

  ///选择时间
  void _onTimeCheckClick(BuildContext context, WormPicsModel model) {
    DateTime startimeTemp;
    DateTime endTimeTemp;

    showToast('请选择开始时间');

    ///先选择开始时间  再选择结束时间
    DatePicker.showDatePicker(context,
        showTitleActions: true, locale: LocaleType.zh, onConfirm: (startDate) {
      startimeTemp = startDate;

      showToast('请选择结束时间');

      ///开始时间选择完毕马上选择结束时间
      DatePicker.showDatePicker(context,
          showTitleActions: true, locale: LocaleType.zh, onConfirm: (endDate) {
        endTimeTemp = endDate;

        if (startimeTemp.isAfter(endTimeTemp)) {
          showToast('结束时间应在开始时间之后');
        } else {
          if (mounted) {
            setState(() {
              startAt = DateUtil.formatDate(startimeTemp, format: 'yyyy-MM-dd');
              endAt = DateUtil.formatDate(endTimeTemp, format: 'yyyy-MM-dd');
              model.startAt = startAt;
              model.endAt = endAt;
              model.refresh();
            });
          }
        }
      });
    });
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
