import 'month_list.dart';
import 'package:flutter/material.dart';
import 'day.dart';

class CalendarView extends StatefulWidget {
  CalendarView({Key? key}) : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    return MonthList();
  }
}