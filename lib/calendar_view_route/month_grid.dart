import 'package:flutter/material.dart';
// --------------------------------------------------------------------------------------------
import 'package:crimson_harvest/calendar_view_route/day_grid.dart';

class MonthGrid extends StatelessWidget {
  const MonthGrid({Key? key, required this.dates, required this.month, required this.year}) : super(key: key);
  final List dates;
  final String month;
  final String year;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$month  -  $year'),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(    // read from settings?
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