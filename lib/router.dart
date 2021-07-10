import 'package:flutter/material.dart';
import 'package:memo/page/home.dart';
import 'package:memo/page/login.dart';
import 'package:memo/page/verify.dart';

final Map<String, WidgetBuilder> route = {
  '/LoginPage': (BuildContext context) => LoginPage(),
  '/Home': (BuildContext context) => Home(),
  '/Verify': (BuildContext context) => VerrifyScreen(),
};
