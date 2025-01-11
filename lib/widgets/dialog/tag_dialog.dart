import 'package:flutter/material.dart';
import 'package:notes_app/widgets/dialog/dialog_card.dart';
import 'package:notes_app/widgets/button/note_button.dart';
import 'package:notes_app/widgets/note_form_field.dart';

class TagDialog extends StatefulWidget {
  const TagDialog({
    super.key, this.tag,
  });

  final String? tag;
  @override
  State<TagDialog> createState() => _TagDialogState();
}

class _TagDialogState extends State<TagDialog> {
  late final TextEditingController tagController;
  late final GlobalKey<FormFieldState> tagKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tagController = TextEditingController(text: widget.tag);
    tagKey = GlobalKey();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add tag',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 32,),
          NoteFormField(
              key: tagKey,
              controller: tagController,
              autofocus: true,
              hintText: 'Add tag (< 16 characters)',
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'No tags added';
                } else if (value.trim().length > 16) {
                  return 'Tags should not be more than 16 characters';
                }
                return null;
              },
              onChanged: (value) {
                tagKey.currentState?.validate();
              },
          ),
          SizedBox(height: 32,),
          NoteButton(
              child: Text('Add tag'),
              onPressed: () {
                if (tagKey.currentState?.validate() ?? false) {
                  Navigator.pop(context, tagController.text.trim());
                }
              },
          ),
        ],
      ),
    );
  }
}
