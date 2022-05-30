import 'package:flutter/material.dart';
import 'package:midentistaapp/src/pages/citas_add.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:midentistaapp/NavDrawer.dart';
import 'package:midentistaapp/src/pages/info_cita.dart';

class AgendaPage extends StatefulWidget {
  static String id = 'agenda_page';

  @override
  _AgendaState createState() => _AgendaState();
}

class _AgendaState extends State<AgendaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logodentista.png',
              fit: BoxFit.scaleDown,
              height: 50,
            ),
            Container(padding: const EdgeInsets.all(8.0), child: Text(''))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CitaAddPage()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        initialDisplayDate: DateTime.now(),
        monthViewSettings: MonthViewSettings(showAgenda: true),
        dataSource: MeetingDataSource(getAppointments()),
        onLongPress: (CalendarLongPressDetails details) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InfoCitaPage()),
          );
        },
      ),
    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Board Meeting',
      color: Colors.blue,
      recurrenceRule: 'FREQ=DAILY;COUNT=10',
      isAllDay: false));

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
