import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectedDayPopup extends StatelessWidget{
  static const String routeDetailView = "/detail_view";
  OverlayEntry overlayEntry;

  SelectedDayPopup({required this.overlayEntry});

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
        ElevatedButton(
          onPressed: (){
            overlayEntry.remove();
            Navigator.pushNamed(
              context, 
              routeDetailView,
            );
          },
          child: Icon(Icons.edit_note_outlined),
        ),
      ],
    );
  }
}