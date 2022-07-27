import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// --------------------------------------------------------------------------------------------
import 'package:crimson_harvest/providers/selected_day_provider.dart';
import 'package:crimson_harvest/providers/date_list_provider.dart';
import 'package:crimson_harvest/non_widget/day.dart';
import 'package:crimson_harvest/calendar_view_route/day_interaction_overlay.dart';


/// Displays a selectable day.
// ignore: must_be_immutable
class DayGrid extends StatelessWidget{
  DayGrid({Key? key, required this.activeDayObject, required this.isGapDay}) : super(key: key);
  final Day activeDayObject;
  final bool isGapDay;    // empty space at beginning when month doesnt start at monday
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
        child: isGapDay ? const Text('') : Padding(
          padding: const EdgeInsets.all(3),
          child: Text(activeDayObject.day.toString())
        ),
        decoration: BoxDecoration(
          color: chooseColor(context),
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: chooseBorderColor(context), 
            width: 3,
          ),
        ),
      ),
    );
  }

  Color chooseBorderColor(BuildContext context){
    /// Returns border color depending on the day role.

    bool today = context.watch<DateListProvider>().isCurrentDay(activeDayObject);

    if(today){
      return Colors.redAccent;
    }
    return chooseColor(context);
  }

  Color chooseColor(BuildContext context){
    /// Returns container color depending on the day role.

    bool activeDayObjectIsSelected = context.watch<SelectedDayProvider>().isSelected && context.watch<SelectedDayProvider>().selectedDay == activeDayObject;

    if(isGapDay){
      return const Color.fromARGB(255, 255, 253, 237);
    }
    else if(activeDayObjectIsSelected){
      return Colors.amber.shade100;
    }
    else if(activeDayObject.inTimeRange){
      return Colors.amber.shade700;
    }
    else{
      return Colors.amber.shade300;
    }
  }

    /// Displays overlay buttons
    /// 
    /// Displays buttons (start/ end, edit notes) when selecting a day.
  void _showOverlay(BuildContext context){
    OverlayState? overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // removes overlay buttons when clicking outside
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