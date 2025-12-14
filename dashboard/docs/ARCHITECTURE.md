# Architecture Documentation

This document describes the architecture, design patterns, and structure of the Transport Dashboard application.

## Overview

Transport Dashboard is a Flutter-based web-first application for managing transportation services. It follows a modular architecture using the **BLoC (Business Logic Component) pattern** for state management, with clear separation between presentation, business logic, and data layers.

## Architecture Layers

```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│  (Views, Widgets, Screens)              │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│         State Management                │
│  (BLoC Pattern - Events/States)         │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│         Business Logic                  │
│  (Services, API Client)                 │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│         Data Layer                      │
│  (Models, Storage, External APIs)       │
└─────────────────────────────────────────┘
```

---

## Project Structure

```
lib/
├── api/                    # API configuration and HTTP client
│   └── config.dart         # Dio configuration, request/response handling
├── blocs/                  # State management (BLoC pattern)
│   ├── base/               # Base management state
│   ├── drivers/            # Drivers data state
│   ├── language/           # Language selection state
│   ├── location/           # Location/GPS state
│   ├── menu/               # Navigation menu state
│   └── user/               # Authentication state
├── buttons/                # Reusable button components
├── connection/             # Logout functionality
├── constants/              # App constants
├── controllers/            # Legacy controllers (being phased out)
├── global/                 # Global configuration (environment, etc.)
├── l10n/                   # Localization files (ARB)
├── layout/                 # Responsive layout configuration
├── models/                 # Data models
├── road/                   # Routing configuration (GoRouter)
├── screens/                # Scaffold layouts (mobile, tablet, desktop)
├── service/                # Business logic services
├── utils/                  # Utility functions
├── view/                   # Screen/Page views
├── widgets/                # Reusable UI components
└── main.dart               # App entry point
```

---

## Design Patterns

### 1. BLoC Pattern

The application uses **flutter_bloc** and **hydrated_bloc** for state management.

**Structure:**
- **Events**: User actions or system events that trigger state changes
- **States**: Represents the current state of the application
- **Bloc**: Processes events and emits new states

**Example BLoC Structure:**
```dart
// Event
class LoadDataEvent extends DataEvent {}

// State
class DataLoadedState extends DataState {
  final List<Item> items;
  DataLoadedState(this.items);
}

// BLoC
class DataBloc extends Bloc<DataEvent, DataState> {
  on<LoadDataEvent>((event, emit) async {
    final items = await service.fetchItems();
    emit(DataLoadedState(items));
  });
}
```

### 2. Repository Pattern (via Services)

Services act as repositories, abstracting data sources:
- `AuthService`: Handles authentication operations
- `BaseService`: Manages base creation and operations
- `DriversAndBaseService`: Handles driver and base data fetching
- `StorageService`: Manages local storage (SharedPreferences)

### 3. Dependency Injection

BLoCs and Services are provided via `MultiBlocProvider` in `main.dart`:
```dart
MultiBlocProvider(
  providers: [
    BlocProvider(create: (context) => LanguageBloc()),
    BlocProvider(create: (context) => AuthBloc(authService: AuthService())),
    // ...
  ],
)
```

---

## State Management (BLoCs)

### AuthBloc

**Location:** `lib/blocs/user/auth_bloc.dart`

**Purpose:** Manages user authentication state and session.

**Events:**
- `OnAuthenticatingEvent`: User is attempting to authenticate
- `OnAddUserSessionEvent`: Successful authentication, add user session
- `OnClearUserSessionEvent`: Logout, clear user session
- `OnAuthErrorEvent`: Authentication error occurred
- `OnClearAuthErrorEvent`: Clear error message
- `RequestPasswordResetEvent`: Request password reset email
- `ValidateResetTokenEvent`: Validate password reset token
- `ResetPasswordEvent`: Reset password with token

**States:**
- `authenticando`: Boolean indicating authentication in progress
- `admin`: Admin user object (null if not authenticated)
- `isLoading`: Loading state for async operations
- `errorMessage`: Error message string (nullable)

**Persistence:** Uses `HydratedBloc` to persist user session across app restarts.

---

### LanguageBloc

**Location:** `lib/blocs/language/language_bloc.dart`

**Purpose:** Manages application language and locale selection.

**Events:**
- `LoadLanguageEvent`: Load saved language preference
- `ChangeLanguageEvent`: Change application language

**States:**
- `language`: Currently selected `AppLanguage`
- `locale`: Flutter `Locale` object

**Supported Languages:**
- Spanish (es) - Default
- English (en)
- Chinese (zh)
- Korean (ko)
- Japanese (ja)
- Italian (it)

**Persistence:** 
- Uses `LanguageService` (SharedPreferences) for persistence
- Also uses `HydratedBloc` for state hydration

---

### DriversBloc

**Location:** `lib/blocs/drivers/drivers_bloc.dart`

**Purpose:** Manages drivers data and base information.

**Events:**
- `GetDriversAndBasesEvent`: Fetch drivers and base data

