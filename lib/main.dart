import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: '/details', page: () => DetailsScreen())
      ],
      title: 'Responsive Complex Design',
      builder: (context, widget) => ResponsiveBreakpoints.builder(
        debugLog: true,
        landscapePlatforms: [
          ResponsiveTargetPlatform.windows,
          ResponsiveTargetPlatform.web
        ],
        breakpoints: [
          /*      ResponsiveBreakpoint.resize(320, name: MOBILE), // Mobile
          ResponsiveBreakpoint.resize(480, name: MOBILE), // Mobile
          ResponsiveBreakpoint.resize(768, name: TABLET), // Tablet
          ResponsiveBreakpoint.autoScale(1024, name: DESKTOP), // Desktop
          ResponsiveBreakpoint.autoScale(1200, name: "LARGE_DESKTOP"), // Large desktop*/

          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
        child: widget!,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive Complex Design'),
      ),
      body: ResponsiveGrid(),
    );
  }
}

class ResponsiveGrid extends StatelessWidget {
  final List<String> items = List.generate(50, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    // Determine the number of columns based on the screen size
    int columns = ResponsiveBreakpoints.of(context).isMobile ? 2 : 6;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.0,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ResponsiveCard(item: items[index]);
        },
      ),
    );
  }
}

class ResponsiveCard extends StatelessWidget {
  final String item;

  const ResponsiveCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Center(
                child: Text(
                  item,
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Description of $item',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed('/details', arguments: '$item button pressed!');
                // Action on button press
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$item button pressed!')),
                );
              },
              child: Text('Action'),
            ),
          ),
        ],
      ),
    );
  }
}
