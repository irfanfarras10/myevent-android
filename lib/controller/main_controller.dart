import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:myevent_android/util/jwt_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthState {
  init,
  authorized,
  unauthorized,
}

class MainController extends GetxController {
  String? initRoute;

  @override
  void onInit() async {
    final pref = await SharedPreferences.getInstance();
    final authState = await getAuthState;
    if (authState == AuthState.init) {
      initRoute = RouteName.onboardingScreen;
    } else if (authState == AuthState.unauthorized) {
      initRoute = RouteName.signInScreen;
    } else {
      String eventOrganizerId = JwtUtil().parseJwt(
        pref.getString('myevent.auth.token')!,
      )['sub'];
      pref.setString('myevent.auth.token.subject', eventOrganizerId);

      //subscribe topic for notification
      FirebaseMessaging.instance.subscribeToTopic(eventOrganizerId);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        const AndroidNotificationChannel channel = AndroidNotificationChannel(
          'event_reminder',
          'Pengingat event',
          'Channel notifikasi untuk mengingatkan event H-3 dan H-1',
          importance: Importance.high,
          playSound: true,
        );
        RemoteNotification notification = message.notification!;
        AndroidNotification? android = message.notification?.android;
        final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();

        Future onClickNotification(String? payload) async {
          Get.offAllNamed(
            RouteName.eventDetailScreen.replaceAll(':id', payload!),
          );
        }

        var androidSettings =
            AndroidInitializationSettings('@mipmap/ic_launcher');
        var initSetttings = InitializationSettings(
          android: androidSettings,
        );

        flutterLocalNotificationsPlugin.initialize(
          initSetttings,
          onSelectNotification: onClickNotification,
        );

        // ignore: unnecessary_null_comparison
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                playSound: true,
                icon: '@mipmap/ic_launcher',
                styleInformation: BigTextStyleInformation(notification.body!),
              ),
            ),
            payload: message.data['eventId'],
          );
        }
      });

      initRoute = RouteName.mainScreen;
    }
    Get.offAllNamed(initRoute!);
    super.onInit();
  }

  Future<AuthState> get getAuthState async {
    final pref = await SharedPreferences.getInstance();
    if (pref.getBool('myevent.init') == null) {
      return AuthState.init;
    }
    if (pref.getString('myevent.auth.token') == null) {
      return AuthState.unauthorized;
    }
    return AuthState.authorized;
  }

  void setOnboardingStatus() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool('myevent.init', false);
    Get.offAllNamed(RouteName.signInScreen);
  }
}
