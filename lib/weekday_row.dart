import 'package:flutter/material.dart';

class WeekdayRow extends StatelessWidget{
  List<String> weekdays = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 0.8,
      ),
      itemCount: 7,
      itemBuilder: (context, index){
        return Container(
          color: Colors.limeAccent,
          child: Text(weekdays[index]),
        );
      },
    );
  }
}