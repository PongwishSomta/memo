import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<Null> normalDialog(BuildContext context, String string) async {
  showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            title: ListTile(
              title: Text(string,
                  style: GoogleFonts.kanit(
                      color: Colors.blueAccent, fontSize: 20)),
            ),
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              )
            ],
          ));
}
