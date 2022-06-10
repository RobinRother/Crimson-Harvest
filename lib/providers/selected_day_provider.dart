import 'package:flutter/material.dart';
import '../day.dart';

class SelectedDayProvider with ChangeNotifier{
  Day _selectedDayProvider;
  bool _isSelected = false;   // @TODO how long shall you live? until death? changing pages?

  Day get selectedDayProvider => _selectedDayProvider;
  bool get isSelected => _isSelected;

  SelectedDayProvider(this._selectedDayProvider);

  void changeSelection(Day newSelection){
    // @TODO tapping outside of grid?
    // selecting the same day
    if(selectedDayProvider == newSelection){
      // not necessarily deselection (e.g. 3 times in a row)
      _isSelected = !_isSelected;
    }
    // selecting gap day
    else if(newSelection.day == 0){
      _isSelected = false;
    }
    // selecting different, but valid day
    else{
      _selectedDayProvider = newSelection;
      _isSelected = true;
    }
    notifyListeners();
  }
}