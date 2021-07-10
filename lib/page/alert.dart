import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Alert extends StatefulWidget {
  @override
  _Alert createState() => _Alert();
}

class _Alert extends State<Alert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
          elevation: 0,
          title: Text(
            'การแจ้งเตือนเหตุฉุกเฉิน',
            style: GoogleFonts.kanit(fontSize: 20),
          ),
          centerTitle: true,
      ),
    );
  }
}