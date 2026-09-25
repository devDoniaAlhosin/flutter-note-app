# Notes

A Flutter notes app for Week 7 Assignment 13. Create, edit, search, and save notes on the device.

HTML documentation: open [`docs/assign_13-documantation_note_app.html`](docs/assign_13-documantation_note_app.html) in a browser.

Screenshots: save emulator captures in [`docs/screenshots/`](docs/screenshots) using the names in that folder’s README. The HTML page shows them automatically.

Repository: [https://github.com/devDoniaAlhosin/flutter-note-app.git](https://github.com/devDoniaAlhosin/flutter-note-app.git)

The launcher name is **Notes**. The Dart package name stays `technical_w7_assignment13_note_app` so the existing Android Studio run configuration keeps working.

## Features

- **Create notes** with a title and body from the + button
- **Edit notes** by tapping a card
- **Delete notes** by swiping left, or from the editor, with undo after a swipe
- **Search** notes by title or content
- **Local persistence** so notes stay after you close the app (`shared_preferences`)
- **Empty and no-results states** when the list or search is empty
- **Timestamps** showing the last update time
- **Light and dark themes** that follow the system setting
- **Auto-save** when you leave the editor with content
- **Provider state management** so the list and editor share one `NotesProvider`

## How to run

1. Open the project in Android Studio.
2. Get packages if needed: `flutter pub get`
3. Run the app on an emulator or device.
4. After the first name/code change, use **Hot Restart** (not only Hot Reload) so the new UI loads.

## Project structure

- `lib/main.dart` — app theme, startup, and `ChangeNotifierProvider`
- `lib/models/note.dart` — note data
- `lib/data/note_repository.dart` — load and save notes on the device
- `lib/providers/notes_provider.dart` — shared notes state (`ChangeNotifier`)
- `lib/screens/notes_home_page.dart` — note list and search
- `lib/screens/note_editor_page.dart` — create and edit a note
