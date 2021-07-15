import 'package:flutter/material.dart';
import 'package:memo/main.dart';
import 'package:memo/page/activity.dart';
import 'package:memo/page/mainpage.dart';
import 'package:memo/page/login.dart';
import 'package:memo/page/verify.dart';

final Map<String, WidgetBuilder> route = {
  '/LoginPage': (BuildContext context) => LoginPage(),
  '/MainPage': (BuildContext context) => MainPage(),
  '/Verify': (BuildContext context) => VerrifyScreen(),
  '/Activity':(BuildContext context) => Activity(),
};
