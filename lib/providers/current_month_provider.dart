import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CurrentMonthProvider with ChangeNotifier{
  final ItemScrollController _itemScrollController = ItemScrollController(); 
  ItemScrollController get itemScrollControler => _itemScrollController;
  DateTime get calendarStart => _calendarStart;
  DateTime get calendarEnd => _calendarEnd;

  // to be moved into config
  final DateTime _calendarStart = DateTime.utc(2020, 1, 1);
  final DateTime _calendarEnd = DateTime.utc(2028, 1, 1);
  // ===

  void scrollToCurrentMonth(){
    _itemScrollController.jumpTo(index: _calcCurrentMonthIndex());
  }

  int _calcCurrentMonthIndex(){
    DateTime today = DateTime.now();
    int index = 0;
    DateTime dateCounter = _calendarStart;

    while(dateCounter.year != today.year || dateCounter.month != today.month){
      index++;
      dateCounter = dateCounter.add(_monthToDuration(dateCounter));
    }
    return index;
  }

  Duration _monthToDuration(DateTime activeDate){
    int days = 0;
    int compare = activeDate.month;
    
    while(compare == activeDate.month){
      days++;
      activeDate = activeDate.add(const Duration(days: 1));
    }
    return Duration(days: days);
  }
}