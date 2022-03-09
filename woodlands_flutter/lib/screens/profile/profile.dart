import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:woodlands_flutter/utilities/parseToken.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:woodlands_flutter/constants.dart';

import '../../http/http.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username = "";
  String lastName = "";
  var user = null;
  final _formKey = GlobalKey<FormState>();

  File? image;

  get hostURL => null;

  getUser() async {
    var data = await parseToken();
    print(data);
    setState(() {
      user = data;
    });
  }

  Future pickImageGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => {this.image = imageTemporary, updateProfile()});
    } on PlatformException catch (e) {
      MotionToast.error(description: Text("Failed to pick image $e"))
          .show(context);
    }
  }

  Future updateProfile() async {
    var token = await FlutterSecureStorage().read(key: "jwt");
    // print("image ${image}");
    // var uri = Uri.parse(socketHost + "/send-image-message");
    // var request = new http.MultipartFile("image", stream, length)
    var request =
        http.MultipartRequest("POST", Uri.parse(host + "/upload-image"));
    request.files.add(await http.MultipartFile.fromPath("image", image!.path));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $token"
    });
    var response = await request.send();
    final res = await response.stream.bytesToString();
    final decodeRes = jsonDecode(res) as Map;
    // print("${decodeRes['token']}");
    var newtoken = decodeRes['token'];
    final storage = new FlutterSecureStorage();
    storage.deleteAll();
    await storage.write(key: 'jwt', value: newtoken);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
  }

  void logout() {
    final storage = new FlutterSecureStorage();
    storage.deleteAll();
    Navigator.pushNamed(context, "/login");
  }

  @override
  void initState() {
    super.initState();

    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: user != null
            ? SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Profile",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Stack(children: [
                            Center(
                              child: user['user']['image'] != ""
                                  ? image == null
                                      ? CircleAvatar(
                                          radius: 48,
                                          backgroundImage: NetworkImage(
                                              "$host/${user['image']}"),
                                        )
                                      : CircleAvatar(
                                          radius: 40,
                                          backgroundImage: FileImage(
                                            image!,
                                          ),
                                        )
                                  : image == null
                                      ? CircleAvatar(
                                          radius: 40,
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.yellow[700],
                                          child: Icon(
                                            Icons.person,
                                            size: 50,
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 40,
                                          backgroundImage: FileImage(
                                            image!,
                                          ),
                                        ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 300,
                              child: InkWell(
                                onTap: () {
                                  pickImageGallery();
                                  // updateProfile();
                                },
                                child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 55, 165, 255),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 20,
                                    )),
                              ),
                            )
                          ]),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  "${user['username']}",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700)),
                                ),
                                TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Stack(
                                                clipBehavior: Clip.none,
                                                children: <Widget>[
                                                  Positioned(
                                                    right: -40.0,
                                                    top: -40.0,
                                                    child: InkResponse(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: CircleAvatar(
                                                        radius: 20,
                                                        child: Icon(
                                                          Icons.close,
                                                          size: 20,
                                                        ),
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                  Text("Change Username"),
                                                  Form(
                                                    key: _formKey,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: TextFormField(
                                                            // controller: searchController,
                                                            // textAlign: TextAlign.start,
                                                            onSaved: (val) {
                                                              username = val!;
                                                            },
                                                            textAlignVertical:
                                                                TextAlignVertical
                                                                    .center,
                                                            decoration: InputDecoration(
                                                                border: InputBorder
                                                                    .none,
                                                                hintText:
                                                                    "${user['user']['username']}",
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        left:
                                                                            0),
                                                                hintStyle: GoogleFonts.poppins(
                                                                    textStyle: TextStyle(
                                                                        fontSize:
                                                                            14))),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 2,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                          color: Color.fromARGB(
                                                              255,
                                                              145,
                                                              145,
                                                              145),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: ElevatedButton(
                                                            child: Text("Save"),
                                                            onPressed:
                                                                () async {
                                                              if (_formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                _formKey
                                                                    .currentState!
                                                                    .save();
                                                                if (username !=
                                                                    "") {
                                                                  var res =
                                                                      await HttpConnectUser()
                                                                          .updateUsername(
                                                                    username,
                                                                  );
                                                                }
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                Profile()));
                                                              }
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Text("Edit")),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 218, 218, 218),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.email,
                                            size: 20,
                                          ),
                                          Text("Email",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 99, 99, 99),
                                                      fontSize: 12))),
                                        ],
                                      ),
                                      Text(
                                        "${user['user']['email']}",
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 99, 99, 99),
                                                fontSize: 15)),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_pin,
                                            size: 20,
                                          ),
                                          Text(
                                            "Address",
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 99, 99, 99),
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "New Baneshwor, Kathandu",
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 99, 99, 99),
                                                fontSize: 15)),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.phone_android,
                                            size: 20,
                                          ),
                                          Text("Phone",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 99, 99, 99),
                                                      fontSize: 12))),
                                        ],
                                      ),
                                      Text(
                                        "9889546321",
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 99, 99, 99),
                                                fontSize: 15)),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: OutlinedButton(
                                            child: Text("Logout",
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 99, 99, 99)))),
                                            onPressed: () {
                                              logout();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
