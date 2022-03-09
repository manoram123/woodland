import 'package:woodlands_flutter/http/http.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("login test", () async {
    var res = await HttpConnectUser().loginUser("NAmrata", "asd123");
    expect(res, null);
  });

  test("register test", () async {
    var res =
        await HttpConnectUser().registerUser("email", "nisha", "password123");
    expect(res, {"message": "Username already taken!", "type": 'error'});
  });
}
