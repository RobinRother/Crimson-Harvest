import 'package:flutter/material.dart';

class DayGrid extends StatelessWidget{
  DayGrid({required String this.dayString, required this.isGapDay});
  final String dayString;
  final bool isGapDay;

  @override
  build(BuildContext context){
    return Container(
      color: isGapDay ? Colors.white : Colors.amber,
      child: isGapDay ? const Text('') : Text(dayString),
    );
  }
}