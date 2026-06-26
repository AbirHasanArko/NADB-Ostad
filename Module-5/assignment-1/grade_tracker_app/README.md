# Student Grade Tracker

A Flutter application for students to add subjects, record marks, and view their result summary.

## Features
- **Add Subject**: Add subjects with their respective marks (0-100).
- **Subject List**: View all added subjects, marks, and calculated grades (A, B, C, F). Swipe left to delete a subject.
- **Result Summary**: View the total number of subjects, passing subjects, average mark, and overall grade.
- **Theming**: Toggle between light and dark themes using the icon in the AppBar.
- **State Management**: Built entirely using `Provider` for state management, with zero `setState` calls.

## Requirements Satisfied
1. `Subject` class has a private `_mark` field and a `grade` getter.
2. Used `.map()` and `.where()` inside `GradeProvider` to calculate averages and passing subjects.
3. Form validation ensures names are not empty and marks are valid (0-100).
4. `Dismissible` widget allows swiping to delete subjects.
5. Custom `ThemeData` is used, and all colors are pulled dynamically using `Theme.of(context)`. No hardcoded colors.
6. Zero `setState` calls in the entire app. Form state is managed locally via `AddSubjectProvider`, and global state via `GradeProvider` & `NavigationProvider`.

## How to Run
1. Ensure you have Flutter installed.
2. Clone this repository or open the project folder.
3. Run `flutter pub get` to fetch dependencies (Provider).
4. Run `flutter run` to launch the application on your device or emulator.
