import 'package:flutter/foundation.dart';
import 'package:crimson_harvest/non_widget/day.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DateListProvider with ChangeNotifier{
  late List dateList = calcDates();
  late Box boxTR;

  DateListProvider() {
    openBoxTR();
    //saveTimeRangeStatus();
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
/*
  bool isTomorrow(Day day){
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    DateTime activeDay = DateTime.utc(day.year, day.monthNum, day.day);

    if(tomorrow == activeDay){
      return true;
    }
    return false;
  }
*/

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

  void deleteOldLast(Day day){
    String today = DateTime.now().toString();
    int index = 0;

    if(!boxTR.containsKey(day.activeDayKey)){
      print('but it should exist?');
      return;
    }

    // get index for key
    while(boxTR.keyAt(index) != day.activeDayKey) {
      index++;
    }

    print("index of selected: ");
    print(index);
    index++;

    while(index < boxTR.length && boxTR.getAt(index) != "first" && boxTR.getAt(index) != today){
      if(boxTR.getAt(index) == "last"){
        print('there was something to delete');
        print(index);
        boxTR.deleteAt(index);
        return;
      }
      index++;
    }
  }

  Future<void> saveTimeRangeStatus() async {
    bool timeRangeIsActive = false;
    String role = "";

    for(int monthCounter = 0; monthCounter < dateList.length; monthCounter++){
      for(int dayCounter = 0; dayCounter < dateList[monthCounter].length; dayCounter++){
        role = "";
        if(boxTR.get(dateList[monthCounter][dayCounter].activeDayKey) != null){
          role = boxTR.get(dateList[monthCounter][dayCounter].activeDayKey);
        }
        
        // more important: start at today should go only til today!
        // why is current day not included?
        if(role == "last" || isCurrentDay(dateList[monthCounter][dayCounter])){
          dateList[monthCounter][dayCounter].inTimeRange = true;
          print("check: ${DateTime.now()}");
          //print(dateList[monthCounter][dayCounter].day);
          //print(dateList[monthCounter][dayCounter].inTimeRange);
          timeRangeIsActive = false;
        }

        if(role == "first" || timeRangeIsActive == true){
          timeRangeIsActive = true;
          dateList[monthCounter][dayCounter].inTimeRange = true;
        }
        
        if(role == "" && !timeRangeIsActive){
          dateList[monthCounter][dayCounter].inTimeRange = false;
        }
      }
    }
    notifyListeners();
  }
}