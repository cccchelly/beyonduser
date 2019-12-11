import 'package:beyond_user/config/local_colors.dart';
import 'package:beyond_user/network/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/model/fix_detail_data.dart';
import 'package:beyond_user/ui/widget/custom_appbar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oktoast/oktoast.dart';


class FixEvaluate extends StatefulWidget {
  @override
  FixEvaluateState createState() => new FixEvaluateState();
}

class FixEvaluateState extends State<FixEvaluate> {
  FixDetailData fixDetailData;
  num score = 5;
  TextEditingController _editingController;

  @override
  Widget build(BuildContext context) {
    fixDetailData = ModalRoute.of(context).settings.arguments;

    return new Scaffold(
      body: _buildEvaluate(),
    );
  }

  _buildEvaluate() {
    return SingleChildScrollView(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppbarWhite('确认维修完成'),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      '维修效果',
                      style: TextStyle(
                          fontSize: 14, color: Color(LocalColors.text_666666)),
                    )),
                RatingBar(
                  initialRating: 5,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    score = rating;
                  },
                ),
                Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      '评价',
                      style: TextStyle(
                          fontSize: 14, color: Color(LocalColors.text_666666)),
                    )),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: TextFormField(
                    maxLines: 10,
                    controller: _editingController,
                    style: TextStyle(
                        color: Color(LocalColors.text_666666), fontSize: 13),
                    decoration: InputDecoration(
                        hintText: '请输入评价',
                        hintStyle: TextStyle(
                            color: Color(LocalColors.text_c4c5c9),
                            fontSize: 13),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(LocalColors.bg_line))),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(LocalColors.bg_line))),
                        focusedErrorBorder: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
          FlatButton(
              onPressed: () {
                _evaluateSure();
              },
              color: Theme.of(context).accentColor,
              child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                  child: Text(
                    '确认完成',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )))
        ],
      ),
    );
  }

  _evaluateSure() async{
    String evaStr = _editingController.text;
    if(evaStr.isEmpty){
      showToast('请输入评价内容');
      return;
    }

    bool isSuccess = await Api.dealFixOrder(
      {
        'id' : fixDetailData.id,
        'repairType' : 'SM_COMFIRM',
        'newestMaintain' : {
          'id' : _getFixId(),
          'evaluate' : score,
          'evaluateReason' : evaStr
        }
      }
    );

    if(isSuccess){
      showToast('已确认');
      Navigator.of(context).pop();
    }

  }

  _getFixId(){
    int fixId = 0;
    fixDetailData.maintains.forEach(
        (item){
          if(item.status == 2){
            fixId = item.id;
          }
        }
    );
    return fixId;
  }

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
  }
}
