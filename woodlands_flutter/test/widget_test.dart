import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:woodlands_flutter/screens/auth/login.dart';
import 'package:woodlands_flutter/screens/auth/register.dart';
import 'package:woodlands_flutter/screens/home/homescreen.dart';
import 'package:woodlands_flutter/screens/profile/profile.dart';

void main() {
  testWidgets("should have 'Login' text on screen",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(),
    ));

    Finder title = find.text("Login");
    expect(title, findsWidgets);
  });

  testWidgets("should have username field on Login screen",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(),
    ));

    Finder title = find.byType(TextFormField);
    expect(title, findsOneWidget);
  });

  testWidgets("should have register button register screen",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: RegisterScreen(),
    ));

    Finder title = find.byType(
      TextButton,
    );
    expect(title, findsWidgets);
  });

  testWidgets("should have Tab widget in home screen",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(),
    ));

    Finder title = find.byType(
      Tab,
    );
    expect(title, findsWidgets);
  });

  testWidgets("should have register button register screen",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: RegisterScreen(),
    ));

    Finder title = find.byType(
      SizedBox,
    );
    expect(title, findsWidgets);
  });

  testWidgets("should have text button in profile screen",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Profile(),
    ));

    Finder title = find.byType(
      TextButton,
    );
    expect(title, findsNothing);
  });
}
