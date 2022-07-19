import 'package:flutter/material.dart';

class DayInteractionOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          child: Text('ZU ERSETZEN!'),
          onPressed: null, 
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(24),
          ),
        ),
        ElevatedButton(
          // size of icon
          child: Icon(Icons.edit_note_outlined),
          onPressed: null, 
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(24),
            
          ),
        ),
      ],
    );
  }
}