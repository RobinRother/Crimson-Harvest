import 'package:crimson_harvest/calendar_view_route/selected_day_popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/selected_day_provider.dart';
import '../non_widget/day.dart';

class DayGrid extends StatelessWidget{
  DayGrid({Key? key, required Day this.activeDayObject, required this.isGapDay}) : super(key: key);
  final Day activeDayObject;
  final bool isGapDay;
  static const String routeDetailView = "/detail_view";
  late OverlayEntry overlayEntry;

  bool isCurrentDay(){    // function or variable
    DateTime currentDay = DateTime.now();
    if(currentDay.year == activeDayObject.year && currentDay.month == activeDayObject.monthNum && currentDay.day == activeDayObject.day){
      return true;
    }
    return false;
  }

  Color chooseColor(BuildContext context){
    bool activeDayObjectIsSelected = context.watch<SelectedDayProvider>().isSelected && context.watch<SelectedDayProvider>().selectedDay == activeDayObject;

    // @TODO later add current day selection
    // @TODO code colours in settings
    if(isGapDay){
      return Colors.white;
    }
    else if(activeDayObjectIsSelected){
      return Colors.deepOrange;
    }
    else if(isCurrentDay()){
      return Colors.pink;
    }
    else{
      return Colors.amber;
    }
  }

  void showOverlay(BuildContext context){
    OverlayState? overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            SelectedDayPopup(),
            Positioned.fill(
              child: GestureDetector(
                onTap: () => overlayEntry.remove(),
              ),
            ),
          ],
        );
      }
    );
    overlayState?.insert(overlayEntry);
  }

  @override
  build(BuildContext context){
    return GestureDetector(
      onDoubleTap: () {
        Navigator.pushNamed(
          context, 
          routeDetailView,
        );
      }, 
      onTap: () {
        context.read<SelectedDayProvider>().changeSelection(activeDayObject);
        showOverlay(context);
      },
      child: Container(
        color: chooseColor(context),
        child: isGapDay ? const Text('') : Text(activeDayObject.day.toString()),
        // @TODO later add borders, etc StyleStuff
      ),
    );
  }
}