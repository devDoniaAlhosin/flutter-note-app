import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';

class DatabaseHelper {
  DatabaseHelper._({this.useMemory = false});

  static final DatabaseHelper instance = DatabaseHelper._();

  @visibleForTesting
  factory DatabaseHelper.memory() => DatabaseHelper._(useMemory: true);

  static const _dbName = 'notes.db';
  static const _dbVersion = 1;
  static const table = 'notes';

  final bool useMemory;
  Database? _database;
  final List<Note> _memoryNotes = [];

  Future<Database> get database async {
    if (useMemory) {
      throw StateError('Memory helper does not open SQLite.');
    }
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) {
    return db.execute('''
      CREATE TABLE $table (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');
  }

  Future<List<Note>> getNotes() async {
    if (useMemory) {
      return List<Note>.from(_memoryNotes)
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    }
    final db = await database;
    final rows = await db.query(table, orderBy: 'updatedAt DESC');
    return rows.map(Note.fromJson).toList();
  }

  Future<void> insertNote(Note note) async {
    if (useMemory) {
      _memoryNotes.removeWhere((item) => item.id == note.id);
      _memoryNotes.add(note);
      return;
    }
    final db = await database;
    await db.insert(
      table,
      note.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateNote(Note note) async {
    if (useMemory) {
      final index = _memoryNotes.indexWhere((item) => item.id == note.id);
      if (index >= 0) {
        _memoryNotes[index] = note;
      } else {
        _memoryNotes.add(note);
      }
      return;
    }
    final db = await database;
    await db.update(
      table,
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(String id) async {
    if (useMemory) {
      _memoryNotes.removeWhere((item) => item.id == id);
      return;
    }
    final db = await database;
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
