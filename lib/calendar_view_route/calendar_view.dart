import 'package:crimson_harvest/calendar_view_route/month_list.dart';
import 'package:flutter/material.dart';
import 'package:crimson_harvest/providers/current_month_provider.dart';
import 'package:provider/provider.dart';

class CalendarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar als festes widget auslagern?
      appBar: AppBar(
        title: const Text('Crimson Harvest'),
        actions: [
          IconButton(
            onPressed: () => context.read<CurrentMonthProvider>().scrollToCurrentMonth(),
            icon: const Icon(Icons.calendar_today_outlined),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(Icons.menu_outlined),
          ),
        ],
      ),
      body: MonthList(),
    );
  }
}