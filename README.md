# Notes

A Flutter notes app for DEPI Week 7 Assignment 13. I built it so I can create, edit, search, and save notes on the device.

Repository: [https://github.com/devDoniaAlhosin/flutter-note-app.git](https://github.com/devDoniaAlhosin/flutter-note-app.git)

HTML documentation: open [`docs/assign_13-documantation_note_app.html`](docs/assign_13-documantation_note_app.html) in a browser.

Screenshots: save emulator captures in [`docs/screenshots/`](docs/screenshots) using the names in that folder’s README. The HTML page shows them automatically.

The launcher and in-app name is **Notes**. The Dart package name stays `technical_w7_assignment13_note_app` so the existing Android Studio run configuration keeps working.

## Features

- **Title and description** on every note
- **Create notes** from the + button
- **Edit notes** by tapping a card
- **Save with the check button** only. Back does not auto-save
- **Leave alert** that asks “Are you sure?” if there are unsaved changes
- **Delete notes** by swiping left, or from the editor, with undo after a swipe
- **Search** notes by title or description
- **Local persistence** so notes stay after I close the app (`shared_preferences`)
- **Empty and no-results states** when the list or search is empty
- **Timestamps** showing the last update time
- **Light and dark themes** that follow the system setting
- **Provider state management** so the list and editor share one `NotesProvider`

## How to run

1. Open the project in Android Studio.
2. Get packages if needed: `flutter pub get`
3. Run the app on an emulator or device.
4. After a name or code change, use **Hot Restart** (not only Hot Reload) so the new UI loads.

## Project structure

- `lib/main.dart` — app theme, startup, and `ChangeNotifierProvider`
- `lib/models/note.dart` — note data
- `lib/data/note_repository.dart` — load and save notes on the device
- `lib/providers/notes_provider.dart` — shared notes state (`ChangeNotifier`)
- `lib/screens/notes_home_page.dart` — note list and search
- `lib/screens/note_editor_page.dart` — create and edit a note
- `android/app/src/main/res/values/strings.xml` — Android app name **Notes**
- `docs/assign_13-documantation_note_app.html` — HTML documentation
