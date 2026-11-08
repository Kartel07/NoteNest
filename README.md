# NoteNest

A simple notes app built with **Flutter**. Add, edit and delete notes. Notes are saved on the device
(browser localStorage on web, app storage on Android) using `shared_preferences`, so there is no
server, login or database to set up.

**Live demo:** https://kartel07.github.io/flutter_lab_external_exam/

## Features

- Add a note (title + text)
- Edit a note (tap it)
- Delete a note (swipe left, or the bin icon in the editor)
- Notes persist after closing the app or refreshing the browser

## Tech stack

Flutter (Dart), Material 3, `provider` (state management), `shared_preferences` (local storage),
GitHub Actions + GitHub Pages (hosting).

## Project structure

```
.github/workflows/deploy.yml     Builds Flutter web and publishes to gh-pages
docs/                            Project documentation report
flutter_app/
  pubspec.yaml                   Dependencies
  web/, android/                 Platform folders
  test/widget_test.dart          Model unit test
  lib/
    main.dart                    App entry, theme, Provider setup
    models/note.dart             Note model + JSON conversion
    services/storage_service.dart Save / load notes (shared_preferences)
    providers/notes_provider.dart State management (add, update, remove)
    screens/notes_screen.dart    Notes list, swipe to delete
    screens/note_editor_screen.dart Add / edit screen
```

## Run locally

Install the Flutter SDK, then:

```bash
cd flutter_app
flutter pub get
flutter run -d chrome        # web
flutter run                  # Android emulator / connected phone
```

Run the test: `flutter test`

## Deploy to GitHub Pages

1. Push the project to GitHub (branch `main` or `master`). Make sure `flutter_app` is a normal folder
   in the repo and does not contain its own `.git` folder.
2. The workflow `.github/workflows/deploy.yml` runs on every push (or manually from the Actions tab),
   builds the Flutter web app with the repository name as `--base-href`, and publishes it to the
   `gh-pages` branch.
3. Repo → **Settings → Pages** → Source: **Deploy from a branch** → Branch: `gh-pages` / `/ (root)` → Save.
4. The app goes live at `https://<username>.github.io/<repo-name>/`
   (this project: https://kartel07.github.io/flutter_lab_external_exam/).

If the site shows the default Flutter counter page, the source code was not pushed to the repo
(check `git ls-files` shows `flutter_app/lib/main.dart`). If it shows 404, Pages is not enabled yet
or the publish run has not finished.

## Note

Notes live in the browser/device they were created on. Clearing site data removes them.
