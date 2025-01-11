import 'package:flutter/material.dart';

class DialogCard extends StatelessWidget {
  const DialogCard({
    super.key, this.child,
  });
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.75,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2, color: Colors.black),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(
                offset: Offset(4, 4),
              )]
          ),
          child: child,
        ),
      ),
    );
  }
}