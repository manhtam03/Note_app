import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/change_notifier/new_note_controller.dart';
import 'package:notes_app/core/constants.dart';
import 'package:notes_app/widgets/button/note_icon_button_outlined.dart';
import 'package:notes_app/widgets/note_metadata.dart';
import 'package:notes_app/widgets/note_toolbar.dart';
import 'package:notes_app/widgets/dialog/confirmation_dialog.dart';

class NewOrEditNotePage extends StatefulWidget {
  final bool isNewNote;

  const NewOrEditNotePage({super.key, required this.isNewNote});

  @override
  State<NewOrEditNotePage> createState() => _NewOrEditNotePageState();
}

class _NewOrEditNotePageState extends State<NewOrEditNotePage> {
  late final NewNoteController newNoteController;
  late final QuillController quillController;
  late final TextEditingController titleController;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    newNoteController = context.read<NewNoteController>();
    titleController = TextEditingController(text: newNoteController.title);
    quillController = QuillController.basic()..addListener(() {
        newNoteController.content = quillController.document;
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isNewNote) {
        focusNode.requestFocus();
        newNoteController.readOnly = false;
      } else {
        newNoteController.readOnly = true;
        quillController.document = newNoteController.content;
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    quillController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        if(!newNoteController.canSaveNote) {
          Navigator.pop(context);
          return;
        }

        final bool? shouldSave = await showDialog<bool?>(
          context: context,
          builder: (_) => ConfirmationDialog(title: 'Do you want to save the note?')
        );
        if (shouldSave == null) return;
        if(!context.mounted) return;
        if(shouldSave) {
          newNoteController.saveNote(context);
        }
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isNewNote ? 'New Note' : 'Edit Note'),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: NoteIconButtonOutlined(
                icon: FontAwesomeIcons.chevronLeft,
                onPressed: () {
                  Navigator.maybePop(context);
                }
            ),
          ),
          actions: [
            Selector<NewNoteController, bool>(
              selector: (context, newNoteController) => newNoteController.readOnly,
              builder: (context, readOnly, child) => NoteIconButtonOutlined(
                  icon: readOnly ? FontAwesomeIcons.pen : FontAwesomeIcons.bookOpen,
                  onPressed: () {
                    newNoteController.readOnly = !readOnly;
                    if (newNoteController.readOnly) {
                      FocusScope.of(context).unfocus();
                    } else {
                      FocusScope.of(context).requestFocus();
                    }
                  },
              ),
            ),
            Selector<NewNoteController, bool>(
              selector: (_, newNoteController) => newNoteController.canSaveNote,
              builder: (_, canSaveNote, __) => NoteIconButtonOutlined(
                  icon: FontAwesomeIcons.check,
                  onPressed: canSaveNote ? () {
                    newNoteController.saveNote(context);
                    Navigator.pop(context);
                  } : null,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Selector<NewNoteController, bool>(
                selector: (context, controller) => controller.readOnly,
                builder: (context, readOnly, child) => TextField(
                  controller: titleController,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Title here',
                    hintStyle: TextStyle(color: gray300),
                    border: InputBorder.none,
                  ),
                  canRequestFocus: !readOnly,
                  onChanged: (newValue) {
                    newNoteController.title = newValue;
                  },
                ),
              ),
              NoteMetadata(note: newNoteController.note),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(
                  color: gray500,
                  thickness: 2,
                ),
              ),
              Expanded(
                child: Selector<NewNoteController, bool>(
                  selector: (_, controller) => controller.readOnly,
                  builder: (_, readOnly, __) => Column(
                    children: [
                      Expanded(
                        child: QuillEditor.basic(
                          controller: quillController,
                          configurations: QuillEditorConfigurations(
                            placeholder: 'Note here...',
                            expands: true,
                          ),
                          focusNode: focusNode,
                        ),
                      ),
                      if (!readOnly)
                        NoteToolbar(quillController: quillController),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
