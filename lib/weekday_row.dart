import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeekdayRow extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    List<String> weekdays = [
      AppLocalizations.of(context)?.rowMonday ?? "",
      AppLocalizations.of(context)?.rowTuesday ?? "",
      AppLocalizations.of(context)?.rowWednesday ?? "",
      AppLocalizations.of(context)?.rowThursday ?? "",
      AppLocalizations.of(context)?.rowFriday ?? "",
      AppLocalizations.of(context)?.rowSaturday ?? "",
      AppLocalizations.of(context)?.rowSunday ?? "",
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemCount: 7,
      itemBuilder: (context, index){
        return Container(
          color: Colors.limeAccent,
          child: Text(weekdays[index]),
        );
      },
    );
  }
}