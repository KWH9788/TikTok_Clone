import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin {
  bool _hasPermission = false;
  bool _isPermanentlyDenied = false;
  bool _isSelfieMode = false;

  late CameraController _cameraController;
  late FlashMode _isFlashMode;

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

  void _onTapDown(TapDownDetails _) {
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  void _onTapUp() {
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();
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

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) return;
    print(cameras);
    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();

    _isFlashMode = _cameraController.value.flashMode;
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
    initPermissions();
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onTapUp();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: !_hasPermission || !_cameraController.value.isInitialized
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
                    CameraPreview(_cameraController),
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
                      bottom: 0,
                      child: GestureDetector(
                        onTapDown: _onTapDown,
                        onTapUp: (details) => _onTapUp(),
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
