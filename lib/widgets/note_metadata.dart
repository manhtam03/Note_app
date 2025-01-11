import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/core/utils.dart';
import 'package:notes_app/core/constants.dart';
import 'package:notes_app/widgets/dialog/tag_dialog.dart';
import 'package:notes_app/widgets/tag_widgets.dart';
import 'package:notes_app/change_notifier/new_note_controller.dart';
import 'package:notes_app/model/note.dart';

class NoteMetadata extends StatefulWidget {
  const NoteMetadata({super.key, this.note});
  final Note? note;

  @override
  State<NoteMetadata> createState() => _NoteMetadataState();
}

class _NoteMetadataState extends State<NoteMetadata> {
  late final NewNoteController newNoteController;

  @override
  void initState() {
    // TODO: implement initState
    newNoteController = context.read();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.note != null) ...[
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Sửa đổi lần cuối',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: gray500
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  toLongDate(widget.note!.dateModified),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: gray900
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Text(
                    'Thời gian tạo',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: gray500
                    ),
                  )
              ),
              Expanded(
                  flex: 5,
                  child: Text(
                    toLongDate(widget.note!.dateCreated),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: gray900
                    ),
                  )
              )
            ],
          ),
        ],
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Text(
                    'Tag',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray500
                    ),
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.circlePlus),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    constraints: BoxConstraints(),
                    style: IconButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap
                    ),
                    color: gray700,
                    onPressed: () async {
                      final String? tag = await showDialog<String?>(
                          context: context,
                          builder: (context) => TagDialog()
                      );
                      if (tag != null){
                        newNoteController.addTag(tag);
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Selector<NewNoteController, List<String>>(
                selector: (_,newNoteController) => newNoteController.tags,
                builder: (_, tags, __) => tags.isEmpty ? Text(
                  'No tags added',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: gray900,
                  ),
                ) : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(tags.length, (index) =>
                        TagWidgets(
                          onTap: () async {
                            final String? tag = await showDialog<String?>(
                                context: context,
                                builder: (context) => TagDialog(tag: tags[index],)
                            );
                            if (tag != null && tag != tags[index]){
                              newNoteController.updateTag(tag, index);
                            }
                          },
                          label: tags[index],
                          onClosed: () {
                            newNoteController.removeTag(index);
                          },
                        )
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
