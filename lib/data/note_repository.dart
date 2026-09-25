import '../models/note.dart';
import 'database_helper.dart';

class NoteRepository {
  NoteRepository([DatabaseHelper? helper])
    : _helper = helper ?? DatabaseHelper.instance;

  final DatabaseHelper _helper;

  Future<List<Note>> load() => _helper.getNotes();

  Future<void> insertNote(Note note) => _helper.insertNote(note);

  Future<void> updateNote(Note note) => _helper.updateNote(note);

  Future<void> deleteNote(String id) => _helper.deleteNote(id);
}
