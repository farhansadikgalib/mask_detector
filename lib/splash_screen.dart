import 'package:flutter/material.dart';
import 'package:mask_detector/home_screen.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash_Screen extends StatefulWidget {
  @override
  _Splash_ScreenState createState() => _Splash_ScreenState();
}


class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      
      seconds: 3,
      navigateAfterSeconds: HomeScreen() ,

      title: Text("Mask Detector",style: TextStyle(fontSize: 24,color: Colors.orange,fontWeight: FontWeight.w800),),
      image: Image.asset("assets/splash.png"),photoSize: 125,
      backgroundColor: Colors.white,
      loaderColor: Colors.black,
      loadingText: Text("Developed by Farhan",style: TextStyle(color: Colors.black,fontSize: 16.0),),



    );
  }
}
