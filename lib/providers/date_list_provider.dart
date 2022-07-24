import 'package:flutter/foundation.dart';
import 'package:crimson_harvest/non_widget/day.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DateListProvider with ChangeNotifier{
  late List dateList = calcDates();
  late Box boxTR;

  DateListProvider() {
    openBoxTR();
    saveTimeRangeStatus();
  }

  void openBoxTR() async {
    boxTR = await Hive.openBox('boxTR');
  }

  
  
  bool isCurrentDay(Day activeDayObject){    // function or variable
    DateTime currentDay = DateTime.now();
    if(currentDay.year == activeDayObject.year && currentDay.month == activeDayObject.monthNum && currentDay.day == activeDayObject.day){
      return true;
    }
    return false;
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

  Future<void> saveTimeRangeStatus() async {
    bool timeRangeIsActive = false;
    String role = "";

    for(int monthCounter = 0; monthCounter < dateList.length; monthCounter++){
      for(int dayCounter = 0; dayCounter < dateList[monthCounter].length; dayCounter++){
        if(boxTR.get(dateList[monthCounter][dayCounter].activeDayKey) != null){
          role = boxTR.get(dateList[monthCounter][dayCounter].activeDayKey);
        }
        else{
          role = "";
        }
        if(role == "last" || isCurrentDay(dateList[monthCounter][dayCounter])){
          dateList[monthCounter][dayCounter].inTimeRange = true;
          timeRangeIsActive = false;
        }

        if(role == "first" || timeRangeIsActive == true){
          timeRangeIsActive = true;
          dateList[monthCounter][dayCounter].inTimeRange = true;
        }
      }
    }
    notifyListeners();
  }
}