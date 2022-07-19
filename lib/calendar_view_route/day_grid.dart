// Stack part https://stackoverflow.com/questions/58443098/how-can-i-remove-the-overlayentry-when-i-click-outside-in-flutter

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

  Map _calcButtonOffset(BuildContext context, RenderBox renderBox){
    Offset position = renderBox.localToGlobal(Offset.zero);
    Size size = renderBox.size;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Map offset = {'x':size.width+8, 'y':size.height*0.75};
    // search for alternative !!!!!!!!!!!!!!!!!!!!!!!!!!!!
    //double buttonSize = 
    
    if(position.dx > screenWidth*0.5){
      offset['x'] = -size.width-12;
    }
    // do i need top limit?
    if(position.dy > screenHeight*0.5){
      offset['y'] = -size.height*0.75;
    }

    return offset;
  }

  void showOverlay(BuildContext context){
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    Map offset = _calcButtonOffset(context, renderBox);
    OverlayState? overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () => overlayEntry.remove(),
              ),
            ),
            Positioned(
              child: SelectedDayPopup(overlayEntry: overlayEntry,),
              left: position.dx + offset['x'],
              top: position.dy + offset['y'],
            )
          ],
        );
      }
    );
    overlayState?.insert(overlayEntry);
  }

  @override
  build(BuildContext context){
    return GestureDetector(
      onTap: () {
        context.read<SelectedDayProvider>().changeSelection(activeDayObject);
        if(!isGapDay){
          showOverlay(context);
        }
      },
      child: Container(
        color: chooseColor(context),
        child: isGapDay ? const Text('') : Text(activeDayObject.day.toString()),
        // @TODO later add borders, etc StyleStuff
      ),
    );
  }
}