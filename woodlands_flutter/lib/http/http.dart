import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:woodlands_flutter/constants.dart';

class HttpConnectUser {
  String baseUrl = host;
  String token = "";

  Future registerUser(String email, String username, String password) async {
    print(email);
    Map<dynamic, String> register = {
      'email': email,
      'username': username,
      'password': password
    };
    try {
      final response =
          await post(Uri.parse(baseUrl + '/register'), body: register);
      final data = jsonDecode(response.body) as Map;
      // print(data['type']);
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future loginUser(String username, String password) async {
    Map<dynamic, String> login = {'username': username, 'password': password};
    try {
      // print(username);
      // print(password);
      final response = await post(Uri.parse(host + '/login'), body: login);
      final data = jsonDecode(response.body) as Map;
      // token = data['token'];
      print(data);
      if (data['type'] == "success") {
        var token = data['token'];
        if (token.isNotEmpty) {
          print(token);
          final storage = new FlutterSecureStorage();
          await storage.write(key: 'jwt', value: token);
        }
      }
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future updateUsername(String username) async {
    var token = await FlutterSecureStorage().read(key: "jwt");
    Map infos = {"username": username, "field": "username"};
    try {
      final response = await post(Uri.parse(baseUrl + "/update-profile"),
          body: infos,
          headers: {
            'Authorization': 'Bearer ${token}',
          });
      // print("Done");
      // return "done";
      final data = jsonDecode(response.body) as Map;
      var newtoken = data['token'];
      print(data);
      final storage = new FlutterSecureStorage();
      storage.deleteAll();
      await storage.write(key: 'jwt', value: newtoken);
      return {"message": "success"};
    } catch (e) {
      print(e);
    }
  }

  Future getProducts(String category) async {
    var token = await FlutterSecureStorage().read(key: "jwt");
    try {
      final response =
          await get(Uri.parse(host + "/get-products/${category}"), headers: {
        'Authorization': 'Bearer ${token}',
      });
      final data = jsonDecode(response.body) as Map;
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future addToCart(String productId) async {
    var token = await FlutterSecureStorage().read(key: "jwt");

    try {
      final res =
          await post(Uri.parse(host + "/add-to-cart/$productId"), headers: {
        'Authorization': 'Bearer ${token}',
      });
      var result = jsonDecode(res.body) as Map;

      print(result);

      return result;
    } catch (e) {
      print(e);
    }
  }

  Future myCart() async {
    var token = await FlutterSecureStorage().read(key: "jwt");

    try {
      final res = await get(Uri.parse(host + "/my-cart"), headers: {
        'Authorization': 'Bearer ${token}',
      });
      var result = jsonDecode(res.body) as Map;
      print(result);
      return result;
    } catch (e) {
      print(e);
    }
  }
}
