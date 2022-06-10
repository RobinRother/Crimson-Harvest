import 'package:crimson_harvest/day.dart';
import 'package:crimson_harvest/l10n/l10n.dart';
import 'package:crimson_harvest/month_list.dart';
import 'package:crimson_harvest/providers/current_month_provider.dart';
import 'package:crimson_harvest/providers/selected_day_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'providers/current_month_provider.dart';


// TODOS
// change language in app -> currently read from system
// nicer style
// deselection by clicking outside of widget
// nicer styling (borders, ...)
// read preferences from file (no hardcoding anymore)


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SelectedDayProvider(Day(date: DateTime.utc(1980), context: context))),
        ChangeNotifierProvider(create: (_) => CurrentMonthProvider()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Crimson Harvest'),
          actions: [
            IconButton(
              onPressed: () => context.read<CurrentMonthProvider>().scrollToCurrentMonth(3),
              icon: const Icon(Icons.calendar_today_outlined),
            ),
            IconButton(
              onPressed: null, 
              icon: const Icon(Icons.menu_outlined),
            ),
          ],
        ),
        body: MonthList(),
      ),
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}