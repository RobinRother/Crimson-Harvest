import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: MonthGrid(),
      ),
    );
  }
}


class MonthGrid extends StatelessWidget{    // really monthWidget?
  final monthlen = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, 30, 31];

  calcDates(DateTime calendarStart, DateTime calendarEnd){
    List<String> weekdays = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];
    List<List> calculatedDateList = [];
    DateTime dayIterator = calendarStart;
    int monthIndex = 0;
    int comparisonMonth = calendarStart.month;

    while(calendarEnd.isAfter(dayIterator)){

      // hopefully month is increased by day+1
      // if it is the next month, then iterate to next month in list
      if(comparisonMonth != dayIterator.month){
        int comparisonMonth = dayIterator.month;
        monthIndex++;
      }

      // prepare content for new month widget: weekdays and placeholder content (weekdays before the first month day)
      if(dayIterator.day == 1){
        // should place weekdays in one index field
        calculatedDateList.add(weekdays);

        // add buffer according to weekday

      }

      // adding week row to index - buffer to be added!!!
      calculatedDateList[monthIndex].add(dayIterator.day.toString());

      dayIterator.add(const Duration(days: 1));
    }

  return calculatedDateList;


    // // add buffer!!!
    // var allDates = [];
    // var monthGridContent = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];

    // DateTime nextDay = calendarStart;

    // while(calendarEnd.isAfter(nextDay)){
      

    //   DateTime nextDay = calendarStart.add(const Duration(days: 1));
    // }

    // for (int date = 1; date<32; date++){
    //   monthGridContent.add(date.toString());
    // }
    // allDates.add(monthGridContent);

    // return allDates;
  }
  
  @override
  build(BuildContext context){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemCount: 38,
      itemBuilder: (context, index){
        var dates = calcDates(DateTime.utc(2018, 1, 1), DateTime.utc(2018, 2, 1));
        return Text('${dates[0][index]}');
      }
    );
  }
}