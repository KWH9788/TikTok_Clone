import 'package:flutter/cupertino.dart';

class VideoConfig extends ChangeNotifier {
  bool autoMute = true;
  bool autoPlay = false;

  void toggleAutoMute() {
    autoMute = !autoMute;
    notifyListeners();
  }

  void toggleAutoPlay() {
    autoPlay = !autoPlay;
    notifyListeners();
  }
}
