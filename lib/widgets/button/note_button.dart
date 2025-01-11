import 'package:flutter/material.dart';
import 'package:notes_app/core/constants.dart';

class NoteButton extends StatelessWidget {
  const NoteButton({
    super.key,
    required this.child,
    this.onPressed,
    this.isOutLined = false,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final bool isOutLined;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(2, 2),
                  color: isOutLined ? primary : Colors.black
              )
            ],
            borderRadius: BorderRadius.circular(8)
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isOutLined ? Colors.white : primary,
            foregroundColor: isOutLined ? primary : Colors.white,
            disabledBackgroundColor: gray300,
            disabledForegroundColor: Colors.black,
            side: BorderSide(color: isOutLined ? primary: Colors.black),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: child,
        )
    );
  }
}
