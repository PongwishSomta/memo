import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:memo/models/event.dart';
import 'package:memo/provider.dart/event_provider.dart';
import 'package:memo/utils.dart';
import 'package:provider/provider.dart';
import 'package:memo/models/activity_model.dart';

class Addactivity extends StatefulWidget {
  final Event event;

  const Addactivity({
    Key key,
    this.event,
  }) : super(key: key);

  @override
  _AddactivityState createState() => _AddactivityState();
}

class _AddactivityState extends State<Addactivity> {
  final titleController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  String actname, actdir;
  double screen;
  DateTime fromdate;
  DateTime toDate;
  DateTime date;

  String type;
  List<String> options = [
    'ออกกำลังกาย',
    'กิจวัตร',
    'งานอดิเรก',
    'อื่นๆ',
  ];
  List<String> tags = [];
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

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromdate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 1));
    }
  }

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
            'เพิ่มกิจกรรม',
            style: GoogleFonts.kanit(color: Colors.blue[400], fontSize: 30),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return Form(
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
                    Text('ชื่อกิจกรรม',
                        style: GoogleFonts.kanit(
                            color: Colors.grey[800], fontSize: 20)),
                  ]),
                  nameact(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(width: 45),
                    Text('ประเภท',
                        style: GoogleFonts.kanit(
                            color: Colors.grey[800], fontSize: 20))
                  ]),
                  choiseday(),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(width: 45),
                    Text('รายละเอียดกิจกรรม',
                        style: GoogleFonts.kanit(
                            color: Colors.grey[800], fontSize: 20))
                  ]),
                  diract(),
                  SizedBox(height: 10),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(width: 45),
                    Text('วันและเวลา',
                        style: GoogleFonts.kanit(
                            color: Colors.grey[800], fontSize: 20))
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(width: 60),
                    Text('วัน',
                        style: GoogleFonts.kanit(
                            color: Colors.grey[800], fontSize: 15))
                  ]),
                  weekday(),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(width: 60),
                    Text('เวลา',
                        style: GoogleFonts.kanit(
                            color: Colors.grey[800], fontSize: 15))
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  form(),
                  to(),
                   SizedBox(
                    height: 20,
                  ),
                  submit()
                ],
              ));
        }));
  }

  Widget nameact() {
    return Container(
        height: 40,
        margin: EdgeInsets.only(left: 30, right: 30),
        child: TextFormField(
          onChanged: (vulue) => actname = vulue.trim(),
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'กรอกกิจกรรม',
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
          onFieldSubmitted: (_) => saveForm(),
          validator: (title) =>
              title != null && title.isEmpty ? 'กรุณากรอกข้อมูล' : null,
          controller: titleController,
        ));
  }

  Widget diract() {
    return Container(
        height: 40,
        margin: EdgeInsets.only(left: 30, right: 30),
        child: TextFormField(
          onChanged: (value) => actdir = (value).trim(),
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'กรอกรายละเอียด',
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

  Container form() {
    return Container(
        margin: EdgeInsets.only(left: 50, right: 50),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () => pickFormDateTime(pickDate: true),
                  child: Text(Utils.toDate(fromdate),
                      style:
                          GoogleFonts.kanit(color: Colors.black, fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      primary: Colors.white,
                      elevation: 0)),
            ),
            SizedBox(width: 10),
            ElevatedButton(
                onPressed: () => pickFormDateTime(pickDate: false),
                child: Text(Utils.toTime(fromdate),
                    style:
                        GoogleFonts.kanit(color: Colors.black, fontSize: 20)),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    primary: Colors.white,
                    elevation: 0))
          ],
        ));
  }

  Container to() {
    return Container(
        margin: EdgeInsets.only(left: 50, right: 50),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => pickToDateTime(pickDate: true),
                child: Text(Utils.toDate(toDate),
                    style:
                        GoogleFonts.kanit(color: Colors.black, fontSize: 20)),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    primary: Colors.white,
                    elevation: 0),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
                onPressed: () => pickToDateTime(pickDate: false),
                child: Text(Utils.toTime(toDate),
                    style:
                        GoogleFonts.kanit(color: Colors.black, fontSize: 20)),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    primary: Colors.white,
                    elevation: 0))
          ],
        ));
  }

  Widget submit() {
    return Container(
        child: ElevatedButton(
            onPressed: () {
              print('$actname,$actdir,$type,$tags');
              saveForm();
              insertValueToFireStore();
            },
            child: Text(
              'เพิ่มกิจกรรม',
              style: GoogleFonts.kanit(color: Colors.white, fontSize: 25),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              primary: Colors.blue[400],
            padding: EdgeInsets.only(left: 100,right: 100,top: 5,bottom: 5)
            )));
  }

  Widget choiseday() {
    return ChipsChoice<String>.single(
      value: type,
      onChanged: (val) => setState(() => type = val),
      choiceItems: C2Choice.listFrom<String, String>(
        source: options,
        value: (i, v) => v,
        label: (i, v) => v,
      ),
    );
  }

  Widget weekday() {
    return ChipsChoice<String>.multiple(
      value: tags,
      onChanged: (val) => setState(() => tags = val),
      choiceItems: C2Choice.listFrom<String, String>(
        source: day,
        value: (i, v) => v,
        label: (i, v) => v,
      ),
      choiceStyle: C2ChoiceStyle(margin: EdgeInsets.only(left: 12)),
    );
  }

  Future pickFormDateTime({bool pickDate}) async {
    final date = await pickDateTime(fromdate, pickDate: pickDate);
    if (date == null) return;
    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(() => fromdate = date);
  }

  Future pickToDateTime({bool pickDate}) async {
    final date = await pickDateTime(toDate, pickDate: pickDate);
    if (date == null) return;

    setState(() => toDate = date);
  }

  Future<DateTime> pickDateTime(
    DateTime initialDate, {
    bool pickDate,
    DateTime firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015, 8),
          lastDate: DateTime(2101));

      if (date == null) return null;
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final TimeOfDay timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));

      if (TimeOfDay == null) return null;

      final date = DateTime(
        initialDate.year,
        initialDate.month,
        initialDate.day,
      );
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Future saveForm() async {
    final isValid = formkey.currentState.validate();

    if (isValid) {
      final event = Event(
        title: titleController.text,
        description: 'Description',
        from: fromdate,
        to: toDate,
      );
      final provider = Provider.of<EventProvider>(context, listen: false);
      provider.addEvent(event);

      Navigator.of(context).pop();
    }
  }

  Future<void> insertValueToFireStore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Map<String, dynamic> map = Map();
    map['actname'] = actname;
    map['actdir'] = actdir;
    map['type'] = type;
    map['tags'] = tags;
    map['start'] = fromdate;
    map['end'] = toDate;

    await firestore.collection('activity').doc().set(map).then((value) {
      print('insert success');
    });
  }
}
