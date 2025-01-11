import 'package:flutter/material.dart';
import 'package:notes_app/widgets/dialog/dialog_card.dart';
import 'package:notes_app/widgets/button/note_button.dart';

// Dialog xác nhận có hay không
class MessageDialog extends StatelessWidget {
  const MessageDialog({
    super.key, required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
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
                onPressed: () => Navigator.pop(context),
                isOutLined: true,
                child: Text('OK'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

