import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/change_notifier/new_note_controller.dart';
import 'package:notes_app/change_notifier/note_notifier.dart';
import 'package:notes_app/pages/new_or_edit_note_page.dart';
import 'package:notes_app/core/constants.dart';
import 'package:notes_app/widgets/note_list_or_grid/note_grid.dart';
import 'package:notes_app/widgets/note_list_or_grid/notes_list.dart';
import 'package:notes_app/widgets/button/note_icon_button_outlined.dart';
import 'package:notes_app/widgets/view_option.dart';
import 'package:notes_app/widgets/dialog/confirmation_dialog.dart';
import 'package:notes_app/model/note.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MainPageState();
}

class _MainPageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes App 📒'),
        actions: [
          NoteIconButtonOutlined(
            icon: FontAwesomeIcons.rightFromBracket,
            onPressed: () async {
              final bool? shouldLogout = await showDialog<bool?>(
                  context: context,
                  builder: (_) => ConfirmationDialog(title: 'Do you want to sign out?',)
              );
              if(shouldLogout == null) return;
              if(shouldLogout) AuthService.signOut();

            },
          )
        ],
      ),
      body: Consumer<NotesProvider>(builder: (context, notesProvider, child) {
        final List<Note> notes = notesProvider.notes;
        return notes.isEmpty && notesProvider.searchTerm.isEmpty
        // chưa có ghi chú nào
            ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      'assets/images/person.png',
                      width: MediaQuery.sizeOf(context).width * 0.75),
                  SizedBox(height: 32),
                  Text(
                      'You have no notes yet!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                      fontFamily: 'Fredoka'
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )
        // đã có ghi chú
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    //tìm kiếm ghi chú
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Search notes...',
                          hintStyle: TextStyle(fontSize: 14),
                          prefixIcon: Icon(
                            FontAwesomeIcons.magnifyingGlass,
                            size: 20,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          isDense: true,
                          prefixIconConstraints: BoxConstraints(minWidth: 42, maxWidth: 42),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: primary)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: primary)
                          )
                      ),
                      onChanged: (newValue) {
                        context.read<NotesProvider>().searchTerm = newValue;
                      },
                    ),

                    ViewOption(),
                    // nội dung theo dạng grid hoặc list
                    if(notes.isNotEmpty) ...[
                      Expanded(
                        child: notesProvider.isGrid
                            ? NotesGrid(notes: notes)
                            : NotesList(notes: notes),
                      )
                    ] else
                      Expanded(
                          child: Center(
                              child: Text(
                                'No notes found for your search',
                                textAlign: TextAlign.center,
                              )
                          )
                      )
                  ],
                ),
              );
      }),

      // button thêm ghi chú mới
      floatingActionButton: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black, offset: Offset(4, 4))]
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => NewNoteController(),
                      child: NewOrEditNotePage(isNewNote: true,),
                    )
                )
            );
          },
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.black)
          ),
          child: FaIcon(FontAwesomeIcons.plus,),
        ),
      ),
    );
  }
}
