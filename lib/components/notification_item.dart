import 'package:flutter/material.dart';
import 'package:mukabbir_schools/model/notification_model.dart';
import 'package:mukabbir_schools/model/notifications_data.dart';
import 'package:mukabbir_schools/utils/color_constants.dart';

class NotificationItem extends StatelessWidget {

  const NotificationItem({
    Key? key,
    required NotificationsData item,
  }) : _item = item, super(key: key);

  final NotificationsData _item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.blueColor, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0),),
        ),
        child: Row(
          children: [

            Icon(Icons.notifications, color: ColorConstants.blueColor, size: 32),
            SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${_item.title}', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0,),
                  Text('${_item.description}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}