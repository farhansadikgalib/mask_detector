import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mask_detector/main.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  CameraImage imgCam;
  CameraController camController;
  bool isWorking = false;
  String result="";

  initCamera() {
    camController = CameraController(cameras[0], ResolutionPreset.medium);

    camController.initialize().then((value) {
      if (!mounted) {
        return;
      }

      setState(() {
        camController.startImageStream((imageFromStream) => {
              if (!isWorking)
                {
                  isWorking = true,
                  imgCam = imageFromStream,
                  runModelOnFrame(),
                }
            });
      });
    });
  }


  loadModel()async{

    await Tflite.loadModel(model: "assets/model.tflite",labels: "assets/labels.txt");

  }
  runModelOnFrame()async{
if(imgCam != null){
  var recognition = await Tflite.runModelOnFrame(bytesList: imgCam.planes.map((plane) {

    return plane.bytes;


  }).toList(),
    imageHeight: imgCam.height,
    imageWidth: imgCam.width,
    imageMean: 127.5,
    imageStd: 127.5,
    rotation: 90,
    numResults: 1,
    threshold: 0.1,
    asynch: true,

  );
  result = "";

  recognition.forEach((response) {

    result += response["label"] + "\n";

  });

  setState(() {
    isWorking = false;
  });

}


  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCamera();
    loadModel();
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
                  child: Text(result,style: TextStyle(backgroundColor: Colors.black45,fontSize: 32,color: Colors.orange),
                    textAlign: TextAlign.center,
                  ),
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









