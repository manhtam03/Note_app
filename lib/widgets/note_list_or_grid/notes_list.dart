import 'package:flutter/material.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/widgets/note_card.dart';

// nội dung ghi chú theo dạng list
class NotesList extends StatelessWidget {
  const NotesList({super.key, required this.notes});
  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return NoteCard(
          note: notes[index],
          isInGrid: false,
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 7,),
    );
  }
}
