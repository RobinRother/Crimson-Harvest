import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// --------------------------------------------------------------------------------------------
import 'package:crimson_harvest/providers/current_month_provider.dart';
import 'package:crimson_harvest/calendar_view_route/month_list.dart';


class CalendarView extends StatelessWidget {
  const CalendarView({Key? key}) : super(key: key);
  
  static const String routeWebView = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar als festes widget auslagern?
      appBar: AppBar(
        title: const Text('Crimson Harvest'),     // auslagern in config file?
        actions: [
          IconButton(
            onPressed: () => context.read<CurrentMonthProvider>().scrollToCurrentMonth(),
            icon: const Icon(Icons.calendar_today_outlined),
          ),
          IconButton(
            icon: Image.asset("figures/GitHub-Mark-Light-32px.png"),
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