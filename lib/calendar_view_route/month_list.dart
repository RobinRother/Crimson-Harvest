import 'package:flutter/material.dart';
import '../non_widget/day.dart';
import 'month_grid.dart';
import 'weekday_row.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../providers/current_month_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MonthList extends StatefulWidget {
  @override
  State<MonthList> createState() => _MonthListState();
}

class _MonthListState extends State<MonthList> {
  late Box boxTR;
  late List dateList;

  _MonthListState() {
    createBoxTR(); 
  }

  @override
  void dispose() {
    boxTR.close();   //box
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => context.read<CurrentMonthProvider>().scrollToCurrentMonth());
    dateList = calcDates();

  }

  void createBoxTR() async {
    boxTR = await Hive.openBox('boxTR');
    await saveTimeRangeStatus(dateList);
  }

  bool isCurrentDay(Day activeDayObject){    // function or variable
    DateTime currentDay = DateTime.now();
    if(currentDay.year == activeDayObject.year && currentDay.month == activeDayObject.monthNum && currentDay.day == activeDayObject.day){
      return true;
    }
    return false;
  }

  Future<void> saveTimeRangeStatus(List dateList) async {
    bool timeRangeIsActive = false;
    String role = "";

    for(int monthCounter = 0; monthCounter < dateList.length; monthCounter++){
      for(int dayCounter = 0; dayCounter < dateList[monthCounter].length; dayCounter++){
        if(boxTR.get(dateList[monthCounter][dayCounter].activeDayKey) != null){
          role = boxTR.get(dateList[monthCounter][dayCounter].activeDayKey);
        }
        else{
          continue;
        }
        if(role == "last" || isCurrentDay(dateList[monthCounter][dayCounter])){
          dateList[monthCounter][dayCounter].inTimeRange = true;
          print("_________________________________________________");
          print(dateList[monthCounter][dayCounter].day);
          print(dateList[monthCounter][dayCounter].monthNum);
          timeRangeIsActive = false;
        }

        if(role == "first" || timeRangeIsActive == true){
          timeRangeIsActive = true;
          dateList[monthCounter][dayCounter].inTimeRange = true;
          print("_________________________________________________");
          print(dateList[monthCounter][dayCounter].day);
          print(dateList[monthCounter][dayCounter].monthNum);
        }
      }
    }
    setState(() {});
  }

  @override
  build(BuildContext context) {
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
                month: dateList[index][0].mapMonthName(context),
                year: dateList[index][0].year.toString(),
              );
            },
            itemCount: dateList.length,
          ),
        ),
      ],
    );
  }

  List calcDates(){
    DateTime calendarStart = DateTime.utc(2020, 1, 1);
    DateTime calendarEnd = DateTime.utc(2028, 1, 1);
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