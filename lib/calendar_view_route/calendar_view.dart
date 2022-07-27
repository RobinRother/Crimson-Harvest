import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// --------------------------------------------------------------------------------------------
import 'package:crimson_harvest/providers/current_month_provider.dart';
import 'package:crimson_harvest/calendar_view_route/month_list.dart';

/// Builds the screen displaying the appbar and the calendar.
/// 
/// The appbar contains links to the current month and the github repo each.
class CalendarView extends StatelessWidget {
  const CalendarView({Key? key}) : super(key: key);
  
  static const String routeWebView = "/web_view";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime.shade200,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 160, 120, 90),
        title: const Text('Crimson Harvest'),
        actions: [
          IconButton(
            onPressed: () => context.read<CurrentMonthProvider>().scrollToCurrentMonth(),
            icon: const Icon(Icons.calendar_today_outlined),
          ),
          IconButton(
            icon: Image.asset("assets/GitHub-Mark-Light-32px.png"),
            onPressed: (() {
              Navigator.pushNamed(
                context, 
                routeWebView,
              );
            }),
          ),
          // to be implemented later
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.menu_outlined),
          ),
        ],
      ),
      body: const MonthList(),
    );
  }
}