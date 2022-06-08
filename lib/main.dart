import 'package:crimson_harvest/providers/selected_day_provider.dart';
import 'package:flutter/material.dart';
import 'calendar_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      child: MyApp(),
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedDay()),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return MaterialApp(      
      home: Scaffold(
        appBar: AppBar(),
        body: CalendarView(),
      ),
    );
  }
}