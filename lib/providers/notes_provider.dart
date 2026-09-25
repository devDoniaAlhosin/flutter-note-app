import 'package:flutter/foundation.dart';

import '../data/note_repository.dart';
import '../models/note.dart';

class NotesProvider extends ChangeNotifier {
  NotesProvider(this._repository) {
    _notes = _repository.load();
  }

  final NoteRepository _repository;

  List<Note> _notes = [];
  String _searchQuery = '';

  List<Note> get notes => List.unmodifiable(_notes);

  String get searchQuery => _searchQuery;

  List<Note> get visibleNotes {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return notes;
    }
    return _notes
        .where(
          (note) =>
              note.title.toLowerCase().contains(query) ||
              note.content.toLowerCase().contains(query) ||
              note.displayTitle.toLowerCase().contains(query),
        )
        .toList();
  }

  void setSearchQuery(String query) {
    if (_searchQuery == query) {
      return;
    }
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> saveNote(Note note) {
    final index = _notes.indexWhere((item) => item.id == note.id);
    if (index >= 0) {
      _notes[index] = note;
    } else {
      _notes.add(note);
    }
    _notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    notifyListeners();
    return _repository.saveAll(_notes);
  }

  Future<int> deleteNote(String id) async {
    final index = _notes.indexWhere((item) => item.id == id);
    if (index < 0) {
      return -1;
    }
    _notes.removeAt(index);
    notifyListeners();
    await _repository.saveAll(_notes);
    return index;
  }

  Future<void> restoreNote(Note note, int index) {
    final clampedIndex = index.clamp(0, _notes.length);
    _notes.insert(clampedIndex, note);
    notifyListeners();
    return _repository.saveAll(_notes);
  }
}
