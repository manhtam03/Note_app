import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/change_notifier/note_notifier.dart';
import 'package:notes_app/core/constants.dart';

class ViewOption extends StatefulWidget {
  const ViewOption({super.key});

  @override
  State<ViewOption> createState() => _ViewOptionState();
}

class _ViewOptionState extends State<ViewOption> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotesProvider>(
      builder: (_, notesProvider, __) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            //button sắp xếp theo thời gian
            IconButton(
              icon: notesProvider.isDescending
                  ? FaIcon(FontAwesomeIcons.arrowDown)
                  : FaIcon(FontAwesomeIcons.arrowUp),
              iconSize: 18,
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              constraints: BoxConstraints(),
              style: IconButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap
              ),
              color: gray700,
              onPressed: () {
                setState(() {
                  notesProvider.isDescending = !notesProvider.isDescending;
                });
              },
            ),
            SizedBox(width: 8),
            //chọn sắp xếp theo thời gian chỉnh sửa hoặc thời gian tạo ghi chú
            DropdownButton<OrderOption>(
                isDense: true,
                value: notesProvider.orderBy,
                items: OrderOption.values
                    .map((e) => DropdownMenuItem(
                    value: e,
                    child: Row(
                      children: [
                        Text(e.name),
                        if (e == notesProvider.orderBy) ...[
                          SizedBox(width: 8,),
                          Icon(Icons.check),
                        ]
                      ],
                    )
                )).toList(),
                selectedItemBuilder: (context) =>
                    OrderOption.values.map((e) => Text(e.name)).toList(),
                icon: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: FaIcon(
                    FontAwesomeIcons.arrowDownWideShort,
                    size: 18,
                    color: gray700,
                  ),
                ),
                underline: SizedBox.shrink(),
                borderRadius: BorderRadius.circular(16),
                onChanged: (newValue) {
                  setState(() {
                    notesProvider.orderBy = newValue!;
                  });
                }
            ),
            Spacer(),
            // IconButton chọn nội dung theo grid hoặc list
            IconButton(
              icon: notesProvider.isGrid
                  ? FaIcon(FontAwesomeIcons.bars)
                  : FaIcon(FontAwesomeIcons.tableCellsLarge),
              iconSize: 18,
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              constraints: BoxConstraints(),
              style: IconButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap
              ),
              color: gray700,
              onPressed: () {
                setState(() {
                  notesProvider.isGrid = !notesProvider.isGrid;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
