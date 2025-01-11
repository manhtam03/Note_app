import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/change_notifier/new_note_controller.dart';
import 'package:notes_app/change_notifier/note_notifier.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/core/constants.dart';
import 'package:notes_app/core/utils.dart';
import 'package:notes_app/pages/new_or_edit_note_page.dart';
import 'package:notes_app/widgets/dialog/confirmation_dialog.dart';
import 'package:notes_app/widgets/tag_widgets.dart';

class NoteCard extends StatelessWidget {
  final bool isInGrid;
  final Note note;

  const NoteCard({
    super.key,
    required this.isInGrid, required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            ChangeNotifierProvider(
                create: (_) => NewNoteController().. note = note,
                child: NewOrEditNotePage(
                  isNewNote: false,
                )
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: primary, width: 2),
            boxShadow: [
              BoxShadow(color: primary.withOpacity(0.5), offset: Offset(4, 4))
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (note.title != null) ... [
              Text(
                note.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: gray900
                ),
              ),
              SizedBox(height: 5,)
            ],
            if (note.tags != null) ... [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(
                        note.tags!.length,
                            (index) => TagWidgets(label: note.tags![index],)
                    )
                ),
              ),
            ],
            SizedBox(height: 5,),
            if (note.content != null) ... [
              if (isInGrid)
                Expanded(
                    child: Text(
                      note.content!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: gray700),
                    )
                )
              else
                Text(
                  note.content!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: gray700),
                ),
            ],
            if (isInGrid) Spacer(),
            Row(
              children: [
                Text(
                  toShortDate(note.dateModified),
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600, color: gray700
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    final bool shouldDelete = await showDialog<bool?>(
                        context: context,
                        builder: (_) => ConfirmationDialog(title: 'Do you want to delete notes?',
                        )
                    ) ?? false;
                    if(shouldDelete && context.mounted) {
                      context.read<NotesProvider>().deleteNote(note);
                    }
                  },
                  child: FaIcon(
                    FontAwesomeIcons.trash,
                    color: gray500,
                    size: 16,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
