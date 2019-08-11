import 'package:acs_app/TESTs/location.dart';
import 'package:flutter/material.dart';

void main() => runApp(TestApp());

class TestApp extends StatefulWidget {
  TestApp({Key key}) : super(key: key);

  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home: LocationSample(),
    );
  }
}