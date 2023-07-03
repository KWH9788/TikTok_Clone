import 'package:shared_preferences/shared_preferences.dart';

class VideoPlaybackConfigRepository {
  // keys
  static const String _autoplay = "autoplay";
  static const String _muted = "muted";

  final SharedPreferences _preferences;

  VideoPlaybackConfigRepository(
    this._preferences,
  );

  // 음소거 관련 데이터를 디스크에 저장하는 메소드
  Future<void> setMuted(bool value) async {
    _preferences.setBool(_muted, value);
  }

  // 자동재생 관련 데이터를 디스크에 저장하는 메소드
  Future<void> setAutoplay(bool value) async {
    _preferences.setBool(_autoplay, value);
  }

  // 음소거 관련 데이터
  bool isMuted() {
    return _preferences.getBool(_muted) ?? false;
  }

  // 자동재생 관련 데이터
  bool isAutoplay() {
    return _preferences.getBool(_autoplay) ?? false;
  }
}
