import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Holds day information additional to [DateTime] object.
class Day {
  int _day = 0;
  late int _monthNum;
  late int _year;
  String _key = '';
  bool _inTimeRange = false;

  Day({required date}){
    _day = date.day;
    _monthNum = date.month;
    _year = date.year;
    _key = date.toString();
  }

  /// Creates [Day] object with an invalid day value (= 0)
  // to create Day with an invalid day value as gap day
  // month and year are still accurate to create gridviewheading
  Day.placeholder({required date}){
    _monthNum = date.month;
    _year = date.year;
  }

  // map numeric month value to named month
  String mapMonthName(context){
    List<String> months = [
      AppLocalizations.of(context)?.january ?? "",
      AppLocalizations.of(context)?.february ?? "",
      AppLocalizations.of(context)?.march ?? "",
      AppLocalizations.of(context)?.april ?? "",
      AppLocalizations.of(context)?.may ?? "",
      AppLocalizations.of(context)?.june ?? "",
      AppLocalizations.of(context)?.july ?? "",
      AppLocalizations.of(context)?.august ?? "",
      AppLocalizations.of(context)?.september ?? "",
      AppLocalizations.of(context)?.october ?? "",
      AppLocalizations.of(context)?.november ?? "",
      AppLocalizations.of(context)?.december ?? "",
    ];
    return months[_monthNum - 1];
  }

  int get day => _day;

  int get monthNum => _monthNum;

  int get year => _year;

  String get key => _key;

  bool get inTimeRange => _inTimeRange;
  set inTimeRange(value) => _inTimeRange = value;
}