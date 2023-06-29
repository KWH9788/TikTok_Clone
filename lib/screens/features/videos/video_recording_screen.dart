import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/videos/video_preview.screen.dart';

class VideoRecordingScreen extends StatefulWidget {
  static const String routeName = "post";
  static const String routeUrl = "/upload";
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _isPermanentlyDenied = false;
  bool _isSelfieMode = false;
  bool _isInactive = false;

  late final bool _noCamera = kDebugMode && Platform.isIOS;

  late CameraController _cameraController;
  late FlashMode _isFlashMode;
  late double _maxZoom;
  double zoom = 1;

  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );
  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  Future<void> _startRecording(LongPressDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) {
      return;
    }

    await _cameraController.startVideoRecording();

    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;

    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    final video = await _cameraController.stopVideoRecording();

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: false,
        ),
      ),
    );
  }

  Future<void> _zoomCamera(LongPressMoveUpdateDetails details) async {
    if (!_cameraController.value.isInitialized) return;
    if (details.offsetFromOrigin.dy * -1 < 0) {
      zoom = 1.0;
    } else {
      zoom = 1.0 + (0.035 * details.offsetFromOrigin.dy.ceil().abs());
    }
    if (zoom > _maxZoom) {
      zoom = _maxZoom;
    }
    print(zoom);
    await _cameraController.setZoomLevel(zoom);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_noCamera) return;
    if (!_hasPermission) return;
    if (!_cameraController.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _isInactive = true;
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _isInactive = false;
      initCamera();
    }
  }

  void toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _isFlashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (video == null) return;
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) return;
    print(cameras);
    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();

    await _cameraController.prepareForVideoRecording();

    _isFlashMode = _cameraController.value.flashMode;

    _maxZoom = await _cameraController.getMaxZoomLevel();

    setState(() {});
  }

  Future<void> initPermissions() async {
    var cameraPermisson = await Permission.camera.request();
    var microphonePermisson = await Permission.microphone.request();

    _isPermanentlyDenied = cameraPermisson.isPermanentlyDenied ||
        microphonePermisson.isPermanentlyDenied;

    final cameraDenied =
        cameraPermisson.isDenied || cameraPermisson.isPermanentlyDenied;
    final microphoneDenied =
        microphonePermisson.isDenied || microphonePermisson.isPermanentlyDenied;

    if (!cameraDenied && !microphoneDenied) {
      _hasPermission = true;
      await initCamera();
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!_noCamera) {
      initPermissions();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }
    WidgetsBinding.instance.addObserver(this);
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    _buttonAnimationController.dispose();
    if (!_noCamera) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: !_hasPermission
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      !_isPermanentlyDenied
                          ? "Require camera and microphone permission"
                          : "Denied use of camera and microphone permission",
                      style: const TextStyle(
                        fontSize: Sizes.size20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gaps.v20,
                    TextButton(
                      onPressed: _isPermanentlyDenied
                          ? () async {
                              await openAppSettings();
                              initPermissions();
                            }
                          : initPermissions,
                      child: Text(
                        !_isPermanentlyDenied
                            ? "Permission request"
                            : "Go to app settings",
                      ),
                    ),
                  ],
                )
              : Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    if (!_noCamera)
                      if (_cameraController.value.isInitialized && !_isInactive)
                        CameraPreview(_cameraController),
                    const Positioned(
                      top: Sizes.size20,
                      left: Sizes.size20,
                      child: CloseButton(
                        color: Colors.white,
                      ),
                    ),
                    if (!_noCamera)
                      if (_cameraController.value.isInitialized && !_isInactive)
                        Positioned(
                          top: Sizes.size20,
                          right: Sizes.size20,
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: toggleSelfieMode,
                                icon: const Icon(Icons.cameraswitch),
                              ),
                              Gaps.v10,
                              flashButton(
                                FlashMode.off,
                                Icons.flash_off,
                              ),
                              Gaps.v10,
                              flashButton(
                                FlashMode.always,
                                Icons.flash_on,
                              ),
                              Gaps.v10,
                              flashButton(
                                FlashMode.auto,
                                Icons.flash_auto,
                              ),
                              Gaps.v10,
                              flashButton(
                                FlashMode.torch,
                                Icons.flashlight_on,
                              ),
                            ],
                          ),
                        ),
                    Positioned(
                      bottom: Sizes.size40,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                _cameraController.setZoomLevel(1);
                              },
                              icon: const Icon(
                                Icons.zoom_out,
                                color: Colors.white,
                                size: Sizes.size28,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onLongPressMoveUpdate: _zoomCamera,
                            onLongPressUp: _stopRecording,
                            onLongPressDown: _startRecording,
                            child: ScaleTransition(
                              scale: _buttonAnimation,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: Sizes.size60 + Sizes.size12,
                                    height: Sizes.size60 + Sizes.size12,
                                    child: CircularProgressIndicator(
                                      color: Colors.red.shade500,
                                      strokeWidth: Sizes.size6,
                                      value: _progressAnimationController.value,
                                    ),
                                  ),
                                  Container(
                                    width: Sizes.size60,
                                    height: Sizes.size60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed: _onPickVideoPressed,
                                icon: const FaIcon(
                                  FontAwesomeIcons.image,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  IconButton flashButton(FlashMode flashMode, IconData icon) {
    return IconButton(
      color: _isFlashMode == flashMode ? Colors.amber.shade200 : Colors.white,
      onPressed: () => setFlashMode(flashMode),
      icon: Icon(icon),
    );
  }
}
