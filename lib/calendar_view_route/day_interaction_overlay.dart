import 'package:crimson_harvest/providers/date_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:crimson_harvest/non_widget/day.dart';
import 'package:provider/provider.dart';

class DayInteractionOverlay extends StatelessWidget {
  static const String routeDetailView = "/detail_view";
  OverlayEntry overlayEntry;
  late Box boxTR;
  Day day;

  DayInteractionOverlay({required this.overlayEntry, required this.day}){
    openBoxTR();
  }

  Size _calculateButtonSize(BuildContext context){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Size(screenWidth/4, screenHeight/10);
  }

  Offset _calculateButtonPosition(BuildContext context){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Size buttonSize = _calculateButtonSize(context);

    return Offset(screenWidth - buttonSize.width, screenHeight - buttonSize.height * 2);
  }

  String _getTimeRangeButtonValue(BuildContext context){
    if(day.inTimeRange){
      return AppLocalizations.of(context)?.end ?? "";
    }
    return AppLocalizations.of(context)?.start ?? "";
  }

  void openBoxTR() async {
    boxTR = await Hive.openBox('boxTR');
  }

  // abfangen von nach current day?
  Future<void> startTimeRange(BuildContext context) async {
    boxTR.put(day.activeDayKey, "first");
    context.read<DateListProvider>().saveTimeRangeStatus();
  }

  Future<void> stopTimeRange(BuildContext context) async {
    if(boxTR.get(day.activeDayKey) == "first"){
      context.read<DateListProvider>().deleteOldLast(day);
      boxTR.delete(day.activeDayKey);
    }
    else{
      boxTR.put(day.activeDayKey, "last");
      context.read<DateListProvider>().deleteOldLast(day);
    }

    context.read<DateListProvider>().saveTimeRangeStatus();
  }
    //doesnt work when:
    // first setting end somewhere in tr
    // when deleting first element:
    // end element stays

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _calculateButtonPosition(context).dx,
      top: _calculateButtonPosition(context).dy,
      child: Column(
        children: [
          ElevatedButton(
            child: Text(_getTimeRangeButtonValue(context)),
            onPressed: () async {
              if(day.inTimeRange){
                await stopTimeRange(context);
              }
              else{
                await startTimeRange(context);
              }
            }, 
            style: ElevatedButton.styleFrom(
              fixedSize: _calculateButtonSize(context),
              padding: EdgeInsets.all(24),
            ),
          ),
          ElevatedButton(
            // size of icon
            child: Icon(Icons.edit_note_outlined),
            onPressed: () {
              overlayEntry.remove();
              Navigator.pushNamed(
                context, 
                routeDetailView,
              );
            }, 
            style: ElevatedButton.styleFrom(
              fixedSize: _calculateButtonSize(context),
            ),
          ),
        ],
      ),
    );
  }
}