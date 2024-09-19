
import 'package:cashier_web_/homepage.dart';
import 'package:cashier_web_/splash_screen.dart';
import 'package:cashier_web_/view/screens/setting.dart';
import 'package:cashier_web_/welcome.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'POS',
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashScreen(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/welcome',
          page: () => WelcomeScreen(),
          transition: Transition.zoom,
        ),
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(name: '/setting', page: ()=> SettingsPage())
      ],
      home: SplashScreen(),
    );
  }
}