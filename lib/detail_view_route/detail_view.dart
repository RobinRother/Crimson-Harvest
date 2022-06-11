import 'package:crimson_harvest/providers/selected_day_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:crimson_harvest/day.dart';

class DetailView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final Day date = context.watch<SelectedDayProvider>().selectedDay;

    return Scaffold(
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
      body: const SizedBox(
        height: double.infinity,
        width: double.infinity, 
        child: Card(
          child: Center(
            child: const Text('DETAIL VIEW !!!!'),
          ),
          color: Colors.blueGrey,
          borderOnForeground: true,
          shape: RoundedRectangleBorder(),
        ),
      ),
    );
  }
}