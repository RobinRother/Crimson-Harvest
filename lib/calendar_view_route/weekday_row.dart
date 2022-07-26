import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeekdayRow extends StatelessWidget{
  const WeekdayRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> weekdays = [
      AppLocalizations.of(context)?.rowMonday ?? "mo",
      AppLocalizations.of(context)?.rowTuesday ?? "tu",
      AppLocalizations.of(context)?.rowWednesday ?? "we",
      AppLocalizations.of(context)?.rowThursday ?? "th",
      AppLocalizations.of(context)?.rowFriday ?? "fr",
      AppLocalizations.of(context)?.rowSaturday ?? "sa",
      AppLocalizations.of(context)?.rowSunday ?? "su",
    ];

    return Container(
      //padding: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.fromLTRB(36, 0, 36, 0),
      color: const Color.fromARGB(180, 190, 145, 111),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1.3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: 7,
        itemBuilder: (context, index){
          return Center(
            child: Text(
              weekdays[index],
              textScaleFactor: 1.2,
            ),
          );
        },
      ),
    );
  }
}