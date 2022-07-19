import 'package:flutter/material.dart';
import '../non_widget/day.dart';

class SelectedDayProvider with ChangeNotifier{
  Day _selectedDay;
  bool _isSelected = false;   // @TODO how long shall you live? until death? changing pages?

  Day get selectedDay => _selectedDay;
  bool get isSelected => _isSelected;

  SelectedDayProvider(this._selectedDay);

  void changeSelection(Day newSelection){

    // selecting gap day
    if(newSelection.day == 0){
      _isSelected = false;
    }
    // selecting different, but valid day
    else{
      _selectedDay = newSelection;
      _isSelected = true;
    }
    notifyListeners();
  }

  void removeSelection(){
    print('this should do something');
    _isSelected = false;
  }
}