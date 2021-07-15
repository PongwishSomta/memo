import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memo/page/alert.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String displayName;

  @override
  void initState() {
    super.initState();
    finddisplayName();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[300],
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 90,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/image/memo.png',
                  fit: BoxFit.fill,
                  height: 80,
                ),
              ],
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: IconButton(
                    icon: Icon(
                      Icons.circle_notifications,
                      size: 50,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Alert()));
                    }),
              )
            ]),
        body: LayoutBuilder(builder: (context, constraints) {
          return Container(
              child: Column(children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('สวัสดีคุณ ',
                      textAlign: TextAlign.end,
                      style:
                          GoogleFonts.kanit(color: Colors.white, fontSize: 30)),
                  Text('$displayName',
                      textAlign: TextAlign.start,
                      style:
                          GoogleFonts.kanit(color: Colors.white, fontSize: 30)),
                  SizedBox(
                    width: 30,
                  )
                ]),
            Container(
              padding: EdgeInsets.only(right: 180),
              child: Text('ความสำเร็จประจำวัน',
                  style: GoogleFonts.kanit(color: Colors.white, fontSize: 15)),
            ),
            SizedBox(height: 70),
            Expanded(
                child: Stack(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(width: 20),
                    Text('กิจกรรมล่าสุด',
                        style: GoogleFonts.kanit(
                            color: Colors.grey[600], fontSize: 20)),
                    SizedBox(
                      width: 100,
                    ),
                  ]),
                  buildColoredCard(),
                  SizedBox(
                    height: 1,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(width: 20),
                    Text('กิจกรรมโปรด',
                        style: GoogleFonts.kanit(
                            color: Colors.grey[600], fontSize: 20)),
                  ]),
                  buildfavcard(),
                  buildfavcard(),
                  buildfavcard(),
                ],
              ),
            ]))
          ]));
        }));
  }

  Future finddisplayName() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((value) {
        displayName = value.displayName;
        setState(() {});
      });
    });
  }
}

Widget buildColoredCard() => Card(
      margin: EdgeInsets.all(10),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(color: Colors.red[400]),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ทดสอบ',
                style: GoogleFonts.kanit(color: Colors.white, fontSize: 30)),
            const SizedBox(height: 0.5),
            Row(children: <Widget>[
              Container(
                  padding: EdgeInsets.only(right: 10),
                  child:
                      Icon(Icons.calendar_today_outlined, color: Colors.white)),
              Text('กินยา 8 โมงเช้า',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.kanit(color: Colors.white, fontSize: 15))
            ]),
            Row(children: <Widget>[
              Container(
                  padding: EdgeInsets.only(right: 10),
                  child:
                      Icon(Icons.query_builder_outlined, color: Colors.white)),
              Text('30 นาที',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.kanit(color: Colors.white, fontSize: 15))
            ]),
          ],
        ),
      ),
    );

Widget buildfavcard() => Card(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.only(right: 60, top: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text('1',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kanit(color: Colors.grey, fontSize: 20)),
            ),
            Expanded(
              child: Text('ทดสอบ',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.kanit(color: Colors.grey, fontSize: 20)),
            ),
            Expanded(
                child: Text('3 ครั้ง',
                    textAlign: TextAlign.end,
                    style: GoogleFonts.kanit(color: Colors.grey, fontSize: 20)))
          ],
        ),
      ),
    );
