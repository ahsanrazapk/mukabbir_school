import 'package:mukabbir_schools/model/notifications_data.dart';

/*
class NotificationModel {

  final String title;
  final String description;

  NotificationModel({required this.title, required this.description});

}*/


class NotificationsModel {
  late int status;
  late bool type;
  late List<NotificationsData> notifications;
  late String message;

  NotificationsModel(
      {required this.status, required this.type, required this.notifications, required this.message});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    if (json['notifications'] != null) {
      notifications = [];
      json['notifications'].forEach((v) {
        notifications.add(new NotificationsData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

