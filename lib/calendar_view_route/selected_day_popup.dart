import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectedDayPopup extends StatelessWidget{
  String _getTimeSpanButtonValue(BuildContext context){
    // if ... return AppLocalizations.of(context)?.end ?? "";

    return AppLocalizations.of(context)?.start ?? "";
  }
  
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        ElevatedButton(
          onPressed: null, 
          child: Text(_getTimeSpanButtonValue(context))
        ),
        const ElevatedButton(
          onPressed: null,
          child: Icon(Icons.edit_note_outlined),
        ),
      ],
    );
  }
}