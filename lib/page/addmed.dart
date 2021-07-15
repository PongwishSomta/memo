import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Addmed extends StatefulWidget {


  @override
  _AddmedState createState() => _AddmedState();
}

class _AddmedState extends State<Addmed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.blue[400],
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('เพิ่มยา',style: GoogleFonts.kanit(color: Colors.blue[400], fontSize: 30),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}