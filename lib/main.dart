import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memo/models/event.dart';
import 'package:memo/provider.dart/event_provider.dart';


import 'package:memo/router.dart';
import 'package:provider/provider.dart';

String initialRoute = '/LoginPage';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        initialRoute = '/MainPage';
      }
      runApp(MyApp());
    });
  });
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EventProvider(),
      child: MaterialApp(
      routes: route,
      initialRoute: initialRoute,
    ));
  }
}
