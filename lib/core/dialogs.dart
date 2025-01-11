import 'package:flutter/material.dart';
import 'package:notes_app/widgets/dialog/message_dialog.dart';

Future<bool?> showMessageDialog({
  required BuildContext context,
  required String message,
}) {
  return showDialog<bool?>(
    context: context,
    builder: (_) => MessageDialog(message: message)
  );
}