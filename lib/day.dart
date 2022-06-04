class Day {
  int _day = -1;
  int _monthNum = 0;
  String _monthName = '';
  int _year = 0;
  String _notes = '';
  bool isSelected = false;
  //timerange stuff

  Day({required date}){
    _day = date.day;
    _monthNum = date.month;
    _monthName = mapMonthName();
    _year = date.year;
  }

  // to create Day with an invalid day value as gap day
  // month and year are still accurate to create gridviewheading
  Day.placeholder({required date}){
    _monthNum = date.month;
    _monthName = mapMonthName();
    _year = date.year;
  }

  // map numeric month value to named month
  String mapMonthName(){
    List<String> months = ['Januar', 'Februar', 'März', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'];
    return months[_monthNum - 1];
  }

  int get day{
    return _day;
  }

  int get monthNum{
    return _monthNum;
  }

  String get monthName{
    return _monthName;
  }

  int get year{
    return _year;
  }
}