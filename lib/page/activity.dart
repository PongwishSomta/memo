import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memo/page/addactivity.dart';
import 'package:memo/page/addmed.dart';

class Activity extends StatefulWidget {
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 10,
      ),
      backgroundColor: Colors.blue[200],
      floatingActionButton: buildadd(),
    );
  }

  Widget buildadd() {
    return FloatingActionButton(
      onPressed: () {
        showBotton();
      },
      child: Icon(
        Icons.add_rounded,
        color: Colors.white,
      ),
    );
  }

  void showBotton() => showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      context: context,
      builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('เมนูเพิ่มกิจกรรม',
                  style:
                      GoogleFonts.kanit(color: Colors.grey[800], fontSize: 30)),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Addactivity()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: Colors.blue[400],
                        padding: EdgeInsets.all(10)),
                    child: Text('กิจกรรม',
                        style: GoogleFonts.kanit(
                            color: Colors.white, fontSize: 20)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => Addmed()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: Colors.red[300],
                        padding: EdgeInsets.all(10)),
                    child: Text('กินยา',
                        style: GoogleFonts.kanit(
                            color: Colors.white, fontSize: 20)),
                  ),
                ],
              ),
              SizedBox(height: 50),
            ],
          ));
}
