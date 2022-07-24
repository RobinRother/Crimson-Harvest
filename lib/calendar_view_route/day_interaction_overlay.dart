import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:crimson_harvest/non_widget/day.dart';

class DayInteractionOverlay extends StatefulWidget {
  static const String routeDetailView = "/detail_view";
  OverlayEntry overlayEntry;
  Day day;
  late Box boxTR;
  void openBoxTR() async {
    boxTR = await Hive.openBox('boxTR');
  }

  DayInteractionOverlay({required this.overlayEntry, required this.day}){
    openBoxTR();
  }

  @override
  State<DayInteractionOverlay> createState() => _DayInteractionOverlayState();
}

class _DayInteractionOverlayState extends State<DayInteractionOverlay> {


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
    if(widget.day.inTimeRange){
      return AppLocalizations.of(context)?.end ?? "";
    }
    return AppLocalizations.of(context)?.start ?? "";
  }



  Future<void> startTimeRange() async {
    widget.boxTR.put(widget.day.activeDayKey, "first");
    print('shithead');
    setState(() {
      
    });
  }

  Future<void> stopTimeRange() async {
    if(widget.boxTR.get(widget.day.activeDayKey) == "first"){
      print('before');
      widget.boxTR.delete(widget.day.activeDayKey);
      print('after');
    }
    else{
      widget.boxTR.put(widget.day.activeDayKey, "last");
    }
    setState(() {
      
    });
  }

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
              if(widget.day.inTimeRange){
                await stopTimeRange();
              }
              else{
                await startTimeRange();
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
              widget.overlayEntry.remove();
              Navigator.pushNamed(
                context, 
                DayInteractionOverlay.routeDetailView,
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