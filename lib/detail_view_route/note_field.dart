import 'package:flutter/material.dart';

class NoteField extends StatefulWidget{
  @override
  State<NoteField> createState() => _NoteFieldState();
}

class _NoteFieldState extends State<NoteField> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    textController.addListener(() {print(textController.text);});
  }

  @override 
  Widget build(BuildContext context) {
    return Card(
      // enough space to unfocus at bottom
      margin: const EdgeInsets.fromLTRB(64, 64, 64, 128),
      color: Colors.orange,
      borderOnForeground: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: TextField(
          controller: textController,
          onChanged: (text) {
            print('First text field: $text');
          },
          keyboardType: TextInputType.multiline,
          maxLines: null,
          minLines: 10,
          decoration: null
        ),
      ),
    );
  }
}