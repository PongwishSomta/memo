import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:memo/data/chipdata.dart';
import 'package:memo/models/chipmodel.dart';

class Addactivity extends StatefulWidget {
  @override
  _AddactivityState createState() => _AddactivityState();
}

class _AddactivityState extends State<Addactivity> {
  final formKey = GlobalKey<FormState>();
  double screen;
  DateTimeRange dateRange;
  List<ChoiceChipData> choiceChips = ChoiceChips.all;
  List<ChoiceChipData> selecedcolor = ChoiceChips.selecedColor;
  TimeOfDay time;

  @override
  void initState() {
    super.initState();
  }

  String getForm() {
    if (dateRange == null) {
      return 'เลือกวันที่';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'เลือกวันที่';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange.end);
    }
  }

  String getText() {
    if (time == null) {
      return 'Select Time';
    } else {
      return '${time.hour}:${time.minute}';
    }
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;

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
            style: GoogleFonts.kanit(color: Colors.grey[800], fontSize: 20),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return Container(
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
                buildChoiceChips(),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(width: 45),
                  Text('รายละเอียดกิจกรรม',
                      style: GoogleFonts.kanit(
                          color: Colors.grey[800], fontSize: 20))
                ]),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      primary: Colors.white,
                      padding: EdgeInsets.only(left: 120, right: 120),
                      elevation: 0),
                  onPressed: () => pickDate(context),
                  child: Text(
                    getForm(),
                    style: GoogleFonts.kanit(
                        color: Colors.grey[800], fontSize: 20),
                  ),
                ),
                Text('ถึง',
                    style: GoogleFonts.kanit(
                        color: Colors.grey[800], fontSize: 20)),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      primary: Colors.white,
                      padding: EdgeInsets.only(left: 120, right: 120),
                      elevation: 0),
                  onPressed: () {
                    pickDate(context);
                  },
                  child: Text(
                    getUntil(),
                    style: GoogleFonts.kanit(
                        color: Colors.grey[800], fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      primary: Colors.white,
                      padding: EdgeInsets.only(left: 80, right: 80),
                      elevation: 0),
                  onPressed: () {
                    pickTime(context);
                  },
                  child: Text(
                    getText(),
                    style: GoogleFonts.kanit(
                        color: Colors.grey[800], fontSize: 20),
                  ),
                )
              ],
            ),
          );
        }));
  }

  Container nameact() {
    return Container(
        height: 50,
        margin: EdgeInsets.only(left: 30, right: 30),
        child: TextField(
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
        ));
  }

  Widget buildChoiceChips() => Wrap(
        spacing: 10,
        children: choiceChips
            .map((choiceChip) => ChoiceChip(
                label: Text(choiceChip.label),
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                onSelected: (isSelected) => setState(() {
                      choiceChips = choiceChips.map((otherChip) {
                        final newChip = otherChip.copy(isSelected: false);

                        return choiceChip == newChip
                            ? newChip.copy(isSelected: isSelected)
                            : newChip;
                      }).toList();
                    }),
                selected: choiceChip.isSelected,
                selectedColor: Colors.blue[200],
                backgroundColor: choiceChip.selectedColor))
            .toList(),
      );

  Future pickDate(BuildContext context) async {
    final initialDateRange = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(Duration(hours: 24 * 3)));
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;
    setState(() => dateRange = newDateRange);
  }

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );
    if (newTime == null) return;

    setState(() => time = newTime);
  }
}
