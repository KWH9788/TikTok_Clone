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

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  bool _hasPermission = false;
  bool _isPermanentlyDenied = false;

  late final CameraController _cameraController;

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) return;

    _cameraController = CameraController(
      cameras[0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
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
              : CameraPreview(_cameraController),
        ),
      ),
    );
  }
}
