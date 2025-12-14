# Transport Dashboard

A responsive Flutter web application for managing transportation services with real-time driver tracking, base management, and comprehensive admin features.

## 🚀 Features

- **🔐 Admin Authentication**: Secure login/registration with email password recovery
- **📍 Base Management**: Interactive map-based base creation and management
- **👥 Driver Management**: Real-time driver tracking, enablement, and status monitoring
- **🌍 Multi-language Support**: 6 languages (Spanish, English, Chinese, Korean, Japanese, Italian)
- **📱 Responsive Design**: Optimized for mobile, tablet, and desktop
- **🗺️ Interactive Maps**: Mapbox/OpenStreetMap integration for location selection
- **📊 Real-time Updates**: Live data polling for drivers and base information
- **🎨 Modern UI**: Beautiful, intuitive interface with smooth animations

## 🛠️ Technology Stack

- **Framework**: Flutter 3.2.3+
- **State Management**: BLoC Pattern (flutter_bloc, hydrated_bloc)
- **Routing**: GoRouter
- **HTTP Client**: Dio
- **Localization**: Flutter Localization (ARB files)
- **Maps**: flutter_map (Mapbox/OpenStreetMap)
- **Storage**: SharedPreferences, HydratedBloc

## 📋 Prerequisites

- Flutter SDK 3.2.3 or higher
- Dart SDK (included with Flutter)
- IDE: VS Code or Android Studio (recommended)
- For Android: Java 21+, Android SDK
- For iOS: Xcode 14+ (macOS only)

## 🏁 Quick Start

### 1. Clone the repository

```bash
git clone <repository-url>
cd dashboard
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure environment variables

**For Web Development:**

Create `.env.dev` or `.env.prod` files:

```env
API_BASE_URL=https://your-api-url.com/api
MAPBOX_ACCESS_TOKEN=your_mapbox_token_here
```

**For Mobile Development:**

Create `.env` file in the project root:

```env
API_BASE_URL=https://your-api-url.com/api
MAPBOX_ACCESS_TOKEN=your_mapbox_token_here
```

### 4. Run the application

**Web:**
```bash
# Development
./run_web.sh dev

# Or manually
flutter run -d chrome --dart-define-from-file=.env.dev
```

**Android:**
```bash
flutter run
```

**iOS (macOS only):**
```bash
flutter run
```

## 📚 Documentation

Comprehensive documentation is available in the [`docs/`](./docs/) directory:

- **[API Documentation](./docs/API.md)** - Complete API endpoint reference
- **[Architecture Guide](./docs/ARCHITECTURE.md)** - Application structure and design patterns
- **[Development Guide](./docs/DEVELOPMENT.md)** - Setup, workflow, and best practices
- **[Documentation Index](./docs/README.md)** - Complete documentation overview

For detailed setup instructions, code style guidelines, and troubleshooting, see the [Development Guide](./docs/DEVELOPMENT.md).

## 🏗️ Project Structure

```
lib/
├── api/           # API client configuration
├── blocs/         # State management (BLoC pattern)
├── models/        # Data models
├── service/       # Business logic services
├── view/          # Screen views
├── widgets/       # Reusable UI components
├── road/          # Routing configuration
├── l10n/          # Localization files
└── main.dart      # App entry point
```

See [ARCHITECTURE.md](./docs/ARCHITECTURE.md) for detailed structure documentation.

## 🌐 Supported Languages

- 🇪🇸 Spanish (Español) - Default
- 🇬🇧 English
- 🇨🇳 Chinese (中文)
- 🇰🇷 Korean (한국어)
- 🇯🇵 Japanese (日本語)
- 🇮🇹 Italian (Italiano)

Language preference is persisted and can be changed at any time from the UI.

## 📱 Platform Support

- ✅ **Web**: Primary platform, fully optimized
- ✅ **Android**: Fully configured and tested
- ⚠️ **iOS**: Configured but requires macOS for development

## 🔧 Building for Production

### Web

```bash
flutter build web --release --dart-define-from-file=.env.prod
```

### Android

```bash
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

See [DEVELOPMENT.md](./docs/DEVELOPMENT.md) for detailed build instructions.

## 🔐 Environment Variables

### Required

- `API_BASE_URL` - Base URL for the backend API

### Optional

- `MAPBOX_ACCESS_TOKEN` - Mapbox access token for map tiles

See [DEVELOPMENT.md](./docs/DEVELOPMENT.md) for configuration details.

## 🤝 Contributing

1. Follow the code style guidelines in [DEVELOPMENT.md](./docs/DEVELOPMENT.md)
2. Use the BLoC pattern for state management
3. Add translations for all user-facing strings
4. Write tests for new features
5. Update documentation as needed

## 📄 License

This project is under a **Restricted Custom License**.  
Any use, modification or distribution requires **explicit written permission** from the author.  
See [LICENSE.md](./LICENSE.md) for full terms.

## 📞 Support

For questions or issues:

1. Check the [documentation](./docs/)
2. Review code comments
3. Check Flutter/Dart documentation
4. Contact the development team

## 🔗 Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [BLoC Library](https://bloclibrary.dev/)
- [GoRouter Package](https://pub.dev/packages/go_router)
- [Dio HTTP Client](https://pub.dev/packages/dio)

## 📝 Version

Current version: **1.0.0+1**

---

**Note**: For detailed documentation, architecture information, API reference, and development guides, please refer to the [`docs/`](./docs/) directory.
