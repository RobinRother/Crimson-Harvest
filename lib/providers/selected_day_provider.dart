import 'package:flutter/material.dart';
import '../day.dart';

class SelectedDay with ChangeNotifier{
  Day _selectedDay = Day(date: DateTime.utc(1980));
  bool _isSelected = false;   // @TODO how long shall you live? until death? changing pages?

  Day get selectedDay => _selectedDay;
  bool get isSelected => _isSelected;

  void changeSelection(Day newSelection){
    // @TODO tapping outside of grid?
    // selecting the same day
    if(selectedDay == newSelection){
      // not necessarily deselection (e.g. 3 times in a row)
      _isSelected = !_isSelected;
    }
    // selecting gap day
    else if(newSelection.day == 0){
      _isSelected = false;
    }
    // selecting different, but valid day
    else{
      _selectedDay = newSelection;
      _isSelected = true;
    }
    notifyListeners();
  }
}