import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: MonthList(),
      ),
    );
  }
}


// exchange list with multi type data format
class MonthList extends StatelessWidget {
  MonthList({Key? key}) : super(key: key);

  final DateTime calendarStart = DateTime.utc(2018, 1, 1);
  final DateTime calendarEnd = DateTime.utc(2020, 1, 1);

  @override
  build(BuildContext context) {
    List dateList = calcDates(calendarStart, calendarEnd);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            //shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return MonthGrid(
                dates: dateList[index],
                //passing attributes of first day each
                month: dateList[index][0].month,     // wird als zahl ausgegeben -> wie als string?
                year: dateList[index][0].year.toString(),
              ); // needs only one month!!
            },
            //separatorBuilder: (BuildContext context, int index) => const Divider(),
            itemCount: dateList.length,
          ),
        ),
      ],
    );
  }


  List calcDates(DateTime calendarStart, DateTime calendarEnd) {
    List<List> calculatedDateList = [];
    DateTime dayIterator = calendarStart;
    int monthIndex = 0;
    int comparisonMonth = calendarStart.month;

    while (calendarEnd.isAfter(dayIterator)) {
      // if it is the next month, then iterate to next month in list
      if (comparisonMonth != dayIterator.month) {
        monthIndex = monthIndex + 1;
        comparisonMonth = dayIterator.month;
      }

      // prepare content for new month widget: weekdays and placeholder content (weekdays before the first month day)
      if (dayIterator.day == 1) {
        // should place weekdays in one index field

        List<Day> firstDay = [Day(date: dayIterator)];
        calculatedDateList.add(firstDay);

        // add buffer according to weekday
      }
      else {
        calculatedDateList[monthIndex].add(Day(date: dayIterator));
      }
      dayIterator = dayIterator.add(const Duration(days: 1));
    }
    return calculatedDateList;
  }
}

class MonthGrid extends StatelessWidget {
  MonthGrid({required this.dates, required this.month, required this.year});
  final List dates;
  final String month;
  final String year;
  List<String> weekdays = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${month}  -  ${year}'), //ersetzen mit Variablen Monat und Jahr
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 0.8,
          ),
          itemCount: 7,
          itemBuilder: (context, indexWeek) {
            return Container(
              color: Colors.amber,
              child: Text(weekdays[indexWeek]),
            );
          }),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 0.8,
          ),
          itemCount: dates.length,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.amber,
              child: Text(dates[index].day.toString()),
            );
          }),
      ],
    );
  }
}


class Day {
  int fDay = 0;
  int monthNum = 0;
  String monthString = '';
  int year = 0;
  String notes = '';
  //timerange stuff

  Day({required date}){
    day = date.day;
    monthNum = date.month;
    monthString = mapMonthName();
    year = date.year;
  }

  // map numeric month value to named month
  String mapMonthName(){
    List<String> monthNames = ['Januar', 'Februar', 'März', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'];
    return monthNames[monthNum - 1];
  }

  int get day{
    return day;
  }
}