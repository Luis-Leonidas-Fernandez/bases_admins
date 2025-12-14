# Development Guide

This guide covers setup, development workflow, and best practices for working on the Transport Dashboard application.

## Prerequisites

Before starting development, ensure you have the following installed:

- **Flutter SDK**: Version 3.2.3 or higher (SDK constraint: `>=3.2.3 <4.0.0`)
- **Dart SDK**: Included with Flutter
- **Node.js** (for web builds, if needed)
- **Git**: Version control
- **IDE**: Recommended IDEs:
  - **VS Code** with Flutter extensions
  - **Android Studio** / **IntelliJ IDEA** with Flutter plugin

### Platform-Specific Requirements

**For Android Development:**
- Android Studio
- Android SDK (API level 21+)
- Java 21+ (required for AGP 8.3)

**For iOS Development (macOS only):**
- Xcode 14+
- CocoaPods
- iOS 12.0+ deployment target

**For Web Development:**
- Chrome/Edge (for testing)

---

## Project Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd dashboard
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Environment Configuration

#### For Mobile Development

Create a `.env` file in the project root:

```env
API_BASE_URL=https://your-api-url.com/api
MAPBOX_ACCESS_TOKEN=your_mapbox_token_here
```

**Note:** The `.env` file is already in `.gitignore` and should not be committed.

#### For Web Development

Create environment files:
- `.env.dev` - Development environment
- `.env.prod` - Production environment

Example `.env.dev`:
```env
API_BASE_URL=https://dev-api.example.com/api
MAPBOX_ACCESS_TOKEN=your_mapbox_token_here
```

#### Android Configuration

If you need to set Mapbox token for Android builds, add to `android/gradle.properties`:

```properties
MAPBOX_ACCESS_TOKEN=your_mapbox_token_here
```

**⚠️ Important:** Never commit real tokens to version control. Use environment variables instead.

---

## Running the Application

### Web Development

#### Using Script (Recommended)

```bash
# Development mode
./run_web.sh dev

# Production mode
./run_web.sh prod
```

This script uses `--dart-define-from-file` to load environment variables from `.env.dev` or `.env.prod`.

#### Manual Web Run

```bash
# Development
flutter run -d chrome --dart-define-from-file=.env.dev

# Production build
flutter build web --dart-define-from-file=.env.prod
```

#### Serve Production Build

```bash
flutter build web
cd build/web
python3 -m http.server 8000
# Or use any static file server
```

### Mobile Development

#### Android

```bash
# Debug mode
flutter run

# Release build
flutter build appbundle
```

#### iOS (macOS only)

```bash
# Debug mode
flutter run

# Release build
flutter build ios
```

---

## Development Workflow

### Code Organization

Follow the existing structure:
- **Views**: Full-screen pages in `lib/view/`
- **Widgets**: Reusable components in `lib/widgets/`
- **Services**: Business logic in `lib/service/`
- **BLoCs**: State management in `lib/blocs/`
- **Models**: Data models in `lib/models/`

### State Management

Always use BLoC pattern for state management:

1. **Create Events** in `*_event.dart`
2. **Define States** in `*_state.dart`
3. **Implement BLoC** in `*_bloc.dart`
4. **Provide BLoC** in `main.dart` via `MultiBlocProvider`

Example:
```dart
// Event
class LoadDataEvent extends MyEvent {}

// State
class DataLoadedState extends MyState {
  final List<Item> items;
  DataLoadedState(this.items);
}

// BLoC
class MyBloc extends Bloc<MyEvent, MyState> {
  final MyService service;
  
  MyBloc({required this.service}) : super(InitialState()) {
    on<LoadDataEvent>(_onLoadData);
  }
  
  Future<void> _onLoadData(
    LoadDataEvent event,
    Emitter<MyState> emit,
  ) async {
    emit(LoadingState());
    try {
      final items = await service.fetchItems();
      emit(DataLoadedState(items));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
```

### Adding New API Endpoints

1. **Add method to appropriate Service** (`lib/service/`)
2. **Use `ApiConfig.post()` or `ApiConfig.get()`**
3. **Handle errors** with try-catch
4. **Extract error messages** using `_extractErrorMessage()` pattern

Example:
```dart
Future<MyModel> fetchData(String id) async {
  try {
    final path = '/api/endpoint/$id';
    final response = await ApiConfig.get(path);
    return MyModel.fromJson(response);
  } catch (e) {
    String errorMessage = _extractErrorMessage(e);
    throw Exception(errorMessage);
  }
}
```