**States:**
- `driversModel`: `DriversModel` containing drivers list and base info

**Features:**
- Automatic polling: Fetches data every 3 seconds for real-time updates
- Immediate initial fetch on event dispatch
- Uses `compute()` for background JSON parsing

---

### BaseBloc

**Location:** `lib/blocs/base/base_bloc.dart`

**Purpose:** Manages base creation operations.

**Events:**
- `CreateBaseEvent`: Create a new base

**States:**
- `baseModel`: Created base model
- Error states for base creation failures

---

### LocationBloc

**Location:** `lib/blocs/location/location_bloc.dart`

**Purpose:** Manages GPS/location state for map interactions.

---

### MenuBloc

**Location:** `lib/blocs/menu/menu_bloc.dart`

**Purpose:** Manages navigation menu state.

---

## Services Layer

### AuthService

**Location:** `lib/service/auth_service.dart`

**Methods:**
- `register(nombre, email, password)`: Register new admin user
- `loginUser(email, password)`: Login existing user
- `requestPasswordReset(email)`: Request password reset email
- `validateResetToken(token)`: Validate reset token
- `resetPassword(token, newPassword)`: Reset password with token

**Features:**
- Error message extraction and normalization
- Token storage in SharedPreferences
- Automatic API configuration after authentication

---

### BaseService

**Location:** `lib/service/base_service.dart`

**Methods:**
- `createBase(baseSelected, uid)`: Create a new base for admin user

**Features:**
- Handles GeoJSON and array coordinate formats
- Error message parsing from backend responses

---

### DriversAndBaseService

**Location:** `lib/service/drivers_base_service.dart`

**Methods:**
- `getDriversAndBase()`: Fetch all drivers and base information
- `putEnableDriver(idDriver)`: Enable a driver for a base

**Features:**
- Uses `compute()` for background JSON parsing (improves UI performance)
- Handles null responses gracefully

---

### StorageService

**Location:** `lib/service/storage_service.dart`

**Purpose:** Centralized SharedPreferences access.

**Usage:**
```dart
StorageService.prefs.setString('key', 'value');
String? value = StorageService.prefs.getString('key');
```

---

### LanguageService

**Location:** `lib/service/language_service.dart`

**Methods:**
- `saveLanguage(language)`: Save selected language preference
- `getSavedLanguage()`: Retrieve saved language preference

---

## Models

Models represent data structures used throughout the application.

### Admin

**Location:** `lib/models/admin.dart`

```dart
class Admin {
  String nombre;
  String email;
  String uid;
  int base;
}
```

### BaseModel

**Location:** `lib/models/bases.dart`

```dart
class BaseModel {
  bool? ok;
  int? base;
  List<double>? ubicacion;  // [longitude, latitude]
  String? adminId;
  String? zonaName;
  List<dynamic>? idDriver;
  int? viajes;
  String? id;
}
```

**Notes:**
- Handles both GeoJSON Point format and simple coordinate arrays
- `ubicacion` can be parsed from `{type: "Point", coordinates: [...]}` or `[lon, lat]`

### DriversModel

**Location:** `lib/models/drivers.dart`

```dart
class DriversModel {
  bool? ok;
  Data? data;
}

class Data {
  String? id;
  int? base;
  int? viajes;
  String? adminId;
  String? zonaName;
  Ubicacion? ubicacion;
  List<Driver>? drivers;
}

class Driver {
  String? id;
  String? nombre;
  String? apellido;
  String? email;
  String? licencia;
  Vehiculo? vehiculo;
  bool? habilitado;
  String? status;  // "online" | "offline"
  int? viajes;
}
```

### TravelModel

**Location:** `lib/models/travels.dart`

Represents trip/viaje data with location information.

---

## Routing

**Location:** `lib/road/config.dart`

Uses **GoRouter** for declarative routing.

### Route Structure

```
/login                    → LoginScreen
/register                 → RegisterScreen
/forgot-password          → ForgotPasswordScreen
/reset-password?token=xxx → ResetPasswordScreen
/dashboard                → Home (Dashboard)
/dashboard/invoice        → FacturaView
/dashboard/create/base    → BasePage (Desktop/Tablet)
/dashboard/create/base/mobile → BasePageMobile
/dashboard/driver/:id     → TravelHistoryPage
/dashboard/drivers/enable → EnableDriverPage
/error                    → ErrorDialog
/dialog                   → CustomDialog
```

### Route Guards

Authentication state is checked via `BlocListener<AuthBloc>`:
- On login success: Redirects to `/dashboard`
- On logout: Redirects to `/login`

### Transitions

All dashboard routes use `FadeTransition` with `Curves.easeInCirc` for smooth page transitions.

---

## Responsive Design

**Location:** `lib/layout/responsive_layout.dart`

The app uses a responsive layout system with breakpoints:

- **Mobile**: `width < 856px`
- **Tablet**: `856px ≤ width < 1100px`
- **Desktop**: `width ≥ 1100px`

