import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:memo/page/login.dart';
import 'package:memo/page/verify.dart';
import 'package:memo/router.dart';
import 'package:memo/utility/dialog.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name, phone, email, password;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                MaterialPageRoute materialPageRoute = MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage());
                Navigator.of(context).pop(materialPageRoute);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.blueAccent,
              )),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text(
            'สมัครสมาชิก',
            style: GoogleFonts.kanit(color: Colors.blueAccent, fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: Center(
            child: Form(
          key: formKey,
          child: Column(children: [
            buildname(),
            buildphone(),
            buildemail(),
            buildpassword(),
            buildregister(),
          ]),
        )));
  }

  ElevatedButton buildregister() {
    return ElevatedButton(
      onPressed: () async {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          try {
            print('not empty');
            regsisterfirebase();
          } on FirebaseAuthException catch (e) {
            print(e.code);
              String massage;
              if (e.code == 'wrong-password') {
                massage = "รหัสผ่านไม่ถูกต้อง";
              } else if (e.code == 'user-not-found') {
                massage = "อีเมลไม่ถูกต้อง";
              }
              Fluttertoast.showToast(msg: massage);
          }
        }
      },
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          primary: Colors.blueAccent,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 130)),
      child: Text('สมัครสมาชิก',
          style: GoogleFonts.kanit(color: Colors.white, fontSize: 20)),
    );
  }

  Future<Null> regsisterfirebase() async {
    await Firebase.initializeApp().then((value) async {
      print('firebase connect');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        print('register success');
        await value.user.updateProfile(displayName: name).then((value) =>
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => VerrifyScreen())));
      });
    });
  }

  Container buildname() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
      child: TextFormField(
          validator: (value) {
            final pattern = r'(^[a-zA-Z0-9])';
            final regExp = RegExp(pattern);

            if (value.length < 6 || value.isEmpty) {
              return 'กรุณากรอกข้อมูล';
            } else if (!regExp.hasMatch(value)) {
              return 'ชื่อไม่ถูกต้อง';
            } else {
              return null;
            }
          },
          maxLength: 30,
          onChanged: (value) => name = value.trim(),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            hintText: 'NAME',
            fillColor: Colors.grey[200],
            filled: true,
            prefixIcon: Icon(
              Icons.account_circle_outlined,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: new BorderRadius.circular(30.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: new BorderRadius.circular(30.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: new BorderRadius.circular(30.0)),
          )),
    );
  }

  Container buildphone() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'กรุณากรอกข้อมูล';
          } else {
            return null;
          }
        },
        onChanged: (value) => phone = value.trim(),
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: 'PHONENUMBER',
          fillColor: Colors.grey[200],
          filled: true,
          prefixIcon: Icon(
            Icons.call_outlined,
            color: Colors.grey,
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: new BorderRadius.circular(30.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: new BorderRadius.circular(30.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: new BorderRadius.circular(30.0)),
        ),
      ),
    );
  }

  Container buildemail() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextFormField(
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
          onChanged: (value) => email = value.trim(),
          decoration: InputDecoration(
            hintText: 'EMAIL',
            fillColor: Colors.grey[200],
            filled: true,
            prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
            contentPadding:
                EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
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
            ),
          )),
    );
  }

  Container buildpassword() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
      child: TextFormField(
        validator: (value) {
          final pattern = r'(^[a-zA-Z0-9])';
          final regExp = RegExp(pattern);

          if (value.length < 6) {
            return 'กรุณากรอกรหัสผ่าน';
          } else if (!regExp.hasMatch(value)) {
            return 'ชื่อไม่ถูกต้อง';
          } else {
            return null;
          }
        },
        maxLength: 18,
        onChanged: (value) => password = value.trim(),
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          hintText: 'PASSWORD',
          fillColor: Colors.grey[200],
          filled: true,
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Colors.grey,
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
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
              borderRadius: new BorderRadius.circular(30.0)),
        ),
      ),
    );
  }
}
