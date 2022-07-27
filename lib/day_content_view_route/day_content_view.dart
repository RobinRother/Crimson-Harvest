import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// --------------------------------------------------------------------------------------------
import 'package:crimson_harvest/providers/selected_day_provider.dart';
import 'package:crimson_harvest/day_content_view_route/note_field.dart';
import 'package:crimson_harvest/non_widget/day.dart';

/// Builds the screen displaying the notefield
/// 
/// Displays content for the selected day
class DayContentView extends StatelessWidget{
  const DayContentView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final Day day = context.watch<SelectedDayProvider>().selectedDay;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.lime.shade200,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 160, 120, 90),
          title: Text('${day.day}. ${day.mapMonthName(context)} ${day.year}'),
          actions: const [
            IconButton(
              onPressed: null,
              icon: Icon(Icons.menu_outlined),
            ),
          ],
        ),
        body: NoteField(activeDayKey: day.key),
      ),
    );
  }
}