import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
// --------------------------------------------------------------------------------------------
import 'package:crimson_harvest/providers/date_list_provider.dart';
import 'package:crimson_harvest/non_widget/day.dart';

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

    return Positioned(
      left: buttonPosition.dx,
      top: buttonPosition.dy,
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
              fixedSize: buttonSize,
            ),
          ),
          ElevatedButton(
            // size of icon
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
            ),
          ),
        ],
      ),
    );
  }

  Size _fetchScreenSize(BuildContext context){
    return Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
  }

  Size _calculateButtonSize(Size screen){
    return Size(screen.width/4, screen.height/10);    
    //factor in settings?
  }

  Offset _calculateButtonPosition(Size screen, Size buttonSize){
    return Offset(screen.width - buttonSize.width, screen.height - buttonSize.height * 2);
    //factor in settings?
  }

  String _getTimeRangeButtonValue(BuildContext context){
    if(day.inTimeRange){
      return AppLocalizations.of(context)?.end ?? "end";
    }
    return AppLocalizations.of(context)?.start ?? "start";
  }

  void openBoxTR() async {
    boxTR = await Hive.openBox('boxTR');
  }

  Future<void> startTimeRange(BuildContext context) async {
    boxTR.put(day.key, "first");
    context.read<DateListProvider>().saveTimeRangeStatus();
    overlayEntry.remove();
  }

  Future<void> stopTimeRange(BuildContext context) async {
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