import 'package:crimson_harvest/detail_view_route/note_field.dart';
import 'package:crimson_harvest/providers/selected_day_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:crimson_harvest/day.dart';

class DetailView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final Day date = context.watch<SelectedDayProvider>().selectedDay;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // appbar als festes widget auslagern?
        appBar: AppBar(
          title: Text('${date.day}. ${date.monthName} ${date.year}'),
          actions: const [
            IconButton(
              onPressed: null,
              icon: Icon(Icons.menu_outlined),
            ),
          ],
        ),
        body: NoteField(activeDayKey: date.activeDayKey),
      ),
    );
  }
}