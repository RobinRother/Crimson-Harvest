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

class MonthList extends StatelessWidget {
  const MonthList({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    List dateList =
        calcDates(DateTime.utc(2018, 1, 1), DateTime.utc(2018, 6, 1));

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            //shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return MonthGrid(
                  dates: dateList[index]); // needs only one month!!
            },
            //separatorBuilder: (BuildContext context, int index) => const Divider(),
            itemCount: dateList.length,
          ),
        ),
      ],
    );
  }

  calcDates(DateTime calendarStart, DateTime calendarEnd) {
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
        List<String> weekdays = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];
        calculatedDateList.add(weekdays);

        // add buffer according to weekday
      }

      calculatedDateList[monthIndex].add(dayIterator.day.toString());
      dayIterator = dayIterator.add(const Duration(days: 1));
    }
    return calculatedDateList;
  }
}

class MonthGrid extends StatelessWidget {
  MonthGrid({required this.dates});
  final List dates;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Monatsname'), //ersetzen mit Variablen Monat und Jahr
        GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemCount: dates.length,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.amber,
                child: Text('${dates[index]}'),
              );
            }),
      ],
    );
  }
}
