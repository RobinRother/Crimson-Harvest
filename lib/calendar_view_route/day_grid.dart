import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:crimson_harvest/providers/selected_day_provider.dart';
import 'package:crimson_harvest/providers/date_list_provider.dart';

import 'package:crimson_harvest/non_widget/day.dart';
import 'package:crimson_harvest/calendar_view_route/day_interaction_overlay.dart';

// const vs final vs late: help
class DayGrid extends StatelessWidget{
  DayGrid({Key? key, required this.activeDayObject, required this.isGapDay}) : super(key: key);
  final Day activeDayObject;
  final bool isGapDay;
  late OverlayEntry overlayEntry;

  @override
  build(BuildContext context){
    return GestureDetector(
      onTap: () {
        context.read<SelectedDayProvider>().changeSelection(activeDayObject);
        if(!isGapDay){
          _showOverlay(context);
        }
      },
      child: Container(
        color: chooseColor(context),
        child: isGapDay ? const Text('') : Text(activeDayObject.day.toString()),
      ),
    );
  }

  Color chooseColor(BuildContext context){
    bool activeDayObjectIsSelected = context.watch<SelectedDayProvider>().isSelected && context.watch<SelectedDayProvider>().selectedDay == activeDayObject;
    bool today = context.watch<DateListProvider>().isCurrentDay(activeDayObject);

    // @TODO later add current day selection
    // @TODO code colours in settings
    if(isGapDay){
      return Colors.white;
    }
    else if(activeDayObject.inTimeRange && today){
      return Colors.cyan;
    }
    else if(activeDayObjectIsSelected){
      return Colors.deepOrange;
    }
    else if(activeDayObject.inTimeRange && !today){
      return Colors.teal;
    }
    
    else if(today && !activeDayObject.inTimeRange){
      return Colors.pink;
    }
    else{
      return Colors.amber;
    }
  }

  void _showOverlay(BuildContext context){
    OverlayState? overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                overlayEntry.remove();
                context.read<SelectedDayProvider>().removeSelection();
              },
            ),
            DayInteractionOverlay(
              overlayEntry: overlayEntry, 
              day: activeDayObject
            ),
          ],
        );
      },
    );
    overlayState?.insert(overlayEntry);
  }
}