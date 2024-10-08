import 'package:flutter/material.dart';
import 'package:get/get.dart' as c;
import 'package:responsive_for_all/image_selected.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return c.GetMaterialApp(
      initialRoute: '/',
      getPages: [
        c.GetPage(name: '/', page: () => HomeScreen()),
        c.GetPage(name: '/details', page: () => DetailsScreen()),
        c.GetPage(name: '/image', page: () => ImageSelected())
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
          const Breakpoint(start: 801, end: 1500, name: DESKTOP),
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
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive Complex Design'),
      ),
      drawer: isMobile
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Drawer Header
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  // Menu Items
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      // Navigate to Home Screen
                      // Optionally add your navigation code here
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      // Navigate to Settings Screen
                      // Optionally add your navigation code here
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('About'),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      // Navigate to About Screen
                      // Optionally add your navigation code here
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      // Handle logout logic
                    },
                  ),
                ],
              ),
            )
          : null,
      body: Row(
        children: [
          if (!isMobile)
            Container(
              width: 250, // Fixed width for the side panel
              color: Colors.grey[200], // Background color for the side panel
              child: _buildSidePanel(context), // Content for the side panel
            ),
          Expanded(child: ResponsiveGrid())
        ],
      ),
    );
  }

  // Side panel content for desktop/tablet screens
  Widget _buildSidePanel(BuildContext context) {
    return Column(
      children: [
        // Optional header for the side panel
        Container(
          color: Colors.blue,
          height: 80,
          child: Center(
            child: Text(
              'Side Panel',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
        // List of menu options in the side panel
        Expanded(
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  // Handle navigation
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  // Handle navigation
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () {
                  // Handle navigation
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ResponsiveGrid extends StatelessWidget {
  final List<String> items = List.generate(50, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    // Determine the number of columns based on the screen size

    //crossAxisCount
    double responsive = ResponsiveValue(
      context,
      defaultValue: 2.0,
      conditionalValues: [
        Condition.smallerThan(name: MOBILE, value: 3.0), // Padding for mobile
        Condition.largerThan(name: TABLET, value: 4.0), // Padding for tablet
        Condition.largerThan(name: DESKTOP, value: 8.0), // Padding for desktop
      ],
    ).value;

    //crossAxisSpacing
    double crossAxisS = ResponsiveValue(
      context,
      defaultValue: 10.0,
      conditionalValues: [
        Condition.largerThan(name: MOBILE, value: 10.0), // Padding for mobile
        Condition.largerThan(name: TABLET, value: 12.0), // Padding for tablet
        Condition.largerThan(name: DESKTOP, value: 14.0), // Padding for desktop
      ],
    ).value; //mainAxisSpacing
    double mainAxisS = ResponsiveValue(
      context,
      defaultValue: 10.0,
      conditionalValues: [
        Condition.largerThan(name: MOBILE, value: 10.0), // Padding for mobile
        Condition.largerThan(name: TABLET, value: 12.0), // Padding for tablet
        Condition.largerThan(name: DESKTOP, value: 14.0), // Padding for desktop
      ],
    ).value;

    //childAspectRatio
    double aspectRatio = ResponsiveValue(
      context,
      defaultValue: 1.0,
      conditionalValues: [
        Condition.largerThan(name: MOBILE, value: 1.0), // Padding for mobile
        Condition.largerThan(name: TABLET, value: 0.8), // Padding for tablet
        Condition.largerThan(name: DESKTOP, value: 1.0), // Padding for desktop
      ],
    ).value;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: responsive.toInt(),
            crossAxisSpacing: crossAxisS,
            mainAxisSpacing: mainAxisS,
            childAspectRatio: aspectRatio,
            mainAxisExtent: 180),
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
    //responsiveSize
    double responsiveSize = ResponsiveValue(
      context,
      defaultValue: 12.0,
      conditionalValues: [
        Condition.largerThan(name: MOBILE, value: 12.0), // Padding for mobile
        Condition.largerThan(name: TABLET, value: 15.0), // Padding for tablet
        Condition.largerThan(name: DESKTOP, value: 18.0), // Padding for desktop
      ],
    ).value;
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
                  style:
                      TextStyle(color: Colors.white, fontSize: responsiveSize),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Description of $item',
              style: TextStyle(fontSize: responsiveSize),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                c.Get.toNamed('/image', arguments: '$item button pressed!');
                // Action on button press
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$item button pressed!')),
                );
              },
              child: Text(
                'Action',
                style: TextStyle(fontSize: responsiveSize),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
