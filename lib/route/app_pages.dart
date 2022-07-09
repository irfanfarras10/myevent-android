import 'package:get/get.dart';
import 'package:myevent_android/screen/create_event_contact_person_screen/create_event_contact_person_screen.dart';
import 'package:myevent_android/screen/create_event_data_screen/create_event_data_creen.dart';
import 'package:myevent_android/screen/create_event_payment_screen/create_event_payment_screen.dart';
import 'package:myevent_android/screen/create_event_ticket_screen/create_event_ticket_screen.dart';
import 'package:myevent_android/screen/edit_event_data_screen/edit_event_data_screen.dart';
import 'package:myevent_android/screen/event_detail_screen/event_detail_screen.dart';
import 'package:myevent_android/screen/guest_screen/guest_screen.dart';
import 'package:myevent_android/screen/main_screen/main_screen.dart';
import 'package:myevent_android/screen/onboarding_screen/onboarding_screen.dart';
import 'package:myevent_android/screen/signin_screen/signin_screen.dart';
import 'package:myevent_android/screen/signup_screen/signup_screen.dart';
import 'package:myevent_android/screen/splash_screen/splash_screen.dart';
import 'package:myevent_android/screen/ticket_detail_screen/ticket_detail_screen.dart';
import 'route_name.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: RouteName.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: RouteName.onboardingScreen,
      page: () => OnboardingScreen(),
    ),
    GetPage(
      name: RouteName.signInScreen,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: RouteName.signUpScreen,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: RouteName.mainScreen,
      page: () => MainScreen(),
    ),
    GetPage(
      name: RouteName.createEventScreen,
      page: () => CreateEventDataScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: RouteName.createEventTicketScreen,
      page: () => CreateEventTicketScreen(),
    ),
    GetPage(
      name: RouteName.createEventPaymentScreen,
      page: () => CreateEventPaymentScreen(),
    ),
    GetPage(
      name: RouteName.createEventContactPersonScreen,
      page: () => CreateEventContactPersonScreen(),
    ),
    GetPage(
      name: RouteName.eventDetailScreen,
      page: () => EventDetailScreen(),
    ),
    GetPage(
      name: RouteName.agendaScreen,
      page: () => MainScreen(index: 1),
    ),
    GetPage(
      name: RouteName.profileScreen,
      page: () => MainScreen(index: 2),
    ),
    GetPage(
      name: RouteName.editEventDataScreen,
      page: () => EditEventDataScreen(),
    ),
    GetPage(
      name: RouteName.ticketDetailScreen,
      page: () => TicketDetailScreen(),
    ),
    GetPage(
      name: RouteName.guestScreen,
      page: () => GuestScreen(),
    )
  ];
}
