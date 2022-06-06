// exchange list with multi type data format
import 'package:flutter/material.dart';
import 'day.dart';
import 'month_grid.dart';
import 'weekday_row.dart';

class MonthList extends StatelessWidget {

  // make it later dyncamic to current day
  final DateTime calendarStart = DateTime.utc(2020, 1, 1);
  final DateTime calendarEnd = DateTime.utc(2028, 1, 1);

  @override
  build(BuildContext context) {
    List dateList = calcDates(calendarStart, calendarEnd);

    return Column(
      children: [
        WeekdayRow(),
        Expanded(
          child: ListView.builder(
            //shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return MonthGrid(
                // passing months individually
                dates: dateList[index],
                //passing attributes of first day each to create header -- gap day already have correct month/ year
                month: dateList[index][0].monthName,
                year: dateList[index][0].year.toString(),
              );
            },
            itemCount: dateList.length,
          ),
        ),
      ],
    );
  }

  List calcDates(DateTime calendarStart, DateTime calendarEnd){
    List<List> calculatedDateList = [];
    DateTime dayIterator = calendarStart;
    int monthIndex = 0;
    int comparisonMonth = calendarStart.month;

    while (calendarEnd.isAfter(dayIterator)){
      if (comparisonMonth != dayIterator.month) {
        monthIndex = monthIndex + 1;
        comparisonMonth = dayIterator.month;
      }

      if (dayIterator.day == 1){
        int gap = dayIterator.weekday - 1;
        //to make month index accessible need to create this
        List<Day> firstElement = [];

        // create list with gap days
        while(gap > 0){
          firstElement.add(Day.placeholder(date: dayIterator));
          gap = gap - 1;
        }

        firstElement.add(Day(date: dayIterator));
        calculatedDateList.add(firstElement);
        dayIterator = dayIterator.add(const Duration(days: 1));
        //avoid adding day 1 two times
        continue;
      }

      calculatedDateList[monthIndex].add(Day(date: dayIterator));
      dayIterator = dayIterator.add(const Duration(days: 1));
    }
    return calculatedDateList;
  }
}