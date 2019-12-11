import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:beyond_user/provider/provider_widget.dart';
import 'package:beyond_user/view_modle/main_model.dart';
import 'package:beyond_user/provider/view_state_widget.dart';
import 'package:beyond_user/config/app_constans.dart';
import 'package:beyond_user/config/local_colors.dart';

class MainMain extends StatefulWidget {
  @override
  MainMainState createState() => new MainMainState();
}

class MainMainState extends State<MainMain> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          '比昂科技',
          style: TextStyle(fontSize: 15,color: Colors.white),
        ),
        backgroundColor: Theme.of(context).accentColor ,
        centerTitle: true,
        leading: Text(''),
      ),
      body: SingleChildScrollView(child: ProviderWidget<MainModel>(
        model: MainModel(),
        onModelReady: (model){
          model.getMainData();
        },
        builder: (context,model,child){
          if(model.busy){
            return ViewStateBusyWidget();
          }else {
           return new Column(
             children: [
               _buildBanner(model),
               _buildIntroduce(model),
               _buildCases(model),
               _buildNews(model),

             ],
           );
          }
        },
      ),),
    );
  }

  //banner
  Widget _buildBanner(MainModel model) {
    return Container(
      color: Colors.white,
      height: 160,
      child: Swiper(
        itemCount: model.bannerList.length,
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: AppConstans.PIC_BASE_URL + model.bannerList[index].imgUrl,
            fit: BoxFit.cover,
          );
        },
        autoplay: true,
        autoplayDelay: 3000,
        controller: new SwiperController(),
        pagination: new SwiperPagination(),
      ),
    );
  }

  //新品介绍
  Widget _buildIntroduce(MainModel model) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.white,
          margin: const EdgeInsets.only(top: 12, bottom: 1),
          padding: const EdgeInsets.all(12),
          child: InkWell(
            //onTap: _toProduct,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: new Text(
                    '新品推荐',
                    style: TextStyle(fontSize: 16,color: Color(LocalColors.text_111111)),
                    textAlign: TextAlign.start,
                  ),
                ),
                Center(
                    child: new Text("查看更多", style: TextStyle(fontSize: 13,color: Theme.of(context).accentColor))),
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 8),
                    child: new Image.asset("images/sy_gd.png")),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          height: 160,
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, childAspectRatio: 1.25), // 纵向比例0.8
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            //physics: NeverScrollableScrollPhysics(),
            itemCount: model.commoditList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  //_showProductDetail(index);
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: index % 2 == 0 ? 13 : 4,
                      right: index % 2 == 0 ? 4 : 13,
                      top: 4,
                      bottom: 4),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Color(LocalColors.bg_line)),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5))),
                            child: CachedNetworkImage(
                                imageUrl: AppConstans.PIC_BASE_URL +
                                    model.commoditList[index].attachements[0].uri),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 8, right: 13, top: 13, bottom: 13),
                        child: Text(
                          model.commoditList[index].name,
                          style: TextStyle(fontSize: 13,color: Color(LocalColors.text_222222)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  //新闻
  Widget _buildNews(MainModel model) {
    return new Column(
      children: [
        Container(
          color: Colors.white,
          margin: const EdgeInsets.only(top: 12, bottom: 1),
          padding: const EdgeInsets.all(12),
          child: InkWell(
            //onTap: _toProduct,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: new Text(
                    '企业动态',
                    style: TextStyle(fontSize: 16,color: Color(LocalColors.text_111111)),
                    textAlign: TextAlign.start,
                  ),
                ),
                Center(
                    child: new Text("查看更多",style: TextStyle(fontSize: 13,color: Theme.of(context).accentColor))),
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 8),
                    child: new Image.asset("images/sy_gd.png")),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 12, right: 13, top: 8),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: model.newsList.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 100,
                          padding: const EdgeInsets.only(right: 38),
                          child: new Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.newsList[index].title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14,color: Color(LocalColors.text_222222)),
                              ),
                              Expanded(flex: 1, child: Text("")),
                              Text(
                                "比昂科技",
                                textAlign: TextAlign.end,
                                style: TextStyle(fontSize: 12,color: Color(LocalColors.text_888888)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          width: 111,
                          height: 75,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: AppConstans.PIC_BASE_URL +
                                    model.newsList[index].faceImg),
                          )),
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }

  //服务案例
  Widget _buildCases(MainModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          color: Colors.white,
          margin: const EdgeInsets.only(top: 12, bottom: 1),
          padding: const EdgeInsets.all(12),
          child: InkWell(
            //onTap: _toProduct,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: new Text(
                    '服务案例',
                    style: TextStyle(fontSize: 16,color: Color(LocalColors.text_111111)),
                    textAlign: TextAlign.start,
                  ),
                ),
                Center(
                    child: new Text("查看更多", style: TextStyle(fontSize: 13,color: Theme.of(context).accentColor))),
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 8),
                    child: new Image.asset("images/sy_gd.png")),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 13, bottom: 13),
          child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: model.casusList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.18),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(LocalColors.bg_line)),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  margin: EdgeInsets.only(
                      left: index % 2 == 0 ? 13 : 5,
                      right: index % 2 == 0 ? 5 : 13,
                      bottom: 3,
                      top: 3),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          child: CachedNetworkImage(
                            imageUrl: AppConstans.PIC_BASE_URL +
                                model.casusList[index].faceImg,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 9, right: 14, top: 9, bottom: 9),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                                margin: const EdgeInsets.only(right: 4),
                                child: Image.asset("images/sy_al.png")),
                            Expanded(
                              flex: 1,
                              child: Text(
                                model.casusList[index].sketch,
                                style: TextStyle(fontSize: 13,color: Color(LocalColors.text_666666)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;


}