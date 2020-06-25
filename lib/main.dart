import 'package:flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:animations/animations.dart';
import 'package:gallery_saver/gallery_saver.dart';
//import 'package:flashlight/flashlight.dart';
import 'package:flushbar/flushbar.dart';
import 'package:connectivity/connectivity.dart';
import 'RootPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

List<CameraDescription> cameras;
Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  //final cameras = await availableCameras();

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }

  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  
  runApp(MyApp());

  // Get a specific camera from the list of available cameras.
  //final firstCamera = cameras.first;
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: nav,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryColor: Color(0xff253a4b),
            accentColor: Color(0xfff23b5f)),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => TakePictureScreen(),
          '/root': (BuildContext context) => RootPage(),
        },
        //ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        //primarySwatch: Colors.blueGrey,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        //visualDensity: VisualDensity.adaptivePlatformDensity,
        //),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return TakePictureScreen();
            }
            return RootPage();
          },
        )
        //TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget
        //),
        );
  }
}

class TakePictureScreen extends StatefulWidget {
  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  String imagePath;
  File _image;
  final _scaffoldKeyCam = GlobalKey<ScaffoldState>();
  //bool _hasFlashlight = false;
  //bool _flashlightON = false;
  StreamSubscription connectivitySubscription;
  ConnectivityResult _previousResult;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      cameras[0],
      // Define the resolution to use.
      ResolutionPreset.veryHigh,
    );

    // Next, initialize the _controller. This returns a Future.
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });

    //initFlashlight();

    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        nav.currentState.push(showFlushbar(
            context: context,
            flushbar: Flushbar(
              titleText:
                  Text('No internet', style: TextStyle(color: Colors.white)),
              flushbarPosition: FlushbarPosition.TOP,
              message: 'Check your Connection',
              isDismissible: false,
              backgroundColor: Colors.red,
              flushbarStyle: FlushbarStyle.GROUNDED,
              icon: Icon(
                Icons.cloud_off,
                color: Colors.white,
              ),
              blockBackgroundInteraction: true,
              reverseAnimationCurve: Curves.easeOutBack,
            )));
      } else if (_previousResult == ConnectivityResult.none) {
        nav.currentState.pop();
        nav.currentState.push(showFlushbar(
            context: context,
            flushbar: Flushbar(
              titleText: Text('Back Online'),
              message: 'Make a search!',
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: Colors.green,
              duration: Duration(seconds: 4),
              forwardAnimationCurve: Curves.easeInSine,
            )));
      }

      _previousResult = connectivityResult;
    });
  }

  @override
  void dispose() {
    // Dispose of the _controller when the widget is disposed.
    _controller.dispose();
    connectivitySubscription.cancel();
    super.dispose();
  }

  //initFlashlight() async {
  //bool hasFlash = await Flashlight.hasFlashlight;
  //setState(() {
  //_hasFlashlight = hasFlash;
  //});
  //}

  //Future<void> lightOnOff() async {
  //_flashlightON ? await Flashlight.lightOff() : await Flashlight.lightOn();
  //setState(() {
  //_flashlightON = !_flashlightON;
  //});
  //}

  Future<void> getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      imagePath = image.path;
    });
    detectLabels();
  }

  List<DataRow> historyItems() {
    List<String> imgList = labelData.keys.toList();
    List<String> labelList = labelData.values.toList();
    List<DataRow> finalList = [];
    if (imgList.length == 0 || labelList.length == 0) {
      finalList = [];
    } else {
      for (var item = labelList.length - 1; item >= 0; item--) {
        finalList.add(DataRow(cells: <DataCell>[
          DataCell(
            Image.file(File(imgList[item])),
            onTap: () {
              showModal(
                context: context,
                configuration: FadeScaleTransitionConfiguration(
                    transitionDuration: Duration(milliseconds: 400),
                    reverseTransitionDuration: Duration(milliseconds: 200)),
                builder: (context) {
                  return Expanded(child: Image.file(File(imgList[item])));
                },
              );
            },
          ),
          DataCell(
              Text(
                labelList[item],
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => displayData(labelList[item]),
                  )))
        ]));
      }
    }
    return finalList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Wiki App'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.lock_open,
                color: const Color(0xfff23b5f),
              ),
              onPressed: () => FirebaseAuth.instance.signOut(),
            ),
            OpenContainer(
              closedColor:
                  MediaQuery.platformBrightnessOf(context) == Brightness.dark
                      ? Colors.grey[900]
                      : Color(0xff253a4b),
              openColor:
                  MediaQuery.platformBrightnessOf(context) == Brightness.light
                      ? Colors.white
                      : Colors.grey[900],
              transitionType: ContainerTransitionType.fadeThrough,
              closedBuilder: (context, action) => IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: action,
                color: Color(0xfff23b5f),
              ),
              openBuilder: (context, action) => SafeArea(
                  child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                      label: Text(
                    'Image',
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
                  )),
                  DataColumn(
                      label: Text(
                    'Label',
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
                  ))
                ],
                rows: historyItems(),
                dataRowHeight: 100.0,
              )),
            )
            //IconButton(
            //  icon: Icon(_flashlightON ? Icons.flash_on : Icons.flash_off),
            //onPressed: () => lightOnOff())
          ],
        ),
        key: _scaffoldKeyCam,
        // Wait until the _controller is initialized before displaying the
        // camera preview. Use a FutureBuilder to display a loading spinner
        // until the _controller has finished initializing.
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Center(
                  child: _cameraPreviewWidget(),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: ButtonBar(
          alignment: MainAxisAlignment.spaceAround,
          buttonPadding: EdgeInsets.symmetric(),
          children: <Widget>[
            FloatingActionButton(
              heroTag: "gallery",
              onPressed: getImage,
              child: Icon(Icons.photo_library),
            ),
            FloatingActionButton(
              heroTag: "camera",
              child: Icon(Icons.camera_alt),
              // Provide an onPressed callback.
              onPressed: _controller != null && _controller.value.isInitialized
                  ? onTakePictureButtonPressed
                  : null,
            ),
            OpenContainer(
                closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                transitionDuration: Duration(milliseconds: 300),
                tappable: false,
                closedBuilder: (context, action) {
                  return FloatingActionButton(
                    onPressed: () => action(),
                    child: Icon(Icons.search),
                  );
                },
                openBuilder: (context, action) {
                  return TextSearchPage();
                })
          ],
        ),
      ),
    );
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    _scaffoldKeyCam.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _cameraPreviewWidget() {
    if (_controller == null || !_controller.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: CameraPreview(_controller),
      );
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });
        if (filePath != null) {
          GallerySaver.saveImage(imagePath, albumName: "Wiki App");
          detectLabels().then((_) {});
        }
      }
    });
  }

  Future<String> takePicture() async {
    if (!_controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getExternalStorageDirectory();
    final String dirPath = '${extDir.path}/Pictures/Wiki App';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (_controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await _controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  Map<String, String> labelData = Map();

  Future<void> detectLabels() async {
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFilePath(imagePath);
    final ImageLabeler labelDetector = FirebaseVision.instance.imageLabeler();
    final List<ImageLabel> labels =
        await labelDetector.processImage(visionImage);

    List<String> labelTexts = new List();
    for (ImageLabel label in labels) {
      final String text = label.text;
      //final double confidence = label.confidence;

      labelTexts.add(text);
    }

    await showModal(
      configuration: FadeScaleTransitionConfiguration(
          transitionDuration: Duration(milliseconds: 500),
          reverseTransitionDuration: Duration(milliseconds: 300)),
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Labels Detected'),
          children: <Widget>[
            Container(
              width: double.maxFinite,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: labelTexts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Text(labelTexts[index]),
                        onTap: () {
                          labelData['$imagePath'] = labelTexts[index];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    displayData(labelTexts[index]),
                              ));
                        });
                  }),
            )
          ],
        );
      },
    );

    //await _addItem(downloadURL, labelTexts);
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}

