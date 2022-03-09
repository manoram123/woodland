import 'package:flutter/material.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:woodlands_flutter/http/http.dart';
import 'package:woodlands_flutter/screens/auth/login.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shake/shake.dart';

import '../../utilities/getColors.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool? isChecked = false;

  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

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
          'Create Account',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        onPressed: () async {
          var res = await HttpConnectUser()
              .registerUser(email.text, username.text, password.text);
          if (res['type'] == "success") {
            MotionToast.success(
              animationType: ANIMATION.fromRight,
              position: MOTION_TOAST_POSITION.top,
              description: Text("${res['message']}"),
            ).show(context);
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

  Widget _buildSignInQuestion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an Account? ',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        InkWell(
          child: Text(
            'Sing In',
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    ShakeDetector.autoStart(onPhoneShake: () {
      print("shakend");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
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
                    'Sing Up',
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
                      'Email',
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
                      controller: email,
                      cursorColor: Colors.white,
                      cursorWidth: 2,
                      // obscureText: obscureText,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(getColorHexFromStr('#F9C335')),
                        prefixIcon: Icon(Icons.email),
                        hintText: "Enter your email",
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
                  SizedBox(
                    height: 15,
                  ),
                  _buildLoginButton(),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  _buildSignInQuestion()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
