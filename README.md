# NoteNest

A simple notes app built with **Flutter**. Add, edit and delete notes. Notes are saved on the device
(browser localStorage on web, app storage on Android) using `shared_preferences`, so there is no
server, login or database to set up.

## Features
- Add a note (title + text)
- Edit a note (tap it)
- Delete a note (swipe left, or the bin icon in the editor)
- Notes persist after closing the app or refreshing the browser

## Project structure
```
flutter_app/lib/
  main.dart                      App entry, theme, Provider setup
  models/note.dart               Note model + JSON conversion
  services/storage_service.dart  Save / load notes (shared_preferences)
  providers/notes_provider.dart  State management (add, update, remove)
  screens/notes_screen.dart      Notes list, swipe to delete
  screens/note_editor_screen.dart Add / edit screen
```

## Run locally
Install the Flutter SDK, then:
```bash
cd flutter_app
flutter create . --platforms=web,android   # one time: generates platform folders
flutter pub get
flutter run -d chrome        # or: flutter run   (Android emulator / phone)
```

## Deploy to GitHub Pages
1. Create a GitHub repo and push this project to the `main` branch.
2. The workflow `.github/workflows/deploy.yml` builds the Flutter web app and publishes it to the `gh-pages` branch.
3. Repo → Settings → Pages → Source: **Deploy from a branch** → `gh-pages` / root.
4. Your app will be live at `https://<username>.github.io/<repo-name>/`.

## Note
Notes live in the browser/device they were created on. Clearing site data removes them.
