import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

/// CameraApp is the Main Application.
class CameraView extends StatefulWidget {
  /// Default Constructor
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? controller;
  List<CameraDescription>? _cameras;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    initMethod();
  }

  initMethod() async {
    _cameras = await availableCameras();

    controller = CameraController(_cameras![0], ResolutionPreset.max);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: CameraPreview(controller!),
    );
  }
}
