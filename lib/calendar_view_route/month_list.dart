import 'package:flutter/material.dart';
import '../day.dart';
import 'month_grid.dart';
import 'weekday_row.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../providers/current_month_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';

class MonthList extends StatefulWidget {
  @override
  State<MonthList> createState() => _MonthListState();
}

class _MonthListState extends State<MonthList> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => context.read<CurrentMonthProvider>().scrollToCurrentMonth());
  }

  @override
  build(BuildContext context) {
    List dateList = calcDates(context.watch<CurrentMonthProvider>().calendarStart, context.watch<CurrentMonthProvider>().calendarEnd, context);
    ItemScrollController _itemScrollController = context.watch<CurrentMonthProvider>().itemScrollControler;

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
      ],
    );
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