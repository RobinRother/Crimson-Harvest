import 'package:flutter/material.dart';

class NoteField extends StatelessWidget{
  @override 
  Widget build(BuildContext context) {
    return const SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.all(32),
        color: Colors.orange,
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: TextField(
              maxLines: null,
              decoration: null,
            ),
          ),
      ),
    );
  }
}