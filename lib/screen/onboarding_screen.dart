import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/main_controller.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = MainController();
    return IntroductionScreen(
      showSkipButton: true,
      showDoneButton: true,
      showNextButton: false,
      pages: listPageViewsModel,
      onDone: controller.setOnboardingStatus,
      done: const Text(
        'Masuk',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: MyEventColor.primaryColor,
        ),
      ),
      skip: const Text(
        'Lewati',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: MyEventColor.secondaryColor,
        ),
      ),
    );
  }

  final List<PageViewModel> listPageViewsModel = [
    PageViewModel(
      title: 'Kelola Event',
      body: 'Kelola event dengan mudah dalam satu aplikasi',
      image: SvgPicture.asset(
        'assets/images/onboarding_screen/event.svg',
        height: 200.0,
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: MyEventColor.primaryColor,
        ),
        bodyTextStyle: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: MyEventColor.secondaryColor,
        ),
        contentMargin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
        imagePadding: EdgeInsets.only(top: 250.0),
        imageFlex: 0,
        imageAlignment: Alignment.bottomCenter,
      ),
    ),
    PageViewModel(
      title: 'Agenda',
      body: 'Lihat kalender untuk memantau jadwal event dengan lebih mudah',
      image: SvgPicture.asset(
        'assets/images/onboarding_screen/agenda.svg',
        height: 200.0,
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: MyEventColor.primaryColor,
        ),
        bodyTextStyle: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: MyEventColor.secondaryColor,
        ),
        contentMargin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
        imagePadding: EdgeInsets.only(top: 250.0),
        imageFlex: 0,
        imageAlignment: Alignment.bottomCenter,
      ),
    ),
    PageViewModel(
      title: 'Tiket',
      body: 'Kelola tiket event dengan lebih mudah',
      image: SvgPicture.asset(
        'assets/images/onboarding_screen/ticket.svg',
        height: 200.0,
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: MyEventColor.primaryColor,
        ),
        bodyTextStyle: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: MyEventColor.secondaryColor,
        ),
        contentMargin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
        imagePadding: EdgeInsets.only(top: 250.0),
        imageFlex: 0,
        imageAlignment: Alignment.bottomCenter,
      ),
    ),
    PageViewModel(
      title: 'Dashboard',
      body: 'Pantau progress event dengan mudah dan cepat',
      image: SvgPicture.asset(
        'assets/images/onboarding_screen/dashboard.svg',
        height: 200.0,
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: MyEventColor.primaryColor,
        ),
        bodyTextStyle: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: MyEventColor.secondaryColor,
        ),
        contentMargin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
        imagePadding: EdgeInsets.only(top: 250.0),
        imageFlex: 0,
        imageAlignment: Alignment.bottomCenter,
      ),
    ),
    PageViewModel(
      title: 'Notifikasi',
      body: 'Dapatkan pengingat notifikasi secara langsung',
      image: SvgPicture.asset(
        'assets/images/onboarding_screen/notification.svg',
        height: 200.0,
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: MyEventColor.primaryColor,
        ),
        bodyTextStyle: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: MyEventColor.secondaryColor,
        ),
        contentMargin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
        imagePadding: EdgeInsets.only(top: 250.0),
        imageFlex: 0,
        imageAlignment: Alignment.bottomCenter,
      ),
    ),
    PageViewModel(
      title: '',
      body: 'Masuk untuk mengetahui lebih banyak fitur',
      image: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'My',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 55.0,
              color: MyEventColor.primaryColor,
            ),
          ),
          Text(
            'Event',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 55.0,
              color: MyEventColor.secondaryColor,
            ),
          ),
        ],
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 0.0,
          fontWeight: FontWeight.bold,
          color: MyEventColor.primaryColor,
        ),
        bodyTextStyle: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: MyEventColor.secondaryColor,
        ),
        contentMargin: EdgeInsets.fromLTRB(60.0, 0.0, 60.0, 0.0),
        imagePadding: EdgeInsets.only(top: 50.0),
        titlePadding: EdgeInsets.all(30.0),
        footerPadding: EdgeInsets.only(top: 50.0),
        imageAlignment: Alignment.bottomCenter,
      ),
    )
  ];
}
