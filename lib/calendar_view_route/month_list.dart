import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';
// --------------------------------------------------------------------------------------------
import 'package:crimson_harvest/providers/current_month_provider.dart';
import 'package:crimson_harvest/providers/date_list_provider.dart';
import 'package:crimson_harvest/calendar_view_route/month_grid.dart';
import 'package:crimson_harvest/calendar_view_route/weekday_row.dart';

class MonthList extends StatefulWidget {
  const MonthList({Key? key}) : super(key: key);

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
    ItemScrollController _itemScrollController = context.watch<CurrentMonthProvider>().itemScrollControler;

    return Column(
      children: [
        const WeekdayRow(),
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