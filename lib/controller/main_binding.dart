import 'package:get/get.dart';
import 'package:myevent_android/controller/agenda_controller.dart';
import 'package:myevent_android/controller/auth_controller.dart';
import 'package:myevent_android/controller/contact_person_controller.dart';
import 'package:myevent_android/controller/event_controller.dart';
import 'package:myevent_android/controller/event_detail_controller.dart';
import 'package:myevent_android/controller/event_list_controller.dart';
import 'package:myevent_android/controller/guest_controller.dart';
import 'package:myevent_android/controller/main_controller.dart';
import 'package:myevent_android/controller/participant_controller.dart';
import 'package:myevent_android/controller/payment_controller.dart';
import 'package:myevent_android/controller/profile_controller.dart';
import 'package:myevent_android/controller/sharing_file_controller.dart';
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
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
      fenix: true,
    );
    Get.lazyPut<EventController>(
      () => EventController(),
      tag: 'create',
      fenix: true,
    );
    Get.lazyPut<EventController>(
      () => EventController(),
      tag: 'edit',
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
    Get.lazyPut(
      () => EventListController(),
      fenix: true,
      tag: 'publish',
    );
    Get.lazyPut(
      () => EventListController(),
      fenix: true,
      tag: 'live',
    );
    Get.lazyPut(
      () => EventListController(),
      fenix: true,
      tag: 'pass',
    );
    Get.lazyPut(
      () => EventListController(),
      fenix: true,
      tag: 'cancel',
    );
    Get.lazyPut(
      () => AgendaController(),
      fenix: true,
    );
    Get.lazyPut(
      () => EventDetailController(),
      fenix: true,
    );
    Get.lazyPut(
      () => GuestController(),
      fenix: true,
    );
    Get.lazyPut(
      () => SharingFileController(),
      fenix: true,
    );
    Get.lazyPut(
      () => ParticipantController(),
      fenix: true,
    );
  }
}
