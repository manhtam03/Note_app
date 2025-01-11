import 'package:flutter/material.dart';
import 'package:notes_app/widgets/dialog/dialog_card.dart';
import 'package:notes_app/widgets/button/note_button.dart';

// Dialog xác nhận có hay không
class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key, required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NoteButton(
                onPressed: () => Navigator.pop(context, false),
                isOutLined: true,
                child: Text('No'),
              ),
              SizedBox(width: 5,),
              NoteButton(
                isOutLined: false,
                onPressed: () => Navigator.pop(context, true),
                child: Text('Yes'),
              )
            ],
          )
        ],
      ),
    );
  }
}