### Adding New Translations

1. **Edit ARB files** in `lib/l10n/`
2. **Run localization generation:**
   ```bash
   flutter gen-l10n
   ```
3. **Use in code:**
   ```dart
   AppLocalizations.of(context)?.yourKey ?? 'Default text'
   ```

**Supported ARB files:**
- `app_es.arb` - Spanish
- `app_en.arb` - English
- `app_zh.arb` - Chinese
- `app_ko.arb` - Korean
- `app_ja.arb` - Japanese
- `app_it.arb` - Italian

### Adding New Routes

Edit `lib/road/config.dart`:

```dart
GoRoute(
  name: 'my-route',
  path: '/dashboard/my-route',
  builder: (context, state) => MyPage(),
),
```

For routes with parameters:
```dart
GoRoute(
  name: 'detail',
  path: '/dashboard/item/:id',
  builder: (context, state) {
    final id = state.pathParameters['id']!;
    return DetailPage(id: id);
  },
),
```

### Responsive Design

Use breakpoints defined in `ResponsiveLayout`:
- **Mobile**: `width < 856px`
- **Tablet**: `856px ≤ width < 1100px`
- **Desktop**: `width ≥ 1100px`

Example:
```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 856) {
      return MobileLayout();
    } else if (constraints.maxWidth < 1100) {
      return TabletLayout();
    } else {
      return DesktopLayout();
    }
  },
)
```

---

## Code Style & Best Practices

### Naming Conventions

- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables/Methods**: `camelCase`
- **Constants**: `UPPER_SNAKE_CASE`
- **Private members**: `_leadingUnderscore`

### Error Handling

Always handle errors gracefully:

```dart
try {
  final result = await service.doSomething();
  // Handle success
} catch (e) {
  // Extract user-friendly error message
  final errorMessage = _extractErrorMessage(e);
  // Show error to user (SnackBar, Dialog, etc.)
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(errorMessage)),
  );
}
```

### Loading States

Always provide loading indicators for async operations:

```dart
BlocBuilder<MyBloc, MyState>(
  builder: (context, state) {
    if (state.isLoading) {
      return CircularProgressIndicator();
    }
    if (state.hasError) {
      return ErrorWidget(state.errorMessage);
    }
    return ContentWidget(state.data);
  },
)
```

### Comments

- Use comments for complex business logic
- Document public APIs
- Add TODO comments for future improvements
- Remove commented-out code before committing

### Imports

Organize imports in this order:
1. Dart imports
2. Flutter imports
3. Package imports
4. Local imports

Example:
```dart
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:transport_dashboard/models/user.dart';
import 'package:transport_dashboard/service/user_service.dart';
```

---

## Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Writing Tests

Currently, the project has minimal test coverage. When adding tests:

1. **Unit Tests**: Test BLoCs, Services, and utility functions
2. **Widget Tests**: Test UI components
3. **Integration Tests**: Test user flows

Example BLoC test:
```dart
void main() {
  group('MyBloc', () {
    late MyBloc bloc;
    late MockMyService service;

    setUp(() {
      service = MockMyService();
      bloc = MyBloc(service: service);
    });

    test('initial state is InitialState', () {
      expect(bloc.state, InitialState());
    });

    blocTest<MyBloc, MyState>(
      'emits [Loading, Loaded] when LoadEvent is added',
      build: () => bloc,
      act: (bloc) => bloc.add(LoadEvent()),
      expect: () => [
        LoadingState(),
        LoadedState(mockData),
      ],
    );
  });
}
```

---

## Debugging

### Debug Logging

The app uses `debugPrint()` for debug logs. To see API requests/responses, check the console output.

API requests automatically log:
- Request URL and method
- Request data
- Response status and data
- Errors

### Flutter DevTools

Use Flutter DevTools for:
- Widget inspector
- Performance profiling
- Network monitoring
- Memory profiling

Launch DevTools:
```bash
flutter pub global activate devtools
flutter pub global run devtools
```

Then connect from your IDE or run:
```bash
flutter run --debug
```

### Hot Reload vs Hot Restart

- **Hot Reload** (`r`): Fast, preserves state, use for UI changes
- **Hot Restart** (`R`): Slower, resets state, use for logic changes
- **Full Restart**: Stop and run again, use when dependencies change

---

## Building for Production

### Web Build

```bash
# Build for production
flutter build web --release --dart-define-from-file=.env.prod

# Optimize (optional)
flutter build web --release --web-renderer canvaskit --dart-define-from-file=.env.prod
```

