import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/selected_day_provider.dart';
import '../non_widget/day.dart';
import 'package:crimson_harvest/calendar_view_route/day_interaction_overlay.dart';

class DayGrid extends StatelessWidget{
  DayGrid({required Day this.activeDayObject, required this.isGapDay});
  final Day activeDayObject;
  final bool isGapDay;
  static const String routeDetailView = "/detail_view";
  late OverlayEntry overlayEntry;
  final layerLink = LayerLink();

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

  Offset _calculateButtonOffset(BuildContext context, RenderBox renderBox){
    Offset position = renderBox.localToGlobal(Offset.zero);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Size daySize = renderBox.size;
    // how do i get this? !!!!!!!!!!!!!!!!!
    Size buttonSize = Size(150.0, 8.0);
    double offsetWidth = daySize.width + 0;
    double offsetHeight = daySize.height * 0.75;

    if(position.dx > screenWidth*0.6){
      offsetWidth = -buttonSize.width;
    }
    // do i need top limit?
    if(position.dy > screenHeight*0.6){
      offsetHeight = -daySize.height*0.75;
    }

    return Offset(offsetWidth, offsetHeight);
  }

  void _showOverlay(BuildContext context){
    final renderBox = context.findRenderObject() as RenderBox;
    OverlayState? overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                overlayEntry.remove();
              },
            ),
            CompositedTransformFollower(
              showWhenUnlinked: false,
              link: layerLink,
              offset: _calculateButtonOffset(context, renderBox),
              child: DayInteractionOverlay(),
            ),
          ],
        );
      },
    );
    overlayState?.insert(overlayEntry);
  }

  @override
  build(BuildContext context){
    return CompositedTransformTarget(
      link: layerLink,
      child: GestureDetector(
        onDoubleTap: () {
          Navigator.pushNamed(
            context, 
            routeDetailView,
          );
        }, 
        onTap: () {
          context.read<SelectedDayProvider>().changeSelection(activeDayObject);
          if(!isGapDay){
            _showOverlay(context);
          }
        },
        child: Container(
          color: chooseColor(context),
          child: isGapDay ? const Text('') : Text(activeDayObject.day.toString()),
          // @TODO later add borders, etc StyleStuff
        ),
      ),
    );
  }
}