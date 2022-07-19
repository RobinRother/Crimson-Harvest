import 'package:flutter/material.dart';

class DayInteractionOverlay extends StatelessWidget {
  static const String routeDetailView = "/detail_view";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          child: Text('ZU ERSETZEN!'),
          onPressed: null, 
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(40),
          ),
        ),
        ElevatedButton(
          // size of icon
          child: Icon(Icons.edit_note_outlined),
          onPressed: () {
            Navigator.pushNamed(
              context, 
              routeDetailView,
            );
          }, 
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(40),
          ),
        ),
      ],
    );
  }
}