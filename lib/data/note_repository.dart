import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/note.dart';

class NoteRepository {
  NoteRepository(this._prefs);

  static const _storageKey = 'notes_v1';

  final SharedPreferences _prefs;

  List<Note> load() {
    final raw = _prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) {
      return [];
    }

    final decoded = jsonDecode(raw) as List<dynamic>;
    final notes = decoded
        .map((item) => Note.fromJson(item as Map<String, dynamic>))
        .toList();
    notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return notes;
  }

  Future<void> saveAll(List<Note> notes) {
    final encoded = jsonEncode(notes.map((note) => note.toJson()).toList());
    return _prefs.setString(_storageKey, encoded);
  }
}
