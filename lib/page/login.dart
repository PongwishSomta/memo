import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:memo/page/register.dart';
import 'package:memo/page/reset.dart';
import 'package:memo/utility/dialog.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double screen;
  bool statusRedye = true;
  String user, password;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Form(
                key: formKey,
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  Container(
                    margin: EdgeInsets.only(top: 140),
                    child: Image.asset(
                      'assets/image/memo.png',
                      width: screen * 0.9,
                    ),
                  ),
                  buildusername(),
                  buildpassword(),
                  buildreset(),
                  buildlogin(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'หรือ',
                    style: GoogleFonts.kanit(color: Colors.grey, fontSize: 20),
                  ),
                  buildregister()
                ]))));
  }

  Container buildusername() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      width: screen * 0.9,
      child: TextFormField(
          onChanged: (value) => user = value.trim(),
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
                Icons.account_circle_outlined,
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

  Container buildpassword() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        width: screen * 0.9,
        child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return "กรุณากรอกรหัสผ่าน";
              } else {
                return null;
              }
            },
            onChanged: (value) => password = value.trim(),
            obscureText: statusRedye,
            decoration: InputDecoration(
              hintText: 'PASSWORD',
              fillColor: Colors.grey[100],
              filled: true,
              prefixIcon: Icon(
                Icons.lock_outline_rounded,
                color: Colors.grey,
              ),
              suffixIcon: IconButton(
                icon: statusRedye
                    ? Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.grey,
                      )
                    : Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ),
                onPressed: () {
                  setState(() {
                    statusRedye = !statusRedye;
                  });
                },
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: new BorderRadius.circular(30.0),
              ),
              focusedBorder: new OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: new BorderRadius.circular(30.0),
              ),
              enabledBorder: new OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: new BorderRadius.circular(30.0)),
            )));
  }

  Container buildlogin() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: screen * 0.9,
      height: screen * 0.12,
      child: ElevatedButton(
        onPressed: () async {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();

            try {
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: user, password: password)
                  .then((value) => Navigator.pushNamedAndRemoveUntil(
                      context, '/MainPage', (route) => true));
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
          primary: Colors.blueAccent[100],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          shadowColor: Colors.transparent,
        ),
        child: Text('เข้าสู่ระบบ',
            style: GoogleFonts.kanit(color: Colors.white, fontSize: 20)),
      ),
    );
  }

  Container buildregister() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: screen * 0.9,
      height: screen * 0.12,
      child: OutlinedButton(
        onPressed: () {
          MaterialPageRoute materialPageRoute =
              MaterialPageRoute(builder: (BuildContext context) => Register());
          Navigator.of(context).push(materialPageRoute);
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            side: BorderSide(color: Colors.blueAccent[100]),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: Text('สมัครสมาชิก',
            style: GoogleFonts.kanit(color: Colors.blueAccent, fontSize: 20)),
      ),
    );
  }

//   Future<Null> login() async {
//     await Firebase.initializeApp().then((value) async {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: user, password: password)
//           .then((value) => Navigator.pushNamedAndRemoveUntil(
//               context, '/Home', (route) => false));
//     });
//   }
// }
  Row buildreset() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
        TextButton(
      child: Text('ลืมรหัสผ่าน',style: GoogleFonts.kanit(color: Colors.blueAccent, fontSize: 15)),
      onPressed: () {
        MaterialPageRoute materialPageRoute =
              MaterialPageRoute(builder: (BuildContext context) => Reset());
          Navigator.of(context).push(materialPageRoute);
      },
    )]);
  }
}
