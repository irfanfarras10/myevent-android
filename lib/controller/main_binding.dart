import 'package:get/get.dart';
import 'package:myevent_android/controller/auth_controller.dart';
import 'package:myevent_android/controller/contact_person_controller.dart';
import 'package:myevent_android/controller/event_controller.dart';
import 'package:myevent_android/controller/event_list_controller.dart';
import 'package:myevent_android/controller/main_controller.dart';
import 'package:myevent_android/controller/navigation_controller.dart';
import 'package:myevent_android/controller/payment_controller.dart';
import 'package:myevent_android/controller/profile_controller.dart';
import 'package:myevent_android/controller/ticket_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
      fenix: true,
      tag: 'signIn',
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
      fenix: true,
      tag: 'signUp',
    );
    Get.lazyPut<NavigationController>(
      () => NavigationController(),
      fenix: true,
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
      fenix: true,
    );
    Get.lazyPut<EventController>(
      () => EventController(),
      fenix: true,
    );
    Get.lazyPut(
      () => TicketController(),
      fenix: true,
    );
    Get.lazyPut(
      () => PaymentController(),
      fenix: true,
    );
    Get.lazyPut(
      () => ContactPersonController(),
      fenix: true,
    );
    Get.lazyPut(
      () => EventListController(),
      fenix: true,
      tag: 'draft',
    );
  }
}
