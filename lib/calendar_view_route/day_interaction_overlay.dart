import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
// --------------------------------------------------------------------------------------------
import 'package:crimson_harvest/providers/date_list_provider.dart';
import 'package:crimson_harvest/non_widget/day.dart';

/// Builds overlay button widget
class DayInteractionOverlay extends StatelessWidget {
  static const String routeDayContentView = "/day_content_view";
  final OverlayEntry overlayEntry;
  late final Box boxTR;
  final Day day;

  DayInteractionOverlay({Key? key, required this.overlayEntry, required this.day}) : super(key: key){
    openBoxTR();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = _fetchScreenSize(context);
    Size buttonSize = _calculateButtonSize(screen);
    Offset buttonPosition = _calculateButtonPosition(screen, buttonSize);
    bool inFuture = DateTime.utc(day.year, day.monthNum, day.day).isAfter(DateTime.now());

    return Positioned(
      left: buttonPosition.dx,
      top: buttonPosition.dy,
      child: Column(
        children: [
          ElevatedButton(
            child: Text(_getTimeRangeButtonValue(context)),
            // start is unselectable for future days
            onPressed: inFuture ? null : () async {
              if(day.inTimeRange){
                await stopTimeRange(context);
              }
              else{
                await startTimeRange(context);
              }
            }, 
            style: ElevatedButton.styleFrom(
              fixedSize: buttonSize,
              primary: const Color.fromARGB(255, 160, 120, 90),
            ),
          ),
          ElevatedButton(
            child: const Icon(Icons.edit_note_outlined),
            onPressed: () {
              overlayEntry.remove();
              Navigator.pushNamed(
                context, 
                routeDayContentView,
              );
            }, 
            style: ElevatedButton.styleFrom(
              fixedSize: buttonSize,
              primary: const Color.fromARGB(255, 160, 120, 90),
            ),
          ),
        ],
      ),
    );
  }

  /// Screen size is needed to calculate the button size and position.
  Size _fetchScreenSize(BuildContext context){
    return Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
  }

  Size _calculateButtonSize(Size screen){
    return Size(screen.width/4, screen.height/10);    
  }

  Offset _calculateButtonPosition(Size screen, Size buttonSize){
    return Offset(screen.width - buttonSize.width, screen.height - buttonSize.height * 2);
  }

  /// Displays start or end as the button value
  String _getTimeRangeButtonValue(BuildContext context){
    if(day.inTimeRange){
      return AppLocalizations.of(context)?.end ?? "end";
    }
    return AppLocalizations.of(context)?.start ?? "start";
  }

  /// opens Hive box to make it accessible
  void openBoxTR() async {
    boxTR = await Hive.openBox('boxTR');
  }

  /// Marks day as start of timerange.
  /// 
  /// Called when button "start" is pressed.
  Future<void> startTimeRange(BuildContext context) async {
    boxTR.put(day.key, "first");
    context.read<DateListProvider>().saveTimeRangeStatus();
    overlayEntry.remove();
  }

  /// Marks day as end of timerange.
  /// 
  /// Called when button "end" is pressed.
  Future<void> stopTimeRange(BuildContext context) async {

    // deletes whole timerange when the first day is selected
    if(boxTR.get(day.key) == "first"){
      context.read<DateListProvider>().deleteOldLast(day);
      boxTR.delete(day.key);
    }
    else{
      boxTR.put(day.key, "last");
      context.read<DateListProvider>().deleteOldLast(day);
    }
    context.read<DateListProvider>().saveTimeRangeStatus();
    overlayEntry.remove();
  }
}