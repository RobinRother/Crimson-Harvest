import 'package:flutter/material.dart';
import '../day.dart';

class SelectedDay with ChangeNotifier{
  Day _selectedDay = Day(date: DateTime.utc(1980));
  bool _isSelected = false;   // how long shall you live? until death? changing pages?

  Day get selectedDay => _selectedDay;
  bool get isSelected => _isSelected;

  void changeSelection(Day newSelection){
    // ignore gap days here?
    // tapping outside of grid?
    if(selectedDay == newSelection){
      // not necessarily deselection (3 times in a row)
      _isSelected = !_isSelected;
    }
    else if(newSelection.day == 0){
      _isSelected = false;
    }
    else{
      _selectedDay = newSelection;
      _isSelected = true;
    }
    notifyListeners();
  }
}