import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_for_all/not_found.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'home_page.dart';

void main() {
  //Get.testMode = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, widget) => ResponsiveBreakpoints.builder(
        child: HomeScreen(),
        debugLog: true,
        breakpoints: [
          Breakpoint(start: 0, end: 450, name: MOBILE),
          Breakpoint(start: 451, end: 800, name: TABLET),
          Breakpoint(start: 801, end: 1920, name: DESKTOP),
          Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/details': (context) => NotFoundPage(),
      },
    );
  }
}
