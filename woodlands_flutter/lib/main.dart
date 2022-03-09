import 'package:flutter/material.dart';
import 'package:woodlands_flutter/screens/auth/login.dart';
import 'package:woodlands_flutter/screens/home/homescreen.dart';
import 'package:woodlands_flutter/utilities/parseToken.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  AwesomeNotifications().initialize(null, // icon for your app notification
      [
        NotificationChannel(
            channelKey: 'key1',
            channelName: 'Proto Coders Point',
            channelDescription: "Notification example",
            defaultColor: Color.fromARGB(255, 35, 105, 255),
            ledColor: Colors.white,
            playSound: true,
            enableLights: true,
            importance: NotificationImportance.High,
            enableVibration: true),
      ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var hastoken = null;

  getToken() async {
    var data = await parseToken();
    print("$data here");
    if (data != null) {
      setState(() {
        hastoken = true;
        // print(hastoken);
      });
    } else {
      hastoken = false;
    }
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    print(hastoken);
    return //hastoken != null
        MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            // initialRoute: hastoken == true ? "/home" : "/login",
            initialRoute: "/login",
            routes: {
          "/login": (context) => LoginScreen(),
          "/home": (context) => MyHomePage(),
        });
    // : Center(
    //     child: CircularProgressIndicator(
    //       color: Colors.yellow,
    //     ),
    //   );
  }
}
