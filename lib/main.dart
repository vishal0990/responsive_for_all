import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_for_all/not_found.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'home_page.dart';
import 'todo_page.dart';

void main() {
  //Get.testMode = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive To-Do App with GetX',
      builder: (context, widget) => ResponsiveBreakpoints.builder(
        child: widget!,
        debugLog: true,
        breakpoints: [
          Breakpoint(start: 0, end: 450, name: MOBILE),
          Breakpoint(start: 451, end: 800, name: TABLET),
          Breakpoint(start: 801, end: 1920, name: DESKTOP),
          Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/todo', page: () => TodoPage()),
      ],
      unknownRoute: GetPage(name: '/notfound', page: () => NotFoundPage()),
      // 404 handling
    );
  }
}
