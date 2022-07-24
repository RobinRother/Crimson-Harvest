import 'package:crimson_harvest/providers/date_list_provider.dart';
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
  }

  void createBoxTR() async {
    boxTR = await Hive.openBox('boxTR');
    
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
                dates: context.watch<DateListProvider>().dateList[index],
                //passing attributes of first day each to create header -- gap day already has correct month/ year
                month: context.watch<DateListProvider>().dateList[index][0].mapMonthName(context),
                year: context.watch<DateListProvider>().dateList[index][0].year.toString(),
              );
            },
            itemCount: context.watch<DateListProvider>().dateList.length,
          ),
        ),
      ],
    );
  }


}