import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/selected_day_provider.dart';
import 'day.dart';

class DayGrid extends StatelessWidget{
  DayGrid({required Day this.activeDayObject, required this.isGapDay});
  final Day activeDayObject;
  final bool isGapDay;

  Color chooseColor(BuildContext context){
    bool activeDayObjectIsSelected = context.watch<SelectedDay>().isSelected && context.watch<SelectedDay>().selectedDay == activeDayObject;

    // ignore gap day selection here?

    // later add current day selection
    if(isGapDay){
      return Colors.white;
    }
    else if(activeDayObjectIsSelected){
      return Colors.deepOrange;
    }
    else{
      return Colors.amber;
    }
  }

  @override
  build(BuildContext context){
    return GestureDetector(
      onTap: () => context.read<SelectedDay>().changeSelection(activeDayObject),
      child: Container(
        color: chooseColor(context),
        child: isGapDay ? const Text('') : Text(activeDayObject.day.toString()),
      ),
    );
  }
}