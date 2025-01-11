import 'package:flutter/material.dart';
import 'package:notes_app/core/constants.dart';

class TagWidgets extends StatelessWidget {
  const TagWidgets({
    super.key, required this.label, this.onClosed, this.onTap,
  });
  final String label;
  final VoidCallback? onClosed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: gray100,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        margin: EdgeInsets.only(right: 4),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                  fontSize: onClosed != null ? 14 : 12,
                  color: gray700
              ),
            ),
            if(onClosed != null) ...[
              SizedBox(width: 4,),
              GestureDetector(
                onTap: onClosed,
                child: Icon(Icons.close, size: 18),
              )
            ]
          ],
        ),
      ),
    );
  }
}
