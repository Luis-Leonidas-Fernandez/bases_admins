# API Documentation

This document describes the REST API endpoints used by the Transport Dashboard application.

## Base Configuration

The API base URL is configured through environment variables:
- **Web**: Uses `API_BASE_URL` from `--dart-define` flags or `dart-define-from-file`
- **Mobile**: Uses `API_BASE_URL` from `.env` file (via `flutter_dotenv`)

All API requests are handled through the `ApiConfig` class in `lib/api/config.dart`, which uses the Dio HTTP client.

### Authentication

Most endpoints require authentication via the `x-token` header, which is automatically added by `ApiConfig` from `SharedPreferences` after login.

---

## Authentication Endpoints

### 1. User Registration

**POST** `/api/loginadmin/new`

Creates a new admin user account.

**Request Body:**
```json
{
  "nombre": "string",
  "email": "string",
  "password": "string"
}
```

**Response (200 OK):**
```json
{
  "ok": true,
  "admin": {
    "nombre": "string",
    "email": "string",
    "uid": "string",
    "base": 0
  },
  "token": "string"
}
```

**Error Responses:**
- `400 Bad Request`: Invalid input data
- `409 Conflict`: Email already registered

**Service:** `AuthService.register()`

---

### 2. User Login

**POST** `/api/loginadmin/`

Authenticates a user and returns an access token.

**Request Body:**
```json
{
  "email": "string",
  "password": "string"
}
```

**Response (200 OK):**
```json
{
  "ok": true,
  "admin": {
    "nombre": "string",
    "email": "string",
    "uid": "string",
    "base": 0
  },
  "token": "string"
}
```

**Error Responses:**
- `400 Bad Request`: Invalid credentials
- `401 Unauthorized`: Authentication failed
- `404 Not Found`: User not found

**Service:** `AuthService.loginUser()`

---

### 3. Request Password Reset

**POST** `/api/loginadmin/reset-password`

Sends a password reset email to the user.

**Request Body:**
```json
{
  "email": "string"
}
```

**Response (200 OK):**
```json
{
  "ok": true,
  "msg": "Email enviado"
}
```

**Error Responses:**
- `400 Bad Request`: Invalid email
- `429 Too Many Requests`: Too many reset requests (rate limited to 3 per hour per IP)

**Service:** `AuthService.requestPasswordReset()`

**Notes:**
- Does not reveal whether the email exists (security best practice)
- Email contains a link: `{FRONTEND_URL}/reset-password?token=xxx`

---

### 4. Validate Reset Token

**GET** `/api/loginadmin/reset-password/:token`

Validates a password reset token (optional, backend redirects).

**Path Parameters:**
- `token` (string): The reset token from the email

**Behavior:**
- Valid token: Redirects to `{FRONTEND_URL}/reset-password?token=xxx&valid=true`
- Invalid token: Redirects to `{FRONTEND_URL}/reset-password?error=token_invalido`
- Expired token: Redirects to `{FRONTEND_URL}/reset-password?error=token_expirado`

**Service:** `AuthService.validateResetToken()`

---

### 5. Reset Password

**POST** `/api/loginadmin/reset-password/:token`

Resets the user's password using a valid token.

**Path Parameters:**
- `token` (string): The reset token from the email

**Request Body:**
```json
{
  "newPassword": "string"
}
```

**Password Requirements:**
- Minimum 6 characters

**Response (200 OK):**
```json
{
  "ok": true,
  "msg": "Contraseña restablecida correctamente"
}
```

**Error Responses:**
- `400 Bad Request`: Token invalid/expired or password too short
- `400 Bad Request`: `"La contraseña debe tener al menos 6 caracteres"`

**Service:** `AuthService.resetPassword()`

**Notes:**
- Token expires after 1 hour
- Token is invalidated after use (one-time use)

---

## Base Management Endpoints

### 6. Create Base

**POST** `/api/base/new/:uid`

Creates a new base for an admin user.

**Path Parameters:**
- `uid` (string): Admin user ID

**Request Body:**
```json
{
  "ubicacion": [longitude, latitude]
}
```

**Response (200 OK):**
```json
{
  "ok": true,
  "result": {
    "_id": "string",
    "base": 0,
    "ubicacion": [longitude, latitude],
    "adminId": "string",
    "zonaName": "string",
    "viajes": 0
  }
}
```

**Alternative Response Format:**
```json
{
  "ok": true,
  "data": {
    // Same structure as above
  }
}
```

**Error Responses:**
- `400 Bad Request`: Invalid location data
- `500 Internal Server Error`: Server error creating base

**Service:** `BaseService.createBase()`

**Notes:**
- The backend automatically calculates `zonaName` and `base` number based on location
- Only `ubicacion` (coordinates) needs to be sent

---

## Driver Management Endpoints

### 7. Get Drivers and Base Information

**GET** `/api/base/drivers-from-admin/:uid/:base`

Retrieves all drivers subscribed to a specific base and base information.

**Path Parameters:**
- `uid` (string): Admin user ID
- `base` (string): Base number/ID

**Headers:**
- `x-token` (required): Authentication token

**Response (200 OK):**
```json
{
  "ok": true,
  "data": {
    "_id": "string",
    "base": 0,
    "viajes": 0,
    "adminId": "string",
    "zonaName": "string",
    "ubicacion": {
      "type": "Point",
      "coordinates": [longitude, latitude]
    },
    "drivers": [
      {
        "_id": "string",
        "nombre": "string",
        "apellido": "string",
        "email": "string",
        "licencia": "string",
        "vehiculo": {
          "patente": "string",
          "modelo": "string"
        },
        "habilitado": true,
        "status": "online" | "offline",
        "viajes": 0
      }
    ]
  }
}
```

**Service:** `DriversAndBaseService.getDriversAndBase()`

**Notes:**
- This endpoint is polled every 3 seconds in `DriversBloc` for real-time updates
- Data is processed using `compute()` for better performance

---

### 8. Enable Driver

**PUT** `/api/base/enable-driver/:idDriver`

Enables a driver to work within a base.

**Path Parameters:**
- `idDriver` (string): Driver ID

**Headers:**
- `x-token` (required): Authentication token

**Response (200 OK):**
```json
{
  "ok": true,
  "data": {
    // Updated drivers list and base information
    // Same structure as GET /api/base/drivers-from-admin
  }
}
```

**Error Responses:**
- `400 Bad Request`: Invalid driver ID
- `404 Not Found`: Driver not found
- `401 Unauthorized`: Invalid or missing token

**Service:** `DriversAndBaseService.putEnableDriver()`

---

## Error Handling

All API errors are handled uniformly through `ApiConfig`:

1. **HTTP Status Codes >= 400**: Thrown as `DioException`
2. **Error Message Extraction**: 
   - Backend may return errors in `msg`, `message`, or `error` fields
   - `AuthService._extractErrorMessage()` normalizes these messages
3. **User-Friendly Messages**: Error messages are normalized and include emojis for better UX

### Common Error Scenarios

| Status Code | Description | User Message |
|------------|-------------|--------------|
| 400 | Bad Request | Credenciales incorrectas |
| 401 | Unauthorized | No autorizado. Verifica tus credenciales |
| 404 | Not Found | Usuario no encontrado |
| 409 | Conflict | El email ya está registrado |
| 429 | Too Many Requests | Demasiadas solicitudes. Intenta más tarde |
| 500+ | Server Error | Error del servidor. Intenta más tarde |

---

## Data Models

### Admin
```dart
{
  "nombre": "string",
  "email": "string",
  "uid": "string",
  "base": 0
}
```

### Base
```dart
{
  "_id": "string",
  "base": 0,
  "ubicacion": [longitude, latitude], // or GeoJSON Point
  "adminId": "string",
  "zonaName": "string",
  "viajes": 0
}
```

### Driver
```dart
{
  "_id": "string",
  "nombre": "string",
  "apellido": "string",
  "email": "string",
  "licencia": "string",
  "vehiculo": {
    "patente": "string",
    "modelo": "string"
  },
  "habilitado": true,
  "status": "online" | "offline",
  "viajes": 0
}
```

### Travel (Viaje)
```dart
{
  "_id": "string",
  "driverId": "string",
  "ubicacion": {
    "type": "Point",
    "coordinates": [longitude, latitude]
  },
  "destino": {
    "type": "Point",
    "coordinates": [longitude, latitude]
  },
  "distancia": 0.0,
  "precio": 0,
  "finalizado": true,
  "createdAt": "ISO8601 datetime",
  "updatedAt": "ISO8601 datetime"
}
```

---

## Configuration

### Environment Variables

**Required:**
- `API_BASE_URL`: Base URL for the API (e.g., `https://api.example.com`)

**Optional:**
- `MAPBOX_ACCESS_TOKEN`: Token for Mapbox map tiles (used in interactive maps)

### Storage

After successful authentication, the following are stored in `SharedPreferences`:
- `token`: Authentication token (used in `x-token` header)
- `uid`: Admin user ID
- `base`: Base number/ID

---

## Rate Limiting

- **Password Reset**: Maximum 3 requests per hour per IP address
- Other endpoints: No explicit rate limits documented

---

## Security Notes

1. **Token Storage**: Tokens are stored in `SharedPreferences` (encrypted on iOS, unencrypted on Android)
2. **Password Reset**: Tokens expire after 1 hour and are single-use
3. **HTTPS**: Always use HTTPS in production
4. **Error Messages**: The API does not reveal whether an email exists during password reset (security best practice)

