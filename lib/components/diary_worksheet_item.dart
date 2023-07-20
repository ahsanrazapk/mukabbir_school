import 'package:flutter/material.dart';
import 'package:mukabbir_schools/model/workbook/subjects_detail.dart';
import 'package:mukabbir_schools/utils/styles.dart';

class DiaryWorksheetItem extends StatelessWidget {
  const DiaryWorksheetItem({
    Key? key,
    required SubjectsDetail item,
    required String date,
  })  : _item = item,
        _date = date,
        super(key: key);

  final SubjectsDetail _item;
  final String _date;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width / 3, child: Text(_item.subject, style: normalBoldTextStyle)),
            Flexible(child: Text('${_item.detail}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal))),
          ],
        ));
  }
}
