import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';

class Reset extends StatefulWidget {
  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  double screen;
  String email;
  final formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage());
              Navigator.of(context).push(materialPageRoute);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.blueAccent,
            )),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          'รีเซ็ทรหัสผ่าน',
          style: GoogleFonts.kanit(color: Colors.blueAccent, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [buildemail(), buildreset()],
            )),
      ),
    );
  }

  Container buildemail() {
    return Container(
      width: screen * 0.9,
      margin: EdgeInsets.only(top: 60),
      child: TextFormField(
          onChanged: (value) => email = value.trim(),
          keyboardType: TextInputType.emailAddress,
          validator: (vulue) {
            final pattern =
                r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
            final regExp = RegExp(pattern);

            if (vulue.isEmpty) {
              return 'กรุณากรอกอีเมล';
            } else if (!regExp.hasMatch(vulue)) {
              return 'อีเมลไม่ถูกต้อง';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              hintText: 'EMAIL',
              fillColor: Colors.grey[100],
              filled: true,
              prefixIcon: Icon(
                Icons.email_outlined,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: new BorderRadius.circular(30.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: new BorderRadius.circular(30.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: new BorderRadius.circular(30.0),
              ))),
    );
  }

  Container buildreset() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      width: screen * 0.9,
      height: screen * 0.12,
      child: ElevatedButton(
        onPressed: ()  {
          auth.sendPasswordResetEmail(email: email);
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.blueAccent[100],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          shadowColor: Colors.transparent,
        ),
        child: Text('รีเซ็ทรหัสผ่าน',
            style: GoogleFonts.kanit(color: Colors.white, fontSize: 20)),
      ),
    );
  }
}
