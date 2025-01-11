import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes_app/core/constants.dart';
class NoteToolbar extends StatelessWidget {
  const NoteToolbar({
    super.key,
    required this.quillController,
  });

  final QuillController quillController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: primary,
              strokeAlign: BorderSide.strokeAlignOutside
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: primary, offset: Offset(4, 4))
          ]),
      child: QuillSimpleToolbar(
        controller: quillController,
        configurations: QuillSimpleToolbarConfigurations(
          multiRowsDisplay: false,
          showFontFamily: false,
          showFontSize: false,
          showSubscript: false,
          showSuperscript: false,
          showSmallButton: false,
          showInlineCode: false,
          showAlignmentButtons: false,
          showDirection: false,
          showDividers: false,
          showHeaderStyle: false,
          showListCheck: false,
          showCodeBlock: false,
          showQuote: false,
          showIndent: false,
          buttonOptions: QuillSimpleToolbarButtonOptions(
              undoHistory:
                  QuillToolbarHistoryButtonOptions(iconSize: 20),
                  redoHistory: QuillToolbarHistoryButtonOptions(iconSize: 20,),
                  bold: QuillToolbarToggleStyleButtonOptions(iconSize: 20),
                  italic: QuillToolbarToggleStyleButtonOptions(iconSize: 20),
                  underLine: QuillToolbarToggleStyleButtonOptions(iconSize: 20),
                  strikeThrough: QuillToolbarToggleStyleButtonOptions(iconSize: 20),
                  color: QuillToolbarColorButtonOptions(iconSize: 20),
                  backgroundColor: QuillToolbarColorButtonOptions(iconSize: 20),
                  clearFormat: QuillToolbarClearFormatButtonOptions(iconSize: 20),
                  listBullets: QuillToolbarToggleStyleButtonOptions(iconSize: 20),
                  listNumbers: QuillToolbarToggleStyleButtonOptions(iconSize: 20),
                  search: QuillToolbarSearchButtonOptions(iconSize: 20),
          ),
        ),
      ),
    );
  }
}