import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:memo/data.dart';
import 'package:memo/models/event.dart';
import 'package:memo/provider.dart/event_provider.dart';
import 'package:memo/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Addmed extends StatefulWidget {
  @override
  _AddmedState createState() => _AddmedState();
}

final formkey = GlobalKey<FormState>();
String medname;
String valueChoose;
String meddir;
bool pressed = false;
DateTime selectedDateTime;

List listItem = ["ก่อนอาหาร", "หลังอาหาร"];
List<String> medtag = [];
List<String> time = ['เช้า', 'กลางวัน', 'เย็น', 'ก่อนนอน'];
List<String> daytag = [];
List<String> day = [
  'ทุกวัน',
  'จันทร์',
  'อังคาร',
  'พุธ',
  'พฤหัสบดี',
  'ศุกร์',
  'เสาร์',
  'อาทิตย์'
];

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
          title: Text(
            'เพิ่มยา',
            style: GoogleFonts.kanit(color: Colors.blue[400], fontSize: 30),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: Container(
            child: Form(
                key: formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      SizedBox(
                        width: 45,
                      ),
                      Text('ชื่อยา',
                          style: GoogleFonts.kanit(
                              color: Colors.grey[800], fontSize: 20)),
                    ]),
                    namemed(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      SizedBox(width: 45),
                      Text('ลักษณะยา',
                          style: GoogleFonts.kanit(
                              color: Colors.grey[800], fontSize: 20))
                    ]),
                    dirmed(),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      SizedBox(width: 45),
                      Text('ประเภทยา',
                          style: GoogleFonts.kanit(
                              color: Colors.grey[800], fontSize: 20))
                    ]),
                    typeeat(),
                    SizedBox(height: 10),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      SizedBox(width: 45),
                      Text('เวลาที่กิน',
                          style: GoogleFonts.kanit(
                              color: Colors.grey[800], fontSize: 20))
                    ]),
                    medtime(),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      SizedBox(width: 45),
                      Text('วันที่กินยา',
                          style: GoogleFonts.kanit(
                              color: Colors.grey[800], fontSize: 20))
                    ]),
                    weekday(),
                    SizedBox(height: 10),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      SizedBox(width: 45),
                      Text('การแจ้งเตือน',
                          style: GoogleFonts.kanit(
                              color: Colors.grey[800], fontSize: 20))
                    ]),
                    notifiytime(),
                    SizedBox(height: 20),
                    addmed()
                  ],
                ))));
  }

  Widget namemed() {
    return Container(
        height: 40,
        margin: EdgeInsets.only(left: 30, right: 30),
        child: TextFormField(
          onChanged: (vulue) => medname = vulue.trim(),
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'ชื่อยา',
            contentPadding: EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          //  onFieldSubmitted: (_) => saveForm(),
          validator: (title) =>
              title != null && title.isEmpty ? 'กรุณากรอกข้อมูล' : null,
        ));
  }

  Widget dirmed() {
    return Container(
        height: 40,
        margin: EdgeInsets.only(left: 30, right: 30),
        child: TextFormField(
          onChanged: (value) => meddir = value.trim(),
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'รายละเอียดยา',
            contentPadding: EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ));
  }

  Widget typeeat() {
    return Center(
        child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 10,
            ),
            child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: DropdownButton(
                  dropdownColor: Colors.white,
                  icon: Icon(Icons.chevron_right_rounded),
                  hint: Text('เลือกประเภทยา'),
                  isExpanded: true,
                  value: valueChoose,
                  onChanged: (newValue) {
                    setState(() {
                      valueChoose = newValue;
                    });
                  },
                  items: listItem.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ))));
  }

  Widget medtime() {
    return ChipsChoice<String>.multiple(
      value: medtag,
      onChanged: (val) => setState(() => medtag = val),
      choiceItems: C2Choice.listFrom<String, String>(
        source: time,
        value: (i, v) => v,
        label: (i, v) => v,
      ),
      choiceStyle: C2ChoiceStyle(margin: EdgeInsets.only(left: 12)),
    );
  }

  Widget weekday() {
    return ChipsChoice<String>.multiple(
      value: daytag,
      onChanged: (val) => setState(() => daytag = val),
      choiceItems: C2Choice.listFrom<String, String>(
        source: day,
        value: (i, v) => v,
        label: (i, v) => v,
      ),
      choiceStyle: C2ChoiceStyle(margin: EdgeInsets.only(left: 12)),
    );
  }

  Widget notifiytime() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          pressed = true;

          DatePicker.showTimePicker(context, showTitleActions: true,
              onChanged: (date) {
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
          }, onConfirm: (date) {
            selectedDateTime = date;
          }, currentTime: DateTime.now());
        });
      },
      child: Text(
        'เลือกเวลาแจ้งเตือน',
        style: GoogleFonts.kanit(color: Colors.grey[800], fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: Colors.white,
        padding: EdgeInsets.only(left: 80, right: 80),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  Widget addmed() {
    return ElevatedButton(
        onPressed: () {
          insertmedToFireStore();
        },
        child: Text(
          'เพิ่มยา',
          style: GoogleFonts.kanit(color: Colors.white, fontSize: 25),
        ),
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            primary: Colors.blue[400],
            padding:
                EdgeInsets.only(left: 120, right: 120, top: 1, bottom: 1)));
  }

  Future<void> insertmedToFireStore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Map<String, dynamic> map = Map();
    map['namemed'] = medname;
    map['dirmed'] = meddir;
    map['medtag'] = medtag;
    map['daytag'] = daytag;
    map['time'] = selectedDateTime;

    await firestore.collection('medicine').doc().set(map).then((value) {
      print('insert success');
    });
  }
}
