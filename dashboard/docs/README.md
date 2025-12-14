# Transport Dashboard - Documentation

Welcome to the Transport Dashboard documentation. This directory contains comprehensive documentation for developers working on or integrating with the application.

## Documentation Index

### 📡 [API.md](./API.md)
Complete API documentation including:
- Authentication endpoints (login, register, password reset)
- Base management endpoints
- Driver management endpoints
- Request/response formats
- Error handling
- Data models

**Use this when:** Integrating with the backend API or understanding API contracts.

---

### 🏗️ [ARCHITECTURE.md](./ARCHITECTURE.md)
Architecture and design documentation covering:
- Application architecture layers
- Project structure
- Design patterns (BLoC, Repository, Dependency Injection)
- State management (BLoCs)
- Services layer
- Data models
- Routing configuration
- Responsive design system
- Localization system

**Use this when:** Understanding how the application is structured, adding new features, or onboarding new developers.

---

### 💻 [DEVELOPMENT.md](./DEVELOPMENT.md)
Development guide including:
- Setup instructions
- Development workflow
- Code style and best practices
- Testing guidelines
- Debugging tips
- Building for production
- Environment configuration
- Common issues and solutions

**Use this when:** Setting up your development environment, writing code, or troubleshooting issues.

---

## Quick Start

1. **New to the project?** Start with [DEVELOPMENT.md](./DEVELOPMENT.md) for setup instructions.
2. **Understanding the codebase?** Read [ARCHITECTURE.md](./ARCHITECTURE.md) to learn the structure.
3. **Integrating with API?** Check [API.md](./API.md) for endpoint documentation.

---

## Project Overview

Transport Dashboard is a Flutter-based web-first application for managing transportation services. It provides:

- **Admin Authentication**: Secure login/registration with password recovery
- **Base Management**: Create and manage transportation bases on a map
- **Driver Management**: View, enable, and manage drivers
- **Real-time Updates**: Live data polling for drivers and bases
- **Multi-language Support**: 6 languages (Spanish, English, Chinese, Korean, Japanese, Italian)
- **Responsive Design**: Works on mobile, tablet, and desktop
- **Interactive Maps**: Mapbox/OpenStreetMap integration for base creation

---

## Technology Stack

- **Framework**: Flutter 3.2.3+
- **State Management**: BLoC Pattern (flutter_bloc, hydrated_bloc)
- **Routing**: GoRouter
- **HTTP Client**: Dio
- **Localization**: Flutter Localization (ARB files)
- **Maps**: flutter_map (Mapbox/OpenStreetMap)
- **Storage**: SharedPreferences, HydratedBloc

---

## Key Features

### Authentication & Security
- User registration and login
- Password reset via email
- Token-based authentication
- Secure token storage

### Base Management
- Interactive map for base creation
- Automatic zone/base calculation
- Base information display

### Driver Management
- Real-time driver list
- Driver enablement
- Driver status (online/offline)
- Vehicle information
- Trip history

### Internationalization
- 6 supported languages
- Persistent language preference
- Dynamic language switching

### Responsive UI
- Mobile-first design
- Adaptive layouts for different screen sizes
- Smooth transitions and animations

---

## Project Structure

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

See [ARCHITECTURE.md](./ARCHITECTURE.md) for detailed structure.

---

## Getting Started

### Prerequisites

- Flutter SDK 3.2.3+
- Dart SDK (included with Flutter)
- IDE (VS Code or Android Studio recommended)

### Setup

1. Clone the repository
2. Install dependencies: `flutter pub get`
3. Configure environment variables (see [DEVELOPMENT.md](./DEVELOPMENT.md))
4. Run the app: `flutter run -d chrome`

For detailed setup instructions, see [DEVELOPMENT.md](./DEVELOPMENT.md).

---

## API Integration

The application communicates with a REST API. All endpoints are documented in [API.md](./API.md).

### Base URL Configuration

- **Web**: Set via `--dart-define` or `--dart-define-from-file`
- **Mobile**: Set in `.env` file

### Authentication

Most endpoints require an authentication token in the `x-token` header, which is automatically added after login.

---

## Contributing

When contributing to the project:

1. Follow the code style guidelines in [DEVELOPMENT.md](./DEVELOPMENT.md)
2. Use the BLoC pattern for state management
3. Add translations for all user-facing strings
4. Write tests for new features
5. Update documentation as needed

---

## Support

For questions or issues:

1. Check the relevant documentation file
2. Review code comments
3. Check Flutter/Dart documentation
4. Contact the development team

---

## License

See the main project LICENSE file for license information.

---

## Version

This documentation corresponds to the application version **1.0.0+1**.

---

## Changelog

### Recent Updates

- Password recovery feature implemented
- Multi-language support added (6 languages)
- Responsive design improvements
- Real-time driver data polling
- Interactive map integration

---

## Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [BLoC Library](https://bloclibrary.dev/)
- [GoRouter Package](https://pub.dev/packages/go_router)
- [Dio HTTP Client](https://pub.dev/packages/dio)

---

**Last Updated**: Generated automatically on documentation creation

