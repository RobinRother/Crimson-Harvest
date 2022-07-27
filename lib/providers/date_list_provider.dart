import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// --------------------------------------------------------------------------------------------
import 'package:crimson_harvest/non_widget/day.dart';

/// Provider containing all variables/ methods necessary to fill the calendar with up-to-date information
class DateListProvider with ChangeNotifier{
  late Box boxTR;
  late List dateList;

  DateListProvider() {
    dateList = calculateDates();
    prepData();
  }

  /// Prepares data in correct order with await to avoid initialization problems.
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

  /// Calculates dates to be filled into the calendar
  /// 
  /// dateList format: List[List][Day] (a [List] containing [List]s (the months) containing [Day] objects).
  List calculateDates() {
    // to be moved into config
    final DateTime calendarStart = DateTime.utc(DateTime.now().year - 5, 1, 1);
    final DateTime calendarEnd = DateTime.utc(DateTime.now().year + 5, 1, 1);
    // ===

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

        // creates list with gap days
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

  /// Deletes "last" mark in hive box for timeranges
  /// 
  /// Necessary when marking another day as "last" -> deletes entry not belonging to the timerange anymore.
  void deleteOldLast(Day day){
    String today = DateTime.now().toString();
    int index = 0;

    if(!boxTR.containsKey(day.key)){
      return;
    }

    // gets index for key
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
  /// Sets [Day.inTimeRange] to true when a timerange is created/ deleted/ edited.
  /// 
  /// Sets everything inbetween start and end or current day to true.
  Future<void> saveTimeRangeStatus() async {
    bool timeRangeIsActive = false;
    String role = "";

    for(int monthCounter = 0; monthCounter < dateList.length; monthCounter++){
      for(int dayCounter = 0; dayCounter < dateList[monthCounter].length; dayCounter++){
        role = "";
        
        // the active day (day of this iteration) is saved in hive
        if(boxTR.get(dateList[monthCounter][dayCounter].key) != null){
          role = boxTR.get(dateList[monthCounter][dayCounter].key);
        }

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
        }
        
        if(role == "" && !timeRangeIsActive && !isCurrentDay(dateList[monthCounter][dayCounter])){
          dateList[monthCounter][dayCounter].inTimeRange = false;
        }
      }
    }
    notifyListeners();
  }
}