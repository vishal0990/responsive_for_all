import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerControllerX extends GetxController {
  late VideoPlayerController videoPlayerController;
  var isPlaying = false.obs;
  var isVideoInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize video
    initializeVideo();
  }

  void initializeVideo() {
    // Replace with your video URL (could be a YouTube URL with some processing)
    videoPlayerController = VideoPlayerController.network(
      'https://www.w3schools.com/html/mov_bbb.mp4',
    )..initialize().then((_) {
      isVideoInitialized.value = true;
      update(); // Update the UI once the video is initialized
    });
  }

  void playPause() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }
    isPlaying.value = videoPlayerController.value.isPlaying;
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    super.onClose();
  }
}
