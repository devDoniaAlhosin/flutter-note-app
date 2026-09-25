import 'package:flutter/foundation.dart';

import '../data/note_repository.dart';
import '../models/note.dart';

class NotesProvider extends ChangeNotifier {
  NotesProvider(this._repository) {
    loadNotes();
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

  Future<void> loadNotes() async {
    _notes = await _repository.load();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    if (_searchQuery == query) {
      return;
    }
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> saveNote(Note note) async {
    final index = _notes.indexWhere((item) => item.id == note.id);
    if (index >= 0) {
      _notes[index] = note;
      await _repository.updateNote(note);
    } else {
      _notes.add(note);
      await _repository.insertNote(note);
    }
    _notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    notifyListeners();
  }

  Future<int> deleteNote(String id) async {
    final index = _notes.indexWhere((item) => item.id == id);
    if (index < 0) {
      return -1;
    }
    _notes.removeAt(index);
    notifyListeners();
    await _repository.deleteNote(id);
    return index;
  }

  Future<void> restoreNote(Note note, int index) async {
    final clampedIndex = index.clamp(0, _notes.length);
    _notes.insert(clampedIndex, note);
    notifyListeners();
    await _repository.insertNote(note);
  }
}
