import 'package:flutter/material.dart';
import 'package:lu_master/pages/competition/competition_model.dart';
import 'info.dart';

class CompetitionItemPage extends StatefulWidget {
  CompetitionItemModel item;
  CompetitionItemPage(CompetitionItemModel item) {
    this.item = item;
  }

  @override
  _CompetitionItemPageState createState() => _CompetitionItemPageState(item);
}

class _CompetitionItemPageState extends State<CompetitionItemPage> {
  CompetitionItemModel item;
  _CompetitionItemPageState(CompetitionItemModel item) {
    this.item = item;
  }

  Widget _listItemBuilder(CompetitionItemModel item) {
    return ListTile(
      title: new Text(item.name),
      leading: Image.network(item.img_url),
      subtitle: new Text(item.subject),
      onTap: () {
        // Navigator.pushNamed(context, "/competition_info",
        //     arguments: {"item": item});
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return CompetitionInfoPage(item: item);
        }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: _listItemBuilder(item),
        ),
        Divider()
      ],
    );
  }
}
