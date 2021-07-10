import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memo/models/medical_model.dart';

class Medical extends StatefulWidget {
  @override
  _Medical createState() => _Medical();
}

class Day {
  const Day(this.name);
  final String name;
}

class _Medical extends State<Medical> {
  String mname, mdetail, mcount, time, type,day;
  List<Widget> widgets = [];
  List<Day> _day;
  List<String> _filters;

  @override
  void initState() {
    super.initState();
    readData();
    _day = <Day>[
      const Day('จันทร์'),
      const Day('อังคาร'),
      const Day('พุธ'),
      const Day('พฤหัสบดี'),
      const Day('ศุกร์'),
    ];
    _filters = <String>[];
  }

  Future<void> insertValueToFireStore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Map<String, dynamic> map = Map();
    map['mname'] = mname;
    map['mdetail'] = mdetail;
    map['mcount'] = mcount;
    map['time'] = time;
    map['type'] = type;

    await firestore.collection('medical').doc().set(map).then((value) {
      print('insert success');
    });
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      print('connect');
      await FirebaseFirestore.instance
          .collection('medical')
          .orderBy('mname')
          .snapshots()
          .listen((event) {
        print('snapshot = ${event.docs}');
        for (var snapshots in event.docs) {
          Map<String, dynamic> map = snapshots.data();
          print('map = $map');
          MedicalModel model = MedicalModel.fromMap(map);
          print('name = ${model.mname}');
          setState(() {
            widgets.add(createWidget(model));
          });
        }
      });
    });
  }

  Widget createWidget(MedicalModel model) => Card(
          child: Center(
              child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(model.mname),
          Text(model.mcount),
          Text(model.type),
          Text(model.time),
        ],
      )));

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          elevation: 0,
          title: Text(
            'ระบบแจ้งเตือนการกินยา',
            style: GoogleFonts.kanit(fontSize: 20),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.pinkAccent,
            indicatorWeight: 5,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.add_circle_outline),
                text: 'เพิ่ม',
              ),
              Tab(
                icon: Icon(Icons.list_alt),
                text: 'รายการ',
              )
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[buildadd(), buildlist()]),
      ));

  Widget buildadd() {
    return Container(
        child: Column(
      children: <Widget>[
       
        Text(
          'เพิ่มการแจ้งเตือนการกินยา',
          style: GoogleFonts.kanit(fontSize: 15),
        ),
        buildname(),
        builddir(),
        buildnumber(),
        buildchoise(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: dayWidgets.toList(),
          ),
        ),
        
        buildlogin()
      ],
    ));
  }

  Widget buildlist() {
    return Scaffold(
        body: widgets.length == 0
            ? Center(child: CircularProgressIndicator())
            : GridView.extent(
                maxCrossAxisExtent: 200,
                children: widgets,
              ));
  }

  Container buildname() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: TextField(
        onChanged: (value) => mname = value.trim(),
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            border: OutlineInputBorder(),
            hintText: 'ชื่อยา',
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.indigo),
              borderRadius: new BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo),
                borderRadius: new BorderRadius.circular(10.0)),
            prefixIcon: Icon(
              Icons.medical_services_outlined,
              color: Colors.indigo,
            )),
      ),
    );
  }

  Container builddir() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 1, 20, 20),
      child: TextField(
        onChanged: (value) => mdetail = value.trim(),
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            border: OutlineInputBorder(),
            hintText: 'ลักษณะยา',
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.indigo),
              borderRadius: new BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo),
                borderRadius: new BorderRadius.circular(10.0)),
            prefixIcon: Icon(
              Icons.assignment_outlined,
              color: Colors.indigo,
            )),
      ),
    );
  }

  Container buildnumber() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 1, 20, 20),
      child: TextField(
        onChanged: (value) => mcount = value.trim(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            border: OutlineInputBorder(),
            hintText: 'จำนวนยา',
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.indigo),
              borderRadius: new BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo),
                borderRadius: new BorderRadius.circular(10.0)),
            prefixIcon: Icon(
              Icons.medical_services_outlined,
              color: Colors.indigo,
            )),
      ),
    );
  }

  Widget buildchoise() {
    return Container(
        child: Row(
      children: <Widget>[radioone(), radiothree()],
    ));
  }

  Widget radioone() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'ประเภท',
            style: GoogleFonts.kanit(fontSize: 15),
          ),
          Container(
              height: 112,
              width: 180,
              child: Column(children: [
                RadioListTile(
                  value: 'ก่อนอาหาร',
                  groupValue: type,
                  onChanged: (value) {
                    setState(() {
                      type = value;
                    });
                  },
                  title: Text('ก่อนอาหาร'),
                ),
                RadioListTile(
                  value: 'หลังอาหาร',
                  groupValue: type,
                  onChanged: (value) {
                    setState(() {
                      type = value;
                    });
                  },
                  title: Text('หลังอาหาร'),
                ),
              ]))
        ],
      );

  Widget radiothree() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'เวลา',
            style: GoogleFonts.kanit(fontSize: 15),
          ),
          Container(
              width: 180,
              height: 158,
              child: Column(children: [
                RadioListTile(
                  value: 'เช้า',
                  groupValue: time,
                  onChanged: (value) {
                    setState(() {
                      time = value;
                    });
                  },
                  title: Text('เช้า'),
                ),
                RadioListTile(
                  value: 'กลางวัน',
                  groupValue: time,
                  onChanged: (value) {
                    setState(() {
                      time = value;
                    });
                  },
                  title: Text('กลางวัน'),
                ),
                RadioListTile(
                  value: 'เย็น',
                  groupValue: time,
                  onChanged: (value) {
                    setState(() {
                      time = value;
                    });
                  },
                  title: Text('เย็น'),
                ),
              ]))
        ],
      );

  Iterable<Widget> get dayWidgets sync* {
    for (Day day in _day) {
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: FilterChip(
            avatar: CircleAvatar(
              child: Text(day.name[0].toUpperCase()),
            ),
            label: Text(day.name),
            selected: _filters.contains(day.name),
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  _filters.add(day.name);
                  
                } else {
                  _filters.removeWhere((String name) {
                    return name == day.name;
                  });
                }
              });
            }),
      );
    }
  }

  RaisedButton buildlogin() {
    return RaisedButton(
        onPressed: () {
          print(
              'name =$mname , detail =$mdetail, count = $mcount , type=$type,time=$time');
          insertValueToFireStore();
        },
        color: Colors.pinkAccent,
        textColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.symmetric(horizontal: 150.0, vertical: 5.0),
        child: Text('เพิ่ม', style: GoogleFonts.kanit(fontSize: 25)));
  }
}
