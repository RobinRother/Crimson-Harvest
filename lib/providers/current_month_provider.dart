import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CurrentMonthProvider with ChangeNotifier{
  ItemScrollController _itemScrollController = ItemScrollController(); 
  ItemScrollController get itemScrollControler => _itemScrollController;

  void scrollToCurrentMonth(int currentMonthIndex){
    _itemScrollController.jumpTo(index: currentMonthIndex);
  }
}