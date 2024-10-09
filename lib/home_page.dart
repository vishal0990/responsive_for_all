import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;
import 'package:responsive_framework/responsive_framework.dart';

import 'video_player_controller.dart';

class HomeScreen extends StatelessWidget {
  // Initialize the GetX controller
  final VideoPlayerControllerX videoController =
      g.Get.put(VideoPlayerControllerX());

  @override
  Widget build(BuildContext context) {
    double fontSizeResponsive = ResponsiveValue(
      context,
      defaultValue: 2.0,
      conditionalValues: [
        Condition.smallerThan(name: MOBILE, value: 1.0), // Padding for mobile
        Condition.largerThan(name: MOBILE, value: 2.0), // Padding for mobile
        Condition.largerThan(name: TABLET, value: 4.0), // Padding for tablet
        Condition.largerThan(name: DESKTOP, value: 8.0), // Padding for desktop
      ],
    ).value;

    double playerSizeResponsive = ResponsiveValue(
      context,
      defaultValue: double.infinity,
      conditionalValues: [
        Condition.smallerThan(name: MOBILE, value: double.infinity), // Padding for mobile
        Condition.smallerThan(name: TABLET, value: 800.0), // Padding for tablet
        Condition.smallerThan(name: DESKTOP, value: 1800.0), // Padding for desktop
      ],
    ).value;
    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive YouTube App'),
      ),
      body: ResponsiveBreakpoints.builder(
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1500, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Check if the screen size is mobile or larger
            bool isMobile = constraints.maxWidth < 1000;

            return Column(
              children: [
                // Video Player Area
                g.Obx(() {
                  if (!videoController.isVideoInitialized.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return SizedBox(
                    width: playerSizeResponsive,
                    // Full width on mobile, fixed width on larger screens
                    height: isMobile ? 200 : 400,
                    // Adjust height based on screen size
                    child: Chewie(
                      controller: ChewieController(
                        videoPlayerController:
                            videoController.videoPlayerController,
                        autoPlay: false,
                        looping: false,
                      ),
                    ),
                  );
                }),

                // Video Controls (like play/pause)
                SizedBox(height: 20),
                g.Obx(() {
                  return IconButton(
                    icon: Icon(
                      videoController.isPlaying.value
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    onPressed: () => videoController.playPause(),
                  );
                }),

                // You can add additional responsive elements like video descriptions, comments, etc.
                SizedBox(height: 20),
                Text(
                  'This is a sample YouTube-like video player.',
                  style: TextStyle(fontSize: fontSizeResponsive),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