**Output:** `build/web/`

**Deployment:**
- Upload `build/web/` contents to your web server
- Ensure server is configured for SPA routing (see `web/_redirects`)

### Android Build

```bash
# APK
flutter build apk --release

# App Bundle (for Play Store)
flutter build appbundle --release
```

**Output:**
- APK: `build/app/outputs/flutter-apk/app-release.apk`
- Bundle: `build/app/outputs/bundle/release/app-release.aab`

### iOS Build (macOS only)

```bash
flutter build ios --release
```

Then open `ios/Runner.xcworkspace` in Xcode and archive.

---

## Environment Variables Reference

### Required

| Variable | Description | Example |
|----------|-------------|---------|
| `API_BASE_URL` | Base URL for API | `https://api.example.com/api` |

### Optional

| Variable | Description | Example |
|----------|-------------|---------|
| `MAPBOX_ACCESS_TOKEN` | Mapbox access token for maps | `pk.eyJ1Ij...` |

### Platform-Specific

**Web:**
- Set via `--dart-define` or `--dart-define-from-file`
- Example: `flutter run -d chrome --dart-define=API_BASE_URL=https://api.example.com/api`

**Mobile:**
- Set in `.env` file (loaded via `flutter_dotenv`)
- Or via `--dart-define` flags

---

## Common Issues & Solutions

### Issue: API calls failing

**Solution:**
- Check `API_BASE_URL` is set correctly
- Verify network connectivity
- Check API server is running
- Review console logs for error messages

### Issue: Localization not updating

**Solution:**
```bash
flutter gen-l10n
flutter clean
flutter pub get
flutter run
```

### Issue: Build fails on Android

**Solution:**
- Check Java version (should be 21+)
- Clean build: `flutter clean && flutter pub get`
- Check `android/gradle.properties` for correct configuration
- Verify Android SDK is installed

### Issue: Token not persisting

**Solution:**
- Check `SharedPreferences` is initialized in `main.dart`
- Verify token is saved after login: `StorageService.prefs.setString('token', token)`
- Check `ApiConfig.configureDio()` is called after login

### Issue: Map not displaying

**Solution:**
- Verify `MAPBOX_ACCESS_TOKEN` is set
- Check token is valid on Mapbox website
- For web, ensure token is passed via `--dart-define` or `--dart-define-from-file`
- Check browser console for map-related errors

---

## Dependencies Management

### Adding Dependencies

Edit `pubspec.yaml`:
```yaml
dependencies:
  new_package: ^1.0.0
```

Then run:
```bash
flutter pub get
```

### Updating Dependencies

```bash
# Check for updates
flutter pub outdated

# Update all
flutter pub upgrade

# Update specific package
flutter pub upgrade package_name
```

### Removing Dependencies

1. Remove from `pubspec.yaml`
2. Run `flutter pub get`
3. Remove unused imports from code

---

## Git Workflow

### Commit Messages

Follow conventional commits:
- `feat: Add new feature`
- `fix: Fix bug`
- `docs: Update documentation`
- `style: Code style changes`
- `refactor: Code refactoring`
- `test: Add tests`
- `chore: Maintenance tasks`

### Branch Strategy

- `main` - Production-ready code
- `develop` - Development branch
- `feature/feature-name` - New features
- `fix/bug-name` - Bug fixes

---

## Performance Optimization

### Image Assets

- Use appropriate image formats (WebP for photos, PNG for icons)
- Optimize image sizes
- Use `FittedBox` for responsive images

### API Calls

- Use `compute()` for heavy JSON parsing (already implemented in `DriversAndBaseService`)
- Implement caching for frequently accessed data
- Poll strategically (current: 3 seconds for drivers data)

### Widget Rebuilding

- Use `const` constructors where possible
- Use `BlocBuilder` with specific state properties
- Avoid unnecessary rebuilds with `BlocSelector`

---

## Security Considerations

1. **Never commit secrets**: `.env` files, tokens, API keys
2. **Use HTTPS**: Always use HTTPS in production
3. **Token storage**: Tokens stored in SharedPreferences (encrypted on iOS)
4. **Input validation**: Validate all user inputs
5. **Error messages**: Don't expose sensitive information in error messages

---

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [BLoC Documentation](https://bloclibrary.dev/)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Dio Documentation](https://pub.dev/packages/dio)
- [Flutter Localization](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)

---

## Getting Help

- Check existing documentation
- Review code comments
- Check Flutter/Dart documentation
- Ask team members
- Search GitHub issues (if applicable)

