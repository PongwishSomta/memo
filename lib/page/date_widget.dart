import 'package:flutter/material.dart';
import 'package:memo/models/event_data.dart';
import 'package:memo/provider.dart/event_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return Scaffold(
        appBar: AppBar(
          title: Text('ตารางเวลา',style:
                GoogleFonts.kanit(color: Colors.blue, fontSize: 20)),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: SfCalendar(
            view: CalendarView.month,
            dataSource: EventDataSource(events),
            initialSelectedDate: DateTime.now(),
            appointmentTimeTextFormat: 'HH:mm',
            monthViewSettings: MonthViewSettings(
              numberOfWeeksInView: 1,
              agendaViewHeight: 470,
              showAgenda: true
              ),
));
  }
}

