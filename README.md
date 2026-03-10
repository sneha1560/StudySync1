# StudySync: AI-Powered Study Planner

A Flutter app that uses AI to generate study schedules based on user goals, deadlines, and focus patterns. Features a Pomodoro timer with analytics, and integration stubs for Google Calendar and Notion.

## Features

- **AI Study Plans** – Generate personalized schedules from goals and deadlines
- **Pomodoro Timer** – 25/5/15 min cycles with session tracking
- **Analytics** – View focus time and completed pomodoros
- **Neumorphic UI** – Soft, modern design with animations
- **Integrations** – Stubs for Google Calendar and Notion (add your API keys)

## Tech Stack

- **Flutter** (Dart)
- **Provider** – State management
- **SharedPreferences** – Local storage
- **Firebase ML / Google APIs** – Add when ready (see Setup)

## Run with CMD

### 1. Install Flutter

1. Download Flutter SDK: https://docs.flutter.dev/get-started/install/windows
2. Extract to `C:\flutter` (or your preferred path)
3. Add to PATH: `C:\flutter\bin`
4. Run: `flutter doctor`

### 2. Run the App

**Option A – Double-click `run.bat`** (if Flutter is in PATH)

**Option B – From CMD:**

```cmd
cd f:\AI\study_sync
flutter pub get
flutter run
```

If you see errors about missing platform files, run:
```cmd
flutter create . --project-name study_sync
```

To run on a specific device:

```cmd
flutter run -d chrome     REM Web
flutter run -d windows    REM Windows desktop (if enabled)
flutter run -d android    REM Android emulator
```

### 3. Build Release

```cmd
flutter build apk        REM Android APK
flutter build web        REM Web app
flutter build windows    REM Windows executable
```

## Project Structure

```
study_sync/
├── lib/
│   ├── main.dart
│   ├── models/          # StudyPlan, PomodoroSession
│   ├── providers/       # Auth, Study, Pomodoro
│   ├── screens/         # Home, Pomodoro, Plans, Analytics, Settings
│   ├── services/        # AI schedule, Calendar, Notion (stubs)
│   ├── theme/           # Neumorphic theme
│   └── widgets/         # Neumorphic components
├── android/
├── pubspec.yaml
└── README.md
```

## Adding Firebase & Google APIs

1. Create a Firebase project at https://console.firebase.google.com
2. Add `google-services.json` to `android/app/`
3. Uncomment Firebase packages in `pubspec.yaml`
4. Run `flutter pub get`

## License

MIT
