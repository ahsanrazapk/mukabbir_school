import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mukabbir_schools/components/back_widget.dart';
import 'package:mukabbir_schools/components/bg_image_container.dart';
import 'package:mukabbir_schools/components/notification_item.dart';
import 'package:mukabbir_schools/main.dart';
import 'package:mukabbir_schools/model/notification_model.dart';
import 'package:mukabbir_schools/model/push_notification.dart';
import 'package:mukabbir_schools/utils/app_constants.dart';
import 'package:mukabbir_schools/utils/app_strings.dart';
import 'package:mukabbir_schools/utils/shared_prefs.dart';
import 'package:mukabbir_schools/utils/styles.dart';
import 'package:mukabbir_schools/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:overlay_support/overlay_support.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late NotificationsModel _notificationsModel;
  bool isLoading = true;

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        print('here !!!');
        print('notification title: ${notification.title}');

        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      } else {
        print('inside else');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });

    _getMessagingTopic();

    _getToken().then((value) {
      print('token value: $value');

      _fetchNotifications(value).then((notification) => {
            _notificationsResponseCheck(notification),
          });
    });

    //this.loadJsonData();

    super.initState();
  }

  /*void notitficationPermission() async {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }*/

  _getMessagingTopic() async {
    await FirebaseMessaging.instance.subscribeToTopic('sendmeNotification');
  }

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/notifications.json');
    setState(() => _notificationsModel = json.decode(jsonText));
    return 'success';
  }

  Future<String> _getToken() async {
    String tokenValue = await SharedPref.read(AppConstants.token);
    return tokenValue;
  }

  _notificationsResponseCheck(NotificationsModel notification) {
    setState(() {
      _notificationsModel = notification;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading
            ? Utils.loadingWidget()
            : Stack(
                children: [
                  //BgImageContainer(image: AppConstants.defaultBg,),

                  Positioned(
                    top: -10,
                    left: 0,
                    right: 0,
                    child: Image.asset('assets/images/top_circle.png',
                        width: MediaQuery.of(context).size.width * 0.8, height: 70),
                  ),

                  Positioned(
                    top: 16,
                    left: 0,
                    right: 0,
                    child: Image.asset('assets/images/mukabbir_logo.png', width: 90, height: 90),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/images/pencils.jpg',
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),

                  _notificationsSection(context),
                ],
              ),
      ),
    );
  }

  Widget _notificationsSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        16.0,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            //back arrow
            BackWidget(),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),

            Expanded(
              child: ListView(
                shrinkWrap: true,
                primary: true,
                children: [
                  Center(
                    child: Text(AppStrings.notificationsText, style: headingTextStyle),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  _notificationsModel.type
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _notificationsModel.notifications.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (BuildContext context, int index) {
                            return NotificationItem(
                              item: _notificationsModel.notifications[index],
                            );
                          },
                        )
                      : Utils.noDataWidget(context, AppStrings.noNotifications),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<NotificationsModel> _fetchNotifications(String token) async {
    print('sending token: $token');
    final response = await http.get(Uri.parse('${AppConstants.baseURL}/student-notification'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.body.contains('false')) {
      setState(() {
        isLoading = false;
      });

      return NotificationsModel(status: 200, type: false, notifications: [], message: 'Data not found');
    }

    print('request: ${response.request?.headers.toString()}');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      setState(() {
        isLoading = false;
      });

      print('notifications response: ${jsonDecode(response.body)}');

      return NotificationsModel.fromJson(jsonDecode(response.body));

      // var jsonText = await rootBundle.loadString('assets/notifications.json');
      // return NotificationsModel.fromJson(json.decode(jsonText));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      setState(() {
        isLoading = false;
      });

      throw Exception('Failed to load notifications data ${response.body}');
    }
  }
}
