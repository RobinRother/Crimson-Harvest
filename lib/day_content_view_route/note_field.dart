import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Displays and saves notes of selected day
class NoteField extends StatefulWidget{
  const NoteField({Key? key, required this.activeDayKey}) : super(key: key);
  
  final String activeDayKey;

  @override
  State<NoteField> createState() => _NoteFieldState();
}

class _NoteFieldState extends State<NoteField> {
  final textController = TextEditingController();
  late Box notesBox;

  @override
  void dispose() {
    textController.dispose();
    notesBox.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    textController.addListener((){});
    createOpenBox();
  }

  void createOpenBox() async {
    notesBox = await Hive.openBox('notesBox');
    getNotes();
  }

  void saveNotes() {
    notesBox.put(widget.activeDayKey, textController.value.text);
  }

  /// Displays saved notes.
  void getNotes(){
    if(notesBox.get(widget.activeDayKey) != null){
      textController.text = notesBox.get(widget.activeDayKey);
      setState(() {});
    }
  }

  @override 
  Widget build(BuildContext context) {
    return Card(
      // enough space to unfocus at bottom
      margin: const EdgeInsets.fromLTRB(64, 64, 64, 128),
      color: const Color.fromARGB(255, 255, 253, 237),
      borderOnForeground: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: TextField(
          controller: textController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          minLines: 10,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffix: IconButton(
              onPressed: (){
                saveNotes();
                FocusScope.of(context).unfocus();
              },
              icon: const Icon(Icons.check),
            ),
          ),
        ),
      ),
    );
  }
}