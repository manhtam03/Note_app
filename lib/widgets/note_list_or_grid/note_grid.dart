import 'package:flutter/material.dart';
import 'package:notes_app/model/note.dart';
import '../note_card.dart';

// nội dung ghi chú theo dạng grid
class NotesGrid extends StatelessWidget {
  const NotesGrid({
    super.key, required this.notes,
  });
  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: notes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 4
      ),
      itemBuilder: (context, int index) {
        return NoteCard(
          note: notes[index],
          isInGrid: true,
        );
      },
    );
  }
}

