import 'package:flutter/material.dart';
import 'day_grid.dart';

class MonthGrid extends StatelessWidget {
  MonthGrid({required this.dates, required this.month, required this.year});
  final List dates;
  final String month;
  final String year;
  List<String> weekdays = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];
  bool focused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${month}  -  ${year}'), //ersetzen mit Variablen Monat und Jahr
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 0.8,
          ),
          itemCount: dates.length + 7,
          itemBuilder: (context, index) {
            if(index < 7){
              return Container(
                color: Colors.amber,
                child: Text(weekdays[index]),
              );
            }
            else{
              return DayGrid(
                dayString: dates[index - 7].day.toString(),
                isGapDay: _isGapDay(dates[index - 7].day),
              );
            };
          },
        ),
      ],
    );
  }

  bool _isGapDay(int dayValue){
    if(dayValue > 0){
      return false;
    }
    return true;
  }
}