import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import './call_screen.dart';

class CameraScreen extends StatefulWidget {
  List<CameraDescription> cameras;

  CameraScreen(this.cameras);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController controller;
  double margin;
  int count = 0;
  double x1, y1, x2, y2;
  double left, right, top, bottom;
  Widget boundingbox;

  void tapped(BuildContext context, TapDownDetails details) {
    if (this.count == 1) {
      this.count += 1;
      //print('${details.globalPosition}');
      x1 = details.globalPosition.dx;
      y1 = details.globalPosition.dy;
      print("x1,y1:$x1, $y1");
    } else if (this.count == 2) {
      this.count = 0;
      //print('${details.globalPosition}');
      x2 = details.globalPosition.dx;
      y2 = details.globalPosition.dy;
      left = (x1 <= x2) ? x1 : x2;
      right = (x1 <= x2) ? x2 : x1;
      top = (y1 <= y2) ? y1 - 130 : y2 - 130;
      bottom = (y1 <= y2) ? y2 - 130 : y1 - 130;

      print("x2,y2:$x2, $y2");
      setState(() => {
            this.boundingbox = new CustomPaint(
              foregroundPainter: new MyPainter(
                  lineColor: Colors.amber,
                  left: left,
                  top: top,
                  right: right,
                  bottom: bottom),
            ),
            print("reset state")
          });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        new CameraController(widget.cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      //setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose(); //? is checking if controller is null or not
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return new Container();
    }
    return new Column(children: [
      new AspectRatio(
          aspectRatio: 1, //controller.value.aspectRatio,
          child: new GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (TapDownDetails details) => {tapped(context, details)},
              child: new Stack(children: [
                CameraPreview(controller),
                new Container(
                  color: Colors.transparent,
                  child: boundingbox,
                )
              ]))),
      Row(children: [
        Align(
            alignment: Alignment.centerLeft,
            child: new Container(
                margin: EdgeInsets.all(20.0),
                child: new FloatingActionButton(
                  backgroundColor: Theme.of(context).accentColor,
                  child: new Icon(Icons.camera_alt),
                  onPressed: () => print("take photo"),
                ))),
        Align(
            alignment: Alignment.center,
            child: new Container(
                margin: EdgeInsets.all(20.0),
                child: new FloatingActionButton(
                  backgroundColor: Theme.of(context).accentColor,
                  child: new Icon(Icons.check_box_outline_blank),
                  onPressed: () => {
                        setState(() => {
                              boundingbox =
                                  new Container(color: Colors.transparent)
                            }),
                        this.count = 1
                      },
                ))),
      ]),
    ]);
  }
}
