# Implementación de Selección de Idioma

## ✅ Características Implementadas

1. **6 Idiomas Disponibles:**
   - 🇪🇸 Español (es)
   - 🇬🇧 Inglés (en)
   - 🇨🇳 Chino (zh)
   - 🇰🇷 Coreano (ko)
   - 🇯🇵 Japonés (ja)
   - 🇮🇹 Italiano (it)

2. **Persistencia:** El idioma seleccionado se guarda en SharedPreferences y se carga automáticamente al iniciar la app.

3. **BLoC Pattern:** Usa el mismo patrón que el resto de la aplicación (LanguageBloc).

4. **Widget Selector:** `LanguageSelector` disponible en dos modos:
   - Dropdown (por defecto)
   - Lista (para diálogos o menús)

## 📋 Pasos para Completar la Instalación

1. **Ejecutar dependencias:**
   ```bash
   flutter pub get
   ```

2. **Generar archivos de localización:**
   ```bash
   flutter gen-l10n
   ```
   
   O simplemente ejecutar:
   ```bash
   flutter run
   ```
   (Flutter generará automáticamente los archivos si está configurado)

3. **Descomentar el delegate en main.dart:**
   
   Después de generar los archivos, descomentar esta línea en `lib/main.dart`:
   ```dart
   // AppLocalizations.delegate, // Se generará después de ejecutar flutter gen-l10n
   ```
   
   Cambiar a:
   ```dart
   AppLocalizations.delegate,
   ```

## 🎯 Uso del Widget Selector

### Opción 1: Dropdown (por defecto)
```dart
LanguageSelector()
```

### Opción 2: En un diálogo o menú
```dart
LanguageSelector(
  isDropdown: false,
  showLabel: true,
)
```

### Opción 3: En el Sidebar o AppBar
```dart
LanguageSelector(
  showLabel: false,
  padding: EdgeInsets.symmetric(horizontal: 16),
)
```

## 📝 Ejemplo de Integración en Sidebar

Puedes agregar el selector en el sidebar (`lib/widgets/sidebar.dart`):

```dart
// Agregar después de buildAvatar o en cualquier lugar del menú
LanguageSelector(
  isDropdown: false,
  showLabel: true,
  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
)
```

## 🔄 Uso de Traducciones en el Código

Una vez generados los archivos, puedes usar las traducciones así:

```dart
AppLocalizations.of(context)?.welcome ?? 'Welcome'
AppLocalizations.of(context)?.login ?? 'Login'
```

## 📁 Archivos Creados

- `lib/models/app_language.dart` - Enum de idiomas
- `lib/service/language_service.dart` - Servicio de persistencia
- `lib/blocs/language/` - BLoC para manejo de idioma
- `lib/l10n/app_*.arb` - Archivos de traducción
- `lib/widgets/language_selector.dart` - Widget selector
- `l10n.yaml` - Configuración de localización

## ⚠️ Nota Importante

Los archivos generados de localización (`AppLocalizations`) se crearán en `.dart_tool/flutter_gen/gen_l10n/` después de ejecutar `flutter gen-l10n`.

