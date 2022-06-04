import 'package:flutter/material.dart';

class DayGrid extends StatelessWidget{
  DayGrid({required String this.dayString});
  final String dayString;

  @override
  build(BuildContext context){
    return Container(
      color: Colors.amber,
      child: Text(dayString),
    );
  }
}