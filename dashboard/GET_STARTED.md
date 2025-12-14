# Getting Started 🚀

Guía rápida para comenzar con Transport Dashboard.

## Requisitos Previos

Antes de comenzar, asegúrate de tener instalado:

- **Flutter SDK**: Versión 3.2.3 o superior
- **Dart SDK**: Incluido con Flutter
- **Git**: Para clonar el repositorio
- **IDE**: VS Code o Android Studio (recomendado)

### Opcionales según plataforma:

- **Para Android**: Android Studio, Android SDK, Java 21+
- **Para iOS** (solo macOS): Xcode 14+, CocoaPods
- **Para Web**: Chrome o Edge para pruebas

---

## Instalación Rápida

### 1. Clonar el Repositorio

```bash
git clone <repository-url>
cd dashboard
```

### 2. Instalar Dependencias

```bash
flutter pub get
```

### 3. Configurar Variables de Entorno

#### Para Desarrollo Web:

Crea un archivo `.env.dev` en la raíz del proyecto:

```env
API_BASE_URL=https://tu-api-url.com/api
MAPBOX_ACCESS_TOKEN=tu_token_de_mapbox
```

#### Para Desarrollo Mobile:

Crea un archivo `.env` en la raíz del proyecto:

```env
API_BASE_URL=https://tu-api-url.com/api
MAPBOX_ACCESS_TOKEN=tu_token_de_mapbox
```

> ⚠️ **Importante**: Los archivos `.env` no deben ser commiteados. Ya están en `.gitignore`.

### 4. Ejecutar la Aplicación

#### Web (Recomendado para desarrollo)

```bash
# Usando el script (más fácil)
./run_web.sh dev

# O manualmente
flutter run -d chrome --dart-define-from-file=.env.dev
```

#### Android

```bash
flutter run
```

#### iOS (solo macOS)

```bash
flutter run
```

---

## Estructura del Proyecto

```
lib/
├── api/           # Configuración del cliente API
├── blocs/         # Gestión de estado (BLoC)
├── models/        # Modelos de datos
├── service/       # Lógica de negocio
├── view/          # Pantallas/Vistas
├── widgets/       # Componentes reutilizables
├── road/          # Configuración de rutas
└── main.dart      # Punto de entrada
```

---

## Comandos Útiles

### Desarrollo

```bash
# Ejecutar en modo desarrollo
flutter run

# Ejecutar en web con archivo de entorno
flutter run -d chrome --dart-define-from-file=.env.dev

# Hot reload (presiona 'r' en la terminal)
# Hot restart (presiona 'R' en la terminal)
```

### Construcción

```bash
# Build para Web
flutter build web --dart-define-from-file=.env.prod

# Build para Android (APK)
flutter build apk --release

# Build para Android (App Bundle - Play Store)
flutter build appbundle --release

# Build para iOS
flutter build ios --release
```

### Utilidades

```bash
# Limpiar build
flutter clean

# Actualizar dependencias
flutter pub get

# Generar localizaciones
flutter gen-l10n

# Análisis de código
flutter analyze
```

---

## Configuración Inicial

### 1. API Base URL

Necesitas configurar la URL base de tu API:

**Web:**
```bash
# En .env.dev o .env.prod
API_BASE_URL=https://api.ejemplo.com/api
```

**Mobile:**
```bash
# En .env
API_BASE_URL=https://api.ejemplo.com/api
```

### 2. Mapbox Token (Opcional)

Si usas mapas interactivos, necesitas un token de Mapbox:

1. Crea una cuenta en [Mapbox](https://www.mapbox.com/)
2. Obtén tu Access Token
3. Agrégalo a tu archivo `.env`:

```env
MAPBOX_ACCESS_TOKEN=pk.eyJ1Ijoi...
```

> 💡 **Nota**: Si no configuras Mapbox, la app usará OpenStreetMap como alternativa.

---

## Primera Ejecución

1. **Configura las variables de entorno** (ver arriba)
2. **Ejecuta la aplicación**:
   ```bash
   ./run_web.sh dev
   # o
   flutter run -d chrome
   ```
3. **Accede a la aplicación**:
   - La URL se mostrará en la terminal (generalmente `http://localhost:xxxx`)
   - Abre tu navegador en esa URL

---

## Problemas Comunes

### ❌ Error: "API_BASE_URL no está configurada"

**Solución**: Asegúrate de haber creado el archivo `.env.dev` (web) o `.env` (mobile) con la variable `API_BASE_URL`.

### ❌ Error: "Package not found"

**Solución**: Ejecuta `flutter pub get` para instalar las dependencias.

### ❌ Error: "Port already in use"

**Solución**: 
```bash
# Encuentra y mata el proceso
lsof -ti:xxxx | xargs kill -9

# O usa otro puerto
flutter run -d chrome --web-port=8080
```

### ❌ Error: "Cannot run with sound null safety"

**Solución**: El proyecto usa null safety. Asegúrate de tener Flutter 3.2.3+ instalado.

### ❌ Localizaciones no se actualizan

**Solución**:
```bash
flutter gen-l10n
flutter clean
flutter pub get
```

---

## Siguiente Paso

Una vez que tengas la aplicación ejecutándose:

1. ✅ Lee la [Documentación Completa](./docs/README.md)
2. ✅ Revisa la [Guía de Desarrollo](./docs/DEVELOPMENT.md)
3. ✅ Consulta la [Documentación de API](./docs/API.md)
4. ✅ Estudia la [Arquitectura](./docs/ARCHITECTURE.md)

---

## Recursos Adicionales

- [Flutter Documentation](https://flutter.dev/docs)
- [BLoC Library](https://bloclibrary.dev/)
- [GoRouter](https://pub.dev/packages/go_router)
- [Dio HTTP Client](https://pub.dev/packages/dio)

---

## ¿Necesitas Ayuda?

1. Revisa la [documentación completa](./docs/)
2. Consulta los comentarios en el código
3. Revisa los logs en la consola
4. Contacta al equipo de desarrollo

---

**¡Listo para comenzar!** 🎉

Si tienes alguna pregunta, consulta la [documentación completa](./docs/) o el [README principal](./README.md).

