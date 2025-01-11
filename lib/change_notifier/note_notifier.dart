import 'package:flutter/cupertino.dart';
import '../model/note.dart';

extension ListDeepContains on List<String>{
  bool deepContains(String term) => contains(term) || any((e) => e.contains(term));
}

class NotesProvider extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => [..._searchTerm.isEmpty ? _notes : _notes.where(_test)]..sort(_compare);

  bool _test(Note note){
    final term = _searchTerm.toLowerCase().trim();
    final title = note.title?.toLowerCase() ?? '';
    final content = note.content?.toLowerCase() ?? '';
    final tags = note.tags?.map((e) => e.toLowerCase()).toList() ?? [];
    return title.contains(term) || content.contains(term) || tags.deepContains(term);
  }

  int _compare(Note note1, note2) {
    return _orderBy == OrderOption.dateModified
        ? _isDescending
            ? note2.dateModified.compareTo(note1.dateModified)
            : note1.dateModified.compareTo(note2.dateModified)
        : _isDescending
            ? note2.dateCreated.compareTo(note1.dateCreated)
            : note1.dateCreated.compareTo(note2.dateCreated);
  }

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(Note note) {
    final index = _notes.indexWhere((e) => e.dateCreated == note.dateCreated);
    _notes[index] = note;
    notifyListeners();
  }

  void deleteNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }

  OrderOption _orderBy = OrderOption.dateModified;

  set orderBy(OrderOption value) {
    _orderBy = value;
    notifyListeners();
  }

  OrderOption get orderBy => _orderBy;

  bool _isDescending = true;

  set isDescending(bool value) {
    _isDescending = value;
    notifyListeners();
  }

  bool get isDescending => _isDescending;

  bool _isGrid = true;

  set isGrid(bool value) {
    _isGrid = value;
    notifyListeners();
  }

  bool get isGrid => _isGrid;

  String _searchTerm = '';
  set searchTerm(String value){
    _searchTerm = value;
    notifyListeners();
  }

  String get searchTerm => _searchTerm;
}

enum OrderOption {
  dateModified,
  dateCreated;

  String get name {
    return switch (this) {
      OrderOption.dateModified => 'Modified date',
      OrderOption.dateCreated => 'Created date'
    };
  }
}
