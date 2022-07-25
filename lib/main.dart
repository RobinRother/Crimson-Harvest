import 'package:crimson_harvest/calendar_view_route/day_interaction_overlay.dart';
import 'package:crimson_harvest/calendar_view_route/web_view_container.dart';
import 'package:crimson_harvest/providers/date_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:crimson_harvest/calendar_view_route/calendar_view.dart';
import 'package:crimson_harvest/detail_view_route/detail_view.dart';
import 'package:crimson_harvest/non_widget/day.dart';
import 'package:crimson_harvest/l10n/l10n.dart';
import 'package:crimson_harvest/providers/current_month_provider.dart';
import 'package:crimson_harvest/providers/selected_day_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'providers/current_month_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

// TODOS
// change language in app -> currently read from system
// nicer styling (borders, ...)
// read preferences from file (no hardcoding anymore)
// update today when day changes?
// ausgrauen der start box in future
// hide loading behind splash screen
// move github link into sidebar
// add settings to sidebar

void main() async {
  await Hive.initFlutter();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SelectedDayProvider(Day(date: DateTime.utc(1980)))),
        ChangeNotifierProvider(create: (_) => CurrentMonthProvider()),
        ChangeNotifierProvider(create: (_) => DateListProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => CalendarView(),
          DayInteractionOverlay.routeDetailView: (context) => DetailView(),
          CalendarView.routeWebView: (context) => WebViewContainer(),
        },
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,    // do i need this
          GlobalWidgetsLocalizations.delegate,
        ],
      ),
    )
  );
}

