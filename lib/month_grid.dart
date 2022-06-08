import 'package:flutter/material.dart';
import 'day_grid.dart';

class MonthGrid extends StatelessWidget {
  MonthGrid({required this.dates, required this.month, required this.year});
  final List dates;
  final String month;
  final String year;
  bool focused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$month  -  $year'),
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
            return DayGrid(
              activeDayObject: dates[index],
              isGapDay: _isGapDay(dates[index].day),
            );
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