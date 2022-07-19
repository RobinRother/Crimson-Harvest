import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DayInteractionOverlay extends StatelessWidget {
  static const String routeDetailView = "/detail_view";

  String _getTimeSpanButtonValue(BuildContext context){
    // if ... return AppLocalizations.of(context)?.end ?? "";

    return AppLocalizations.of(context)?.start ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          child: Text(_getTimeSpanButtonValue(context)),
          onPressed: null, 
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(40),
          ),
        ),
        ElevatedButton(
          // size of icon
          child: Icon(Icons.edit_note_outlined),
          onPressed: () {
            Navigator.pushNamed(
              context, 
              routeDetailView,
            );
          }, 
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(40),
          ),
        ),
      ],
    );
  }
}