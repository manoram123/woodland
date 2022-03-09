import 'dart:async';

import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:woodlands_flutter/http/http.dart';
import 'package:woodlands_flutter/screens/auth/register.dart';
import 'package:woodlands_flutter/screens/home/homescreen.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:proximity_sensor/proximity_sensor.dart';

import '../../utilities/getColors.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? isChecked = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _isNear = false;
  late StreamSubscription<dynamic> _streamSubscription;

  Future<void> listenSensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };
    _streamSubscription = ProximitySensor.events.listen((int event) {
      print(event);
      setState(() {
        _isNear = (event > 0) ? true : false;
        if (_isNear == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterScreen(),
            ),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    listenSensor();
  }

  Widget _buildTextField({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
  }) {
    return Material(
      color: Colors.transparent,
      elevation: 2,
      child: TextField(
        cursorColor: Colors.white,
        cursorWidth: 2,
        obscureText: obscureText,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Color(getColorHexFromStr('#F9C335')),
          prefixIcon: prefixedIcon,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white54,
            fontWeight: FontWeight.bold,
            fontFamily: 'PTSans',
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _buildRemeberMe() {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value;
            });
          },
          checkColor: Colors.blue,
          fillColor: MaterialStateProperty.all(Colors.white),
        ),
        Text(
          'Remember me',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 64,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.white,
          ),
          elevation: MaterialStateProperty.all(6),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        child: Text(
          'Login',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        onPressed: () async {
          var res =
              await HttpConnectUser().loginUser(username.text, password.text);
          if (res['type'] == "success") {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
          } else if (res['type'] == 'error') {
            MotionToast.error(
              animationType: ANIMATION.fromRight,
              position: MOTION_TOAST_POSITION.top,
              description: Text("${res['message']}"),
            ).show(context);
          }
        },
      ),
    );
  }

  Widget _buildLogoButton({
    required String image,
    required VoidCallback onPressed,
  }) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: onPressed,
      child: SizedBox(
        height: 30,
        child: Image.asset(image),
      ),
    );
  }

  Widget _buildSignUpQuestion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\t have an Account? ',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterScreen()));
          },
          child: Text(
            'Sing Up',
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(getColorHexFromStr('#F9C335')),
                Color(getColorHexFromStr('#F9C335')),
                Color(getColorHexFromStr('#F9C335')),
                Color(getColorHexFromStr('#F9C335')),
                Color(getColorHexFromStr('#F9C335')),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40,
              ).copyWith(top: 60),
              child: Column(
                children: [
                  Text(
                    'Sing in',
                    style: TextStyle(
                      fontFamily: 'PT-Sans',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Username',
                      style: TextStyle(
                        fontFamily: 'PT-Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Material(
                    color: Colors.transparent,
                    elevation: 2,
                    child: TextField(
                      controller: username,
                      cursorColor: Colors.white,
                      cursorWidth: 2,
                      // obscureText: obscureText,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(getColorHexFromStr('#F9C335')),
                        prefixIcon: Icon(Icons.person),
                        hintText: "Enter your username",
                        hintStyle: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PTSans',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password',
                      style: TextStyle(
                        fontFamily: 'PT-Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Material(
                    color: Colors.transparent,
                    elevation: 2,
                    child: TextField(
                      controller: password,
                      cursorColor: Colors.white,
                      cursorWidth: 2,
                      // obscureText: obscureText,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(getColorHexFromStr('#F9C335')),
                        prefixIcon: (Icon(Icons.lock)),
                        hintText: "Enter new password",
                        hintStyle: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PTSans',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _buildForgotPasswordButton(),
                  _buildRemeberMe(),
                  SizedBox(
                    height: 15,
                  ),
                  _buildLoginButton(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '- OR -',
                    style: TextStyle(
                      fontFamily: 'PT-Sans',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  _buildSignUpQuestion()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