Different scaffold layouts are provided for each breakpoint:
- `MobileScaffold`
- `TabletScaffold`
- `DesktopScaffold`

---

## Localization (i18n)

**Location:** `lib/l10n/`

Uses Flutter's standard localization system with ARB files.

### Configuration

- **Config File**: `l10n.yaml`
- **ARB Directory**: `lib/l10n/`
- **Template**: `app_en.arb`
- **Output**: `app_localizations.dart`

### Usage

```dart
AppLocalizations.of(context)?.welcome ?? 'Default text'
```

### Supported Languages

All translations are in `.arb` files:
- `app_es.arb` - Spanish
- `app_en.arb` - English
- `app_zh.arb` - Chinese
- `app_ko.arb` - Korean
- `app_ja.arb` - Japanese
- `app_it.arb` - Italian

---

## API Client

**Location:** `lib/api/config.dart`

Uses **Dio** HTTP client with centralized configuration.

### Features

- Automatic token injection (`x-token` header)
- JSON response parsing
- Error handling and logging
- Debug logging for all requests/responses

### Methods

- `configureDio()`: Initialize Dio with base URL and headers
- `post(path, data)`: POST request
- `get(path)`: GET request
- `put(path)`: PUT request

---

## Environment Configuration

**Location:** `lib/global/environment.dart`

Handles environment variables differently for web and mobile:

**Web:**
- Uses `String.fromEnvironment()` (requires `--dart-define` or `--dart-define-from-file`)

**Mobile:**
- Uses `flutter_dotenv` package (reads from `.env` file)

### Variables

- `API_BASE_URL`: Base URL for API
- `MAPBOX_ACCESS_TOKEN`: Token for Mapbox map tiles

---

## Storage

### SharedPreferences

Used for:
- Authentication token (`token`)
- User ID (`uid`)
- Base number (`base`)
- Language preference (`selected_language_code`)

### HydratedBloc

Used for:
- Persistent BLoC state (e.g., `AuthBloc` user session)
- Automatic serialization/deserialization

**Storage Location:**
- **Web**: Browser localStorage (`HydratedStorage.webStorageDirectory`)
- **Mobile**: App temporary directory

---

## Widget Organization

### Views (`lib/view/`)

Full-screen page views:
- `login_view.dart`, `register_view.dart` - Auth screens
- `home.dart` - Dashboard home
- `base_view.dart`, `base_view_mobile.dart` - Base creation
- `enable_driver_page.dart` - Driver enablement
- `factura.dart` - Invoice view
- `driver_history.dart` - Driver travel history

### Widgets (`lib/widgets/`)

Reusable UI components:
- `sidebar.dart` - Navigation sidebar
- `navbar.dart` - Top navigation bar
- `data_container.dart` - Data table for drivers
- `my_card.dart` - Stat cards (trips, drivers, vehicles)
- `interactive_map.dart` - Map widget (Mapbox/OpenStreetMap)
- `language_selector.dart` - Language selection dropdown
- `top_drivers.dart` - Top drivers list

---

## Key Dependencies

### State Management
- `flutter_bloc: ^8.1.4` - BLoC pattern implementation
- `hydrated_bloc: ^9.1.5` - Persistent BLoC state
- `equatable: ^2.0.5` - Value equality for states/events

### Routing
- `go_router: ^13.2.4` - Declarative routing

### Networking
- `dio: ^5.4.1` - HTTP client

### Localization
- `flutter_localizations` - Flutter localization support
- `intl: ^0.20.2` - Internationalization utilities

### Maps
- `flutter_map: ^8.2.2` - Map widget
- `latlong2: ^0.9.1` - Lat/lng coordinates
- `geolocator: ^12.0.0` - GPS location

### Storage
- `shared_preferences: ^2.2.2` - Key-value storage
- `path_provider: ^2.1.3` - File system paths

### UI
- `google_fonts: ^6.1.0` - Google Fonts integration
- `animated_text_kit: ^4.2.2` - Animated text widgets
- `hexcolor: ^3.0.1` - Hex color support

### Environment
- `flutter_dotenv: ^5.0.2` - Environment variable loading

---

## Best Practices

1. **Separation of Concerns**: Clear separation between UI, business logic, and data
2. **Reactive State**: All state changes flow through BLoCs
3. **Error Handling**: Centralized error handling in services
4. **Type Safety**: Strong typing throughout the application
5. **Localization**: All user-facing strings are localized
6. **Responsive Design**: Layout adapts to screen size
7. **Performance**: Uses `compute()` for heavy JSON parsing
8. **Security**: Tokens stored securely, HTTPS in production

---

## Future Improvements

- [ ] Add unit tests for BLoCs and Services
- [ ] Add integration tests for critical flows
- [ ] Implement caching strategy for API responses
- [ ] Add offline support with local database
- [ ] Implement push notifications
- [ ] Add analytics tracking
- [ ] Performance monitoring

