import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mask_detector/main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  CameraImage imgCam;
  CameraController camController;
  bool isWorking = false;
  String result="";


  initCamera(){


    camController = CameraController(cameras[0],ResolutionPreset.medium);

    camController.initialize().then((value)
    {

      if(!mounted){
        return;
      }

setState(() {
  
  camController.startImageStream((imageFromStream) => {

    if(!isWorking){

      isWorking = true,
      imgCam = imageFromStream,

    }


  }
  );


});



    });





  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCamera();
  }


  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;

    
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Padding(padding: EdgeInsets.only(top: 40.0),
                child: Center(


                ),



              ),
            ),

            body: Column(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  width: size.width,
                  height: size.height-100,
                  child: Container(
                    height: size.height-100,
                    child: (!camController.value.isInitialized)
                        ? Container()
                        : AspectRatio(aspectRatio: camController.value.aspectRatio,
                      child: CameraPreview(camController),

                    ),



                  ),







                )



              ],



            ),



          ),




      ),



    );
  }
}












//
// child: AppBar(
// backgroundColor: Colors.black,
// title: Padding(padding: EdgeInsets.only(top: 40.0),
// child: Center(
//
//
//
// ),
//
//
//
// ),
// ),
//
// body: Column(
// children: [
// Positioned(
// top: 0,
// left: 0,
// width: size.width,
// height: size.height-100,
// child: (!camController.value.isInitialized)
// ? Container()
//     : AspectRatio(aspectRatio: camController.value.aspectRatio,
// child: CameraPreview(camController),
//
// ),
//
//
//
//
//
//
// )
//
//
//
// ],
//
//
//
// ),
//
//
//
// ),
//
//
//
//
// ),
//
//
//
// );
// }
// }
