import 'package:flutter/material.dart';
// --------------------------------------------------------------------------------------------
import 'package:crimson_harvest/calendar_view_route/day_grid.dart';

/// Displays the month with a heading.
/// 
/// Gap day is a day belonging to the previous month which makes a "gap" at the beginning of the current month.
class MonthGrid extends StatelessWidget {
  const MonthGrid({Key? key, required this.dates, required this.month, required this.year}) : super(key: key);
  final List dates;       // contains list with each day from the corresponding month
  final String month;
  final String year;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Text(
            '$month  -  $year',
            style: const TextStyle(
              fontFamily: 'peels',
              fontSize: 28,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 253, 237),
            borderRadius: BorderRadius.circular(20),
          ),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 0.8,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: dates.length,
            itemBuilder: (context, index) {
              return DayGrid(
                activeDayObject: dates[index],
                isGapDay: _isGapDay(dates[index].day),
              );
            },
          ),
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