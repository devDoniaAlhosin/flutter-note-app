# Notes

A Flutter notes app where I applied **DEPI Week 7 Sessions 13, 14, and 15**.

- **Session 13:** Notes app screens, title and description, add / edit / search / delete
- **Session 14:** Provider state, plus **emit** and **omit** on the note screens
- **Session 15:** SQLite **DatabaseHelper** so create, edit, and delete change one note row

Repository: [https://github.com/devDoniaAlhosin/flutter-note-app.git](https://github.com/devDoniaAlhosin/flutter-note-app.git)

The launcher and in-app name is **Notes**. The Dart package name stays `technical_w7_assignment13_note_app` so the existing Android Studio run configuration keeps working.

## Documentation

Open [`docs/Note_app_Documentation.html`](docs/Note_app_Documentation.html) in a browser.

The HTML page is **Notes App Documentation**. It explains the edits I made in each session, the features, Provider with emit and omit, DatabaseHelper, the file structure, and the screenshots. It uses the **Ubuntu** font and loads screenshot images from GitHub.

## Screenshots

Images come from the GitHub repository:

| Screen | Link |
|---|---|
| Empty home | [01-home-empty.png](https://github.com/devDoniaAlhosin/flutter-note-app/blob/1d8478111e7fa366e1e009921f2e6a26a2dcf72d/docs/screenshots/01-home-empty.png) |
| Add note | [02-add-note.png](https://github.com/devDoniaAlhosin/flutter-note-app/blob/1d8478111e7fa366e1e009921f2e6a26a2dcf72d/docs/screenshots/02-add-note.png) |
| Notes list | [03-note-list.png](https://github.com/devDoniaAlhosin/flutter-note-app/blob/1d8478111e7fa366e1e009921f2e6a26a2dcf72d/docs/screenshots/03-note-list.png) |
| Edit note | [04-edit-note.png](https://github.com/devDoniaAlhosin/flutter-note-app/blob/1d8478111e7fa366e1e009921f2e6a26a2dcf72d/docs/screenshots/04-edit-note.png) |
| Search | [05-search.png](https://github.com/devDoniaAlhosin/flutter-note-app/blob/1d8478111e7fa366e1e009921f2e6a26a2dcf72d/docs/screenshots/05-search.png) |

## Features

- **Title and description** on every note
- **Create notes** from the + button
- **Edit notes** by tapping a card
- **Save with the check button** only. Back does not auto-save
- **Leave alert** that asks “Are you sure?” if there are unsaved changes
- **Delete notes** by swiping left, or from the editor, with undo after a swipe
- **Search** notes by title or description
- **SQLite persistence** so notes stay after I close the app (`DatabaseHelper` + `notes.db`)
- **Empty and no-results states** when the list or search is empty
- **Timestamps** showing the last update time
- **Light and dark themes** that follow the system setting
- **Provider state management** so the list and editor share one `NotesProvider`
- **Emit** a new state with `notifyListeners()` after save, delete, undo, or search
- **Omit** empty notes, unmatched search results, no-change search, and unsaved back

## How to run

1. Open the project in Android Studio.
2. Get packages if needed: `flutter pub get`
3. Run the app on an emulator or device.
4. After a name or code change, use **Hot Restart** (not only Hot Reload) so the new UI loads.

Notes that were saved only in SharedPreferences will not appear after Session 15. New notes are stored in SQLite.

## Project structure

- `lib/main.dart` — app theme, startup, and `ChangeNotifierProvider`
- `lib/models/note.dart` — note data
- `lib/data/database_helper.dart` — SQLite open, table, insert / update / delete / get
- `lib/data/note_repository.dart` — talks to DatabaseHelper
- `lib/providers/notes_provider.dart` — shared notes state; emit and omit live here
- `lib/screens/notes_home_page.dart` — note list and search; watches emitted state
- `lib/screens/note_editor_page.dart` — create and edit a note; check emits, empty/back omit
- `android/app/src/main/res/values/strings.xml` — Android app name **Notes**
- `docs/Note_app_Documentation.html` — Notes App Documentation for sessions 13, 14, and 15
