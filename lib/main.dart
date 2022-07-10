import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:myevent_android/controller/main_binding.dart';
import 'package:myevent_android/route/app_pages.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'event_reminder',
  'Pengingat event',
  'Channel notifikasi untuk mengingatkan event H-3 dan H-1',
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

//background notification handle
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up : ${message.messageId}');
}

void main() async {
  //foreground notification handle
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //notification on background click handle
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //set local notification implementation
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  //set foreground notification presentation
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyEventApp());
}

class MyEventApp extends StatefulWidget {
  const MyEventApp({Key? key}) : super(key: key);

  @override
  State<MyEventApp> createState() => _MyEventAppState();
}

class _MyEventAppState extends State<MyEventApp> {
  @override
  void initState() {
    super.initState();
    //listen foreground notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;
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
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('notifikasi di klik');
      // RemoteNotification notification = message.notification!;
      // AndroidNotification? android = message.notification?.android;
      // ignore: unnecessary_null_comparison
      print(message.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'Inter',
      ),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      initialBinding: MainBinding(),
      defaultTransition: Transition.rightToLeftWithFade,
      initialRoute: RouteName.splashScreen,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('id', 'ID'),
      ],
    );
  }
}
