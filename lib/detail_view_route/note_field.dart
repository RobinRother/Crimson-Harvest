import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteField extends StatefulWidget{
  final String activeDayKey;
  const NoteField({Key? key, required this.activeDayKey}) : super(key: key);

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
    textController.addListener(() {print(textController.text);});
    createOpenBox();
  }

  void createOpenBox() async {
    notesBox = await Hive.openBox('notesBox');
    getNotes();
  }

  void saveNotes() {
    notesBox.put(widget.activeDayKey, textController.value.text);
  }

  void getNotes(){
    if(notesBox.get(widget.activeDayKey) != null){
      textController.text = notesBox.get(widget.activeDayKey);
      setState(() {
        
      });
    }
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
          onTap: saveNotes, // ontap is dumb -> but how, arrow back?
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