import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ijoa/pages/detail_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(CalendarPage()));
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  CalendarController _calendarController;
  DateTime _selectedDay;
  DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    final _today = DateTime.now();
    Map _json = {
      'yes': 111,
      'no': 123,
      'hmm': {'no?': 'this', 'yes?': 'that'}
    };

    _events = {
      _today: [
        'Event A7',
        'Event B7',
        jsonEncode(_json),
      ],
    };

    _selectedEvents = _events[_today] ?? [];
    _calendarController = CalendarController();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
      _selectedDay = day;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
    setState(() {
      _focusedDay = first.add(Duration(days: 7));
    });
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  String _getDateFromDateTime(DateTime date) {
    return (date.month.toString() + "월 " + date.day.toString() + "일");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _calendarAppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(
            height: 0,
          ),
          _buildTableCalendar(),
          SizedBox(
            height: 24,
          ),
          Text(
            'Todo List: ' + _getDateFromDateTime(_selectedDay),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  Widget _calendarAppBar() {
    return AppBar(
      title: Text(_focusedDay.month.toString() + "월"),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      // locale: Locale('ko', 'KR'),
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.horizontalSwipe,
      calendarStyle: CalendarStyle(
        
          selectedColor: Colors.deepOrange[400],
          todayColor: Colors.deepOrange[200],
          markersColor: Colors.brown[700],
          outsideDaysVisible: true,
          holidayStyle: TextStyle(color: Colors.amber),
          weekendStyle: TextStyle(color: Colors.amber)),
      headerStyle: HeaderStyle(
          centerHeaderTitle: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(color: Colors.transparent, fontSize: 0),
          headerPadding: EdgeInsets.zero,
          rightChevronIcon: Icon(
            Icons.add,
            color: Colors.transparent,
            size: 0,
          ),
          leftChevronIcon: Icon(
            Icons.add,
            color: Colors.transparent,
            size: 0,
          )),
      daysOfWeekStyle:
          DaysOfWeekStyle(weekendStyle: TextStyle(color: Colors.amber)),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventList() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: _selectedEvents
          .map((event) => SizedBox(
                width: 150,
                child: Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                    elevation: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(child: Center(child: Text(event.toString()))),
                        FlatButton(
                          child: Text('자세히'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                        title: '놀이 자세히',
                                        url:
                                            'https://www.notion.so/pavilionai/2-d4aa5017272f4d17bd6630baeecabb6a',
                                      )),
                            );
                          },
                          textColor: Colors.grey,
                        )
                      ],
                    )),
              ))
          .toList(),
    );
  }
}
