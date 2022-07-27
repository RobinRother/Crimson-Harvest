import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// --------------------------------------------------------------------------------------------
import 'package:crimson_harvest/non_widget/day.dart';

class DateListProvider with ChangeNotifier{
  late Box boxTR;
  late List dateList;

  DateListProvider() {
    dateList = calculateDates();
    prepData();
  }



  void prepData() async {
    await openBoxTR();
    await saveTimeRangeStatus();
  }

  Future<void> openBoxTR() async {
    boxTR = await Hive.openBox('boxTR');
  }
  
  bool isCurrentDay(Day activeDayObject){
    DateTime currentDay = DateTime.now();
    if( currentDay.year == activeDayObject.year && 
        currentDay.month == activeDayObject.monthNum && 
        currentDay.day == activeDayObject.day){
      return true;
    }
    return false;
  }

  List calculateDates() {
    final DateTime calendarStart = DateTime.utc(DateTime.now().year - 5, 1, 1);
    final DateTime calendarEnd = DateTime.utc(DateTime.now().year + 5, 1, 1);
    // to be moved into config
    
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

    if(!boxTR.containsKey(day.key)){
      return;
    }

    // get index for key
    while(boxTR.keyAt(index) != day.key) {
      index++;
    }
    index++;

    while(index < boxTR.length && boxTR.getAt(index) != "first" && boxTR.getAt(index) != today){
      if(boxTR.getAt(index) == "last"){
        boxTR.deleteAt(index);
        return;
      }
      index++;
    }
  }


  // to be planned and improved
  Future<void> saveTimeRangeStatus() async {
    bool timeRangeIsActive = false;
    String role = "";
    bool isInFuture = false;

    for(int monthCounter = 0; monthCounter < dateList.length; monthCounter++){
      for(int dayCounter = 0; dayCounter < dateList[monthCounter].length; dayCounter++){
        role = "";
        if(boxTR.get(dateList[monthCounter][dayCounter].key) != null){
          role = boxTR.get(dateList[monthCounter][dayCounter].key);
        }

        if(isInFuture){
          continue;
        }
        else{
          if(role == "last"){
            dateList[monthCounter][dayCounter].inTimeRange = true;
            timeRangeIsActive = false;
          }

          if((role == "first" || timeRangeIsActive == true) && !isCurrentDay(dateList[monthCounter][dayCounter])){
            timeRangeIsActive = true;
            dateList[monthCounter][dayCounter].inTimeRange = true;
          }

          if(isCurrentDay(dateList[monthCounter][dayCounter])){
            if(timeRangeIsActive && (role != "last")){
              dateList[monthCounter][dayCounter].inTimeRange = true;
              timeRangeIsActive = false;
            }
            else if(!timeRangeIsActive && (role == "last")){
              dateList[monthCounter][dayCounter].inTimeRange = true;
            }
            else if(role == "first"){
              dateList[monthCounter][dayCounter].inTimeRange = true;
              timeRangeIsActive = false;
            }
            else{
              dateList[monthCounter][dayCounter].inTimeRange = false;
            }

            isInFuture = true;
          }
          
          if(role == "" && !timeRangeIsActive && !isCurrentDay(dateList[monthCounter][dayCounter])){
            dateList[monthCounter][dayCounter].inTimeRange = false;
          }
        }
      }
    }
    notifyListeners();
  }
}