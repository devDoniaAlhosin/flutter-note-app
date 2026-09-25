# Notes

A Flutter notes app for **DEPI Week 7**. I used the same app for Sessions 13, 14, 15, and 16.

Repository: [https://github.com/devDoniaAlhosin/flutter-note-app.git](https://github.com/devDoniaAlhosin/flutter-note-app.git)

The launcher and in-app name is **Notes**. The Dart package name stays `technical_w7_assignment13_note_app` so the Android Studio run configuration keeps working.

## What I added

### Session 13 — Notes app
- Home list and editor screens
- Title and description on every note
- Add, edit, search, and swipe delete
- Save only with the check button
- “Are you sure?” if I go back with unsaved changes

### Session 14 — Emit and omit
- Shared notes state for the list and the editor
- **Emit** a new list with `notifyListeners()` after save, delete, undo, or search
- **Omit** empty notes, unmatched search, no-change search, and unsaved back

### Session 15 — DatabaseHelper
- SQLite file `notes.db` instead of SharedPreferences JSON
- **Create** inserts one row
- **Edit** updates that row
- **Delete** removes that row
- SQL stays in `DatabaseHelper` so screens do not write SQL

### Session 16 — MVC controller
- **Model:** `Note`
- **View:** home and editor screens
- **Controller:** `NotesController` — views call it, it talks to SQLite

## Features

- **Title and description** on every note
- **Create** a note from the + button
- **Edit** a note by tapping a card
- **Save with the check** only. Back does not auto-save
- **Leave alert** — “Are you sure?” if there are unsaved changes
- **Delete** by swipe or from the editor, with undo after a swipe
- **Search** by title or description
- **Empty and no-results states** when the list or search is empty
- **Timestamps** for the last update
- **Light and dark themes** that follow the phone
- **SQLite** so notes stay after I close the app
- **MVC** so UI, data, and logic stay in separate files
- **Emit / omit** so the list updates only when it should

## Documentation

**All sessions (one file):** [`docs/Note_app_Documentation.html`](docs/Note_app_Documentation.html)

**One file per session:**

- Session 13 — [`docs/Session_13_Notes_app.html`](docs/Session_13_Notes_app.html)
- Session 14 — [`docs/Session_14_Provider_emit_omit.html`](docs/Session_14_Provider_emit_omit.html)
- Session 15 — [`docs/Session_15_DatabaseHelper.html`](docs/Session_15_DatabaseHelper.html)
- Session 16 — [`docs/Session_16_MVC_controller.html`](docs/Session_16_MVC_controller.html)

Each session page has the GitHub repo. The HTML files do not link to each other.

## Screenshots

| Screen | Link |
|---|---|
| Empty home | [01-home-empty.png](https://github.com/devDoniaAlhosin/flutter-note-app/blob/1d8478111e7fa366e1e009921f2e6a26a2dcf72d/docs/screenshots/01-home-empty.png) |
| Add note | [02-add-note.png](https://github.com/devDoniaAlhosin/flutter-note-app/blob/1d8478111e7fa366e1e009921f2e6a26a2dcf72d/docs/screenshots/02-add-note.png) |
| Notes list | [03-note-list.png](https://github.com/devDoniaAlhosin/flutter-note-app/blob/1d8478111e7fa366e1e009921f2e6a26a2dcf72d/docs/screenshots/03-note-list.png) |
| Edit note | [04-edit-note.png](https://github.com/devDoniaAlhosin/flutter-note-app/blob/1d8478111e7fa366e1e009921f2e6a26a2dcf72d/docs/screenshots/04-edit-note.png) |
| Search | [05-search.png](https://github.com/devDoniaAlhosin/flutter-note-app/blob/1d8478111e7fa366e1e009921f2e6a26a2dcf72d/docs/screenshots/05-search.png) |

## How to run

1. Open the project in Android Studio.
2. Get packages if needed: `flutter pub get`
3. Run the app on an emulator or device.
4. After a name or code change, use **Hot Restart** (not only Hot Reload).

## Project structure

- `lib/models/note.dart` — Model: note data
- `lib/controllers/notes_controller.dart` — Controller: load, save, delete, search
- `lib/screens/notes_home_page.dart` — View: list and search
- `lib/screens/note_editor_page.dart` — View: create and edit
- `lib/data/database_helper.dart` — SQLite insert / update / delete / get
- `lib/data/note_repository.dart` — talks to DatabaseHelper
- `lib/main.dart` — starts the app and provides `NotesController`
- `docs/Note_app_Documentation.html` — full Notes documentation