Map query;
String jsonEncoded;
String jsonDecoded;

Future<String> getData(String textController) async {
  try {
    query = {"find": textController};
    jsonEncoded = json.encode(query);
    Response response =
        await Dio().post('http://167.71.226.206/request', data: jsonEncoded);
    jsonDecoded = response.data;
  } on DioError catch (e) {
    jsonDecoded = e.toString();
  }
  return jsonDecoded;
}

displayData(String textEditingController) {
  return FutureBuilder(
    future: getData(textEditingController),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Text(snapshot.data, style: GoogleFonts.roboto(fontSize: 20.0))
              ],
            ),
          ),
          appBar: AppBar(
            title: Text(textEditingController),
            centerTitle: true,
          ),
        );
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return LinearProgressIndicator(
          backgroundColor: const Color(0xff253a4b),
        );
      }
    },
  );
}

class TextSearchPage extends StatefulWidget {
  @override
  _TextSearchPageState createState() => _TextSearchPageState();
}

class _TextSearchPageState extends State<TextSearchPage> {
  final _myController = TextEditingController();
  bool _lenBool = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    // Dispose of the _controller when the widget is disposed.
    _myController.dispose();
    super.dispose();
  }

  void clearButton() {
    _myController.clear();
    setState(() {
      _lenBool = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _myController,
              decoration: InputDecoration(
                hintText: 'Enter your search query',
                suffixIcon: _lenBool
                    ? null
                    : IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => clearButton()),
                labelStyle: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: MediaQuery.platformBrightnessOf(context) ==
                          Brightness.dark
                      ? Colors.white
                      : Color(0xfff23b5f),
                ),
                labelText: "Search",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(width: 30.0)),
              ),
              style: GoogleFonts.roboto(
                  color: MediaQuery.platformBrightnessOf(context) ==
                          Brightness.dark
                      ? Colors.white
                      : Color(0xff253a4b)),
              textInputAction: TextInputAction.search,
              autofocus: true,
              onFieldSubmitted: (value) => {
                if (_myController.text.isEmpty)
                  {
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text('Search query cannot be empty!')))
                  }
                else
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                displayData(_myController.text.toString())))
                  }
              },
              onChanged: (value) {
                setState(() {
                  _myController.text.isEmpty
                      ? _lenBool = true
                      : _lenBool = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
