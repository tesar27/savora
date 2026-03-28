# Savora

Savora is a Flutter mobile app concept for discovering restaurant deals, browsing curated venue sections, and managing a localized user profile experience.

The current build focuses on a polished consumer UI with a custom home feed, animated bottom navigation, city selection, bilingual support, and an editable profile flow.

## Highlights

- Curated restaurant deal feed with horizontally scrollable sections like Nearby, Trending, Top Rated, and Pizza
- Custom bottom navigation with a compact animated selected state
- Home city picker presented as a bottom sheet with Swiss cities and nearby German cities
- English and German localization with system-language support
- Profile dashboard with stats, promo card, language switcher, and editable user details
- Edit Profile screen with avatar upload via `image_picker`
- Shared app theming so core typography is controlled centrally

## Tech Stack

- Flutter
- Dart
- Material 3
- `flutter_localizations`
- `image_picker`

## Project Structure

```text
lib/
	app/            App shell, navigation, and root configuration
	core/           Shared theme, localization, settings, constants
	features/       Feature-first modules such as home, profile, bookings
```

## Main Screens

### Home

- City selector in the header
- Category chips for browsing food types
- Multiple curated deal sections with venue cards

### Profile

- Profile summary header
- Stats carousel
- Promo banner
- Language selector
- Edit profile entry point

### Edit Profile

- Update first name, last name, email, and password
- Change avatar image from device media

## Localization

Savora currently supports:

- English
- German
- System default locale

Localization is implemented in `lib/core/localization/app_localizations.dart` and wired through the root app widget.

## Getting Started

### Prerequisites

- Flutter SDK `^3.10.7`
- Xcode for iOS/macOS builds
- Android Studio or Android SDK for Android builds

### Install dependencies

```bash
flutter pub get
```

### Run the app

```bash
flutter run
```

### Analyze the code

```bash
flutter analyze
```

## Current Status

This project is currently a UI-driven application prototype with local in-memory state for settings and profile data. It is ready for further expansion into a production app with:

- backend/API integration
- persistent user settings
- authentication
- real restaurant and deal data
- favorites and bookings logic

## Roadmap Ideas

- Persist selected city, language, and profile data locally
- Connect home sections to a live deals API
- Add search and filtering flows
- Implement real favorites, bookings, and discovery logic
- Add widget and golden tests for key screens

## License

Private project.
