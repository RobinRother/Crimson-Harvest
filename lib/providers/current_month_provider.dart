import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

/// Provider containing all variables/ methods necessary to scroll to the current month.
class CurrentMonthProvider with ChangeNotifier{
  final ItemScrollController _itemScrollController = ItemScrollController(); 
  ItemScrollController get itemScrollControler => _itemScrollController;
  DateTime get calendarStart => _calendarStart;
  DateTime get calendarEnd => _calendarEnd;

  // to be moved into config
  final DateTime _calendarStart = DateTime.utc(DateTime.now().year - 5, 1, 1);
  final DateTime _calendarEnd = DateTime.utc(DateTime.now().year + 5, 1, 1);
  // ===

  void scrollToCurrentMonth(){
    _itemScrollController.jumpTo(index: _calculateCurrentMonthIndex());
  }

  /// Calculates target index (current month) for scrolling [scrollToCurrentMonth]
  int _calculateCurrentMonthIndex(){
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