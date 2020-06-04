import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ijoa/models/event.dart';
import 'package:ijoa/pages/detail_page.dart';
import 'package:ijoa/widgets/event_tile.dart';
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

    _events = {
      _today: eventModelList,
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
      calendarStyle: _calendarStyle(),
      headerStyle: _headerStyle(),
      builders: _calendarBuilders(),
      daysOfWeekStyle:
          DaysOfWeekStyle(weekendStyle: TextStyle(color: Colors.red[400])),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  HeaderStyle _headerStyle() {
    return HeaderStyle(
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
        ));
  }

  CalendarStyle _calendarStyle() {
    return CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: true,
        holidayStyle: TextStyle(color: Colors.red[400]),
        weekendStyle: TextStyle(color: Colors.red[400]));
  }

  CalendarBuilders _calendarBuilders() {
    return CalendarBuilders(
      selectedDayBuilder: (context, date, events) {
        return _buildDay(
            day: date.day.toString(), backgroundColor: Colors.amber[100]);
      },
      todayDayBuilder: (context, date, events) {
        return _buildDay(day: date.day.toString());
      },
      dayBuilder: (context, date, events) {
        return _buildDay(day: date.day.toString());
      },
      weekendDayBuilder: (context, date, events) {
        return _buildDay(textColor: Colors.red[400], day: date.day.toString());
      },
      outsideDayBuilder: (context, date, events) {
        return _buildDay(textColor: Colors.grey.shade300, day: date.day.toString());
      },
      outsideWeekendDayBuilder: (context, date, events) {
        return _buildDay(textColor: Colors.red.shade100, day: date.day.toString());
      },
      markersBuilder: (context, date, events, holidays) {
        final children = <Widget>[];
        if (events.isNotEmpty) {
          children.add(
            Positioned(
              top: 4,
              right: 4,
              // bottom: 1,
              child: Container(
                  color: Colors.amber,
                  width: 12, height: 12,
                  child: Center(
                      child: Text(
                    '${events.length}',
                    style: TextStyle(fontSize: 8.0),
                  ))
                  ),
            ),
          );
        }
        return children;
      },
    );
  }

  Widget _buildDay({String day, Color backgroundColor, Color textColor}) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      color: backgroundColor ?? Colors.transparent,
      width: 100,
      height: 100,
      child: Center(
        child: Text(day,
            style: TextStyle(color: textColor ?? Colors.grey.shade700)),
      ),
    );
  }

  Widget _buildEventList() {
    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _selectedEvents.length,
        itemBuilder: (BuildContext context, int index) {
          return EventTile(
            event: _selectedEvents[index],
          );
        },
      ),
    );
  }
}
