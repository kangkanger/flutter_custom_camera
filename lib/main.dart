import 'package:custom_camera/custom_camera_page.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'camera',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String imagePath;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("自定义camera"),),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: (){
                requestPermission();
              },
              child: Text("自定义相机"),
            ),
            Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                child: imagePath!=null?Image.asset(imagePath,):Text("未选择图片")
            )
          ],
        ),
      ),
    );
  }

  Future requestPermission() async {
    // 申请权限
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.camera,PermissionGroup.storage]);
    // 申请结果
    PermissionStatus permission =
    await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);

    if (permission == PermissionStatus.granted) {
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new CustomCameraPage()
        ),
      ).then((v){
        if(v!=null){
          setState(() {
            imagePath = v;
          });
        }
      });
    } else {
      //权限申请被拒绝,自行处理

    }

  }
}

