import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/notes_controller.dart';
import '../models/note.dart';

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({super.key, this.note});

  final Note? note;

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late final DateTime _createdAt;
  late final String _id;
  var _didPop = false;

  bool get _isEditing => widget.note != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.note;
    _id = existing?.id ?? DateTime.now().microsecondsSinceEpoch.toString();
    _createdAt = existing?.createdAt ?? DateTime.now();
    _titleController = TextEditingController(text: existing?.title ?? '');
    _contentController = TextEditingController(text: existing?.content ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Note _draft() {
    return Note(
      id: _id,
      title: _titleController.text,
      content: _contentController.text,
      createdAt: _createdAt,
      updatedAt: DateTime.now(),
    );
  }

  NotesController get _notes => context.read<NotesController>();

  bool get _hasUnsavedChanges {
    final draft = _draft();
    final original = widget.note;
    if (original == null) {
      return !draft.isEmpty;
    }
    return original.title != draft.title || original.content != draft.content;
  }

  Future<void> _save() async {
    final draft = _draft();
    if (draft.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add a title or description first')),
      );
      return;
    }
    await _notes.saveNote(draft);
    _close();
  }

  Future<void> _confirmDelete() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete note?'),
          content: const Text('This note will be removed from your list.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true && mounted) {
      await _notes.deleteNote(_id);
      _close();
    }
  }

  Future<void> _onBack() async {
    if (_didPop) {
      return;
    }
    if (!_hasUnsavedChanges) {
      _close();
      return;
    }

    final leave = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
            'If you go back now, your changes will not be saved. Press the check button to save.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Stay'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Leave'),
            ),
          ],
        );
      },
    );

    if (leave == true && mounted) {
      _close();
    }
  }

  void _close() {
    if (_didPop || !mounted) {
      return;
    }
    _didPop = true;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        _onBack();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEditing ? 'Edit note' : 'New note'),
          actions: [
            if (_isEditing)
              IconButton(
                tooltip: 'Delete',
                onPressed: _confirmDelete,
                icon: const Icon(Icons.delete_outline),
              ),
            IconButton(
              key: const Key('save_note_button'),
              tooltip: 'Save',
              onPressed: _save,
              icon: const Icon(Icons.check),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            TextField(
              key: const Key('note_title_field'),
              controller: _titleController,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter note title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              key: const Key('note_content_field'),
              controller: _contentController,
              minLines: 8,
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter note description',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
