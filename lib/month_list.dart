import 'package:flutter/material.dart';
import 'day.dart';
import 'month_grid.dart';
import 'weekday_row.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MonthList extends StatelessWidget {

  // @TODO make it later dyncamic to current day OR even in settings
  final DateTime calendarStart = DateTime.utc(2020, 1, 1);
  final DateTime calendarEnd = DateTime.utc(2028, 1, 1);
  final ItemScrollController _itemScrollController = ItemScrollController();

  @override
  build(BuildContext context) {
    List dateList = calcDates(calendarStart, calendarEnd, context);
    int currentMonthIndex = calcCurrentMonthIndex(dateList);

    return Column(
      children: [
        WeekdayRow(),
        Expanded(
          child: ScrollablePositionedList.builder(
            itemScrollController: _itemScrollController,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return MonthGrid(
                // passing months individually
                dates: dateList[index],
                //passing attributes of first day each to create header -- gap day already has correct month/ year
                month: dateList[index][0].monthName,
                year: dateList[index][0].year.toString(),
              );
            },
            itemCount: dateList.length,
          ),
        ),
        FloatingActionButton(
          onPressed: () => currentMonth(currentMonthIndex))
      ],
    );
  }

  void currentMonth(int currentMonthIndex){
    _itemScrollController.jumpTo(index: currentMonthIndex);
  }

  int calcCurrentMonthIndex(List dateList){
    DateTime currentDay = DateTime.now();
    int index = 0;
    //accessing in list of months first day (doesn't matter if gap day)
    while(currentDay.year != dateList[index][0].year || currentDay.month != dateList[index][0].monthNum){
      index++;
    }
    // otherwise error?
    return index;
  }

  List calcDates(DateTime calendarStart, DateTime calendarEnd, BuildContext context){
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
          firstElement.add(Day.placeholder(date: dayIterator, context: context));
          gap = gap - 1;
        }

        firstElement.add(Day(date: dayIterator, context: context));
        calculatedDateList.add(firstElement);
        dayIterator = dayIterator.add(const Duration(days: 1));
        //avoid adding day 1 two times
        continue;
      }

      calculatedDateList[monthIndex].add(Day(date: dayIterator, context: context));
      dayIterator = dayIterator.add(const Duration(days: 1));
    }
    return calculatedDateList;
  }
}