import 'package:flutter/material.dart';
// --------------------------------------------------------------------------------------------
import 'package:crimson_harvest/non_widget/day.dart';

/// Provider containing all variables/ methods necessary to select and deselct days.
class SelectedDayProvider with ChangeNotifier{
  Day _selectedDay;
  bool _isSelected = false;

  Day get selectedDay => _selectedDay;
  bool get isSelected => _isSelected;

  SelectedDayProvider(this._selectedDay);

  /// Switches [selectedDay] to new valid selection
  void changeSelection(Day newSelection){
    // selecting gap day
    if(newSelection.day == 0){
      _isSelected = false;
    }
    // selecting valid day
    else{
      _selectedDay = newSelection;
      _isSelected = true;
    }
    notifyListeners();
  }

  /// Deselects a day
  void removeSelection(){
    _isSelected = false;
    notifyListeners();
  }
}