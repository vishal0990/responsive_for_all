import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as get_;
import 'package:responsive_framework/responsive_framework.dart';

import 'image_control.dart';

class ImageSelected extends StatelessWidget {
  // Initialize GetX Controller
  final ImagePickerController controller =
      get_.Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    double padding = ResponsiveBreakpoints.of(context).isMobile ? 8.0 : 16.0;

    double responsive = ResponsiveValue(
      context,
      defaultValue: 2.0,
      conditionalValues: [
        Condition.smallerThan(name: MOBILE, value: 2.0), // Padding for mobile
        Condition.largerThan(name: MOBILE, value: 3.0), // Padding for mobile
        Condition.largerThan(name: TABLET, value: 4.0), // Padding for tablet
        Condition.largerThan(name: DESKTOP, value: 8.0), // Padding for desktop
      ],
    ).value;
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi-Image Picker'),
      ),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                if (kIsWeb) {
                  controller
                      .pickImagesWebDesktop(); // Use web or desktop picker
                } else {
                  controller.pickImagesMobile(); // Use mobile picker
                }
              },
              child: Text('Pick Images'),
            ),
            Expanded(
              child: get_.Obx(() {
                return GridView.builder(
                  padding: EdgeInsets.all(padding),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: responsive.toInt(),
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount:
                      controller.images.length + controller.webImages.length,
                  itemBuilder: (context, index) {
                    if (index < controller.images.length) {
                      // Display images for mobile/desktop (File type)
                      return !kIsWeb
                          ? Image.file(controller.images[index],
                              fit: BoxFit.cover)
                          : SizedBox.shrink(); // Web won't use Image.file
                    } else {
                      // Display images for web (XFile type)
                      return FutureBuilder<Uint8List?>(
                        future: controller
                            .webImages[index - controller.images.length]
                            .readAsBytes(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            return Image.memory(snapshot.data!,
                                fit: BoxFit.cover);
                          } else if (snapshot.hasError) {
                            return Icon(Icons.error);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      );
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
