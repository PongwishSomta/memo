import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memo/page/alert.dart';
import 'package:memo/page/medical.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name, email;
  @override
  void initState() {
    super.initState();
    findname();
  }

  Future<Null> findname() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          name = event.displayName;
          email = event.email;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: showDrawer(),
        body: Center(
          child: DefaultTextStyle(
              style: GoogleFonts.kanit(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50),
                  Text(
                    'ยินดีต้อนรับ',
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(
                    'ระบบช่วยเหลือและดูแลผู้ป่วยอัลไซล์เมอร์',
                    style: TextStyle(fontSize: 15),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    color: Colors.white,
                    height: 510,
                    child: Row(children: <Widget>[
                      SizedBox(
                        width: 1,
                      ),
                      buildmenu()
                    ]),
                  ),
                ],
              )),
        ));
  }

  Widget showDrawer() {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.pinkAccent),
            accountName: Text(name == null ? 'NAME' : name),
            accountEmail: Text(email == null ? 'EMAIL' : email),
            currentAccountPicture:
                Image.asset('assets/image/memo.png', fit: BoxFit.contain),
          ),
          ListTile(
            onTap: () async {
              await Firebase.initializeApp().then((value) async {
                await FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/LoginPage', (route) => false));
              });
            },
            tileColor: Colors.red[900],
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            title: Text(
              'ออกจากระบบ',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget buildmenu() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: Column(
        children: <Widget>[
          Text(
            'เมนูการใช้งาน',
            style: GoogleFonts.kanit(color: Colors.indigo, fontSize: 30),
          ),
          SizedBox(
            height: 10,
          ),
          buttonone(),
          SizedBox(
            height: 20,
          ),
          buttontwo(),
        ],
      ),
    );
  }

  Widget buttonone() {
    return RaisedButton(
      padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
      color: Colors.pinkAccent,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(children: <Widget>[
        Icon(Icons.add_alarm_rounded, size: 90),
        Text('ระบบแจ้งเตือนการกินยา',
            style: GoogleFonts.kanit(color: Colors.white, fontSize: 20)),
      ]),
      onPressed: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Medical());
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  Widget buttontwo() {
    return RaisedButton(
      padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
      color: Colors.pinkAccent,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(children: <Widget>[
        Icon(
          Icons.notification_important,
          size: 90,
        ),
        Text('การแจ้งเตือนเหตุฉุกเฉิน',
            style: GoogleFonts.kanit(color: Colors.white, fontSize: 20)),
      ]),
      onPressed: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Alert());
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }
}
