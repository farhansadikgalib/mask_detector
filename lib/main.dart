import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mask_detector/splash_screen.dart';


List<CameraDescription> cameras;


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Mask Detector',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash_Screen(),  
    );
  }
}


