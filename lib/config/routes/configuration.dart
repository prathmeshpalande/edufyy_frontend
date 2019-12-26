import 'package:fluro/fluro.dart';

import 'handlers.dart';

class Routes {
  static String login = "/";
  static String signUp = "/signup";
  static String otp = "/otp";
  static String subjects = "/subjects";
  static String subject = subjects + '/:subject';
  static String chapter = subject + "/:chapter";
  static String topic = chapter + "/:topic";

  static void configureRoutes(Router router) {
    router.define(login, handler: loginHandler);
    router.define(signUp, handler: signUpHandler);
    router.define(otp, handler: otpHandler);
    router.define(subjects, handler: subjectsHandler);
    router.define(subject, handler: subjectHandler);
    router.define(chapter, handler: chapterHandler);
    router.define(topic, handler: topicHandler);
  }
}
