class RouteName {
  static const splashScreen = '/';
  static const onboardingScreen = '/onboarding';
  static const signInScreen = '/auth/signin';
  static const signUpScreen = '/auth/signup';
  static const mainScreen = '/events';
  static const agendaScreen = '/agenda';
  static const profileScreen = '/profile';
  static const createEventScreen = '/events/create';
  static const createEventTicketScreen = '/events/:id/ticket/create';
  static const createEventPaymentScreen = '/events/:id/payment/create';
  static const createEventContactPersonScreen =
      '/events/:id/contact-person/create';
  static const eventDetailScreen = '/events/:id';
  static const editEventDataScreen = '/events/:id/edit';
  static const ticketDetailScreen = '/events/:id/ticket';
}
