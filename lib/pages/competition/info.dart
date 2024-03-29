import 'package:flutter/material.dart';
import 'package:lu_master/pages/competition/competition_model.dart';
import 'add.dart';
import '../../config/constant.dart';
import '../home/service_botton.dart';
import 'work.dart';

/*
name作为appbar
主题作为一篇文章的标题
比赛条件链接形式
参赛作品按照列表形式展示，提供投票、评论、查看作者、联系作者等功能；

添加一个add按钮，跳转到编辑作品页面，编辑作品页面添加比赛注意事项链接
*/

class CompetitionInfoPage extends StatelessWidget {
  CompetitionItemModel item;
  CompetitionInfoPage({this.item});

  Widget getCondition(CompetitionItemModel item) {
    return ClipRRect(
      child: Text(item.condition),
      borderRadius: BorderRadius.circular(8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(Constant.COMPETITION_INFO_NAME),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AddWorkPage();
                }))
              },
              heroTag: 'competition_info',
            ),
            body: Container(
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Center(
                          child: Image.network(item.img_url),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          child: Text(item.name),
                        ),
                        Divider(),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          height: 40,
                          child: Text(item.subject),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          height: 40,
                          child: Text(Constant.WORK_LIST_START_DATE +
                              "：" +
                              item.start_date),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          height: 40,
                          child: Text(Constant.WORK_LIST_END_DATE +
                              "：" +
                              item.start_date),
                        ),
                        FlatButton(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                Constant.COMPETITION_CONDITION_BTN_NAME,
                                style: TextStyle(color: Colors.blue[400]),
                              ),
                            ),
                            onPressed: () {
                              showModalBottomSheet<void>(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (BuildContext context) {
                                    return Container(
                                        child: SingleChildScrollView(
                                      child: getCondition(item),
                                    ));
                                  });
                            }),
                        ServiceBotton(Constant.WORK_LIST_NAME, ''),
                        CompetitionWorkPage(item),
                      ],
                    )))));
  }
}
