# Notes

A Flutter notes app where I applied the content of **DEPI Week 7 Lecture 13** and **Lecture 14**.

- **Lecture 13:** Notes app screens, title and description, add / edit / search / delete, and local storage
- **Lecture 14:** Provider state, plus **emit** and **omit** on the note screens

Repository: [https://github.com/devDoniaAlhosin/flutter-note-app.git](https://github.com/devDoniaAlhosin/flutter-note-app.git)

HTML documentation: open [`docs/assign_13-documantation_note_app.html`](docs/assign_13-documantation_note_app.html) in a browser.

Screenshots in the HTML docs load from GitHub, for example [01-home-empty.png](https://github.com/devDoniaAlhosin/flutter-note-app/blob/1d8478111e7fa366e1e009921f2e6a26a2dcf72d/docs/screenshots/01-home-empty.png).

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
- **Emit** a new state with `notifyListeners()` after save, delete, undo, or search
- **Omit** empty notes, unmatched search results, no-change search, and unsaved back

## How to run

1. Open the project in Android Studio.
2. Get packages if needed: `flutter pub get`
3. Run the app on an emulator or device.
4. After a name or code change, use **Hot Restart** (not only Hot Reload) so the new UI loads.

## Project structure

- `lib/main.dart` — app theme, startup, and `ChangeNotifierProvider`
- `lib/models/note.dart` — note data
- `lib/data/note_repository.dart` — load and save notes on the device
- `lib/providers/notes_provider.dart` — shared notes state; emit and omit live here
- `lib/screens/notes_home_page.dart` — note list and search; watches emitted state
- `lib/screens/note_editor_page.dart` — create and edit a note; check emits, empty/back omit
- `android/app/src/main/res/values/strings.xml` — Android app name **Notes**
- `docs/assign_13-documantation_note_app.html` — HTML documentation for Week 7 Lecture 13 and 14
