import 'package:flutter/material.dart';

class MonthGrid extends StatelessWidget {
  MonthGrid({required this.dates, required this.month, required this.year});
  final List dates;
  final String month;
  final String year;
  List<String> weekdays = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$month  -  $year'), //ersetzen mit Variablen Monat und Jahr
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 0.8,
          ),
          itemCount: 7,
          itemBuilder: (context, indexWeek) {
            return Container(
              color: Colors.amber,
              child: Text(weekdays[indexWeek]),
            );
          },
        ),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 0.8,
          ),
          itemCount: dates.length,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.amber,
              child: Text(dates[index].day.toString()),
            );
          },
        ),
      ],
    );
  }
}