# API Documentation

This directory contains API documentation for communication between the mobile app and the hardware controller.

## API Overview

The Automated Water Pump Controller exposes a RESTful API for communication with the mobile application. The API supports both HTTP/HTTPS and WebSocket connections for real-time updates.

## Base URL
- **Development**: `http://192.168.1.100:8080/api/v1`
- **Production**: `https://your-domain.com/api/v1`

## Authentication

### API Key Authentication
All API requests require an API key in the header:
```
Authorization: Bearer YOUR_API_KEY
```

### Device Pairing
Initial device setup requires pairing process:
```http
POST /auth/pair
{
  "device_id": "ESP32_XXXXXX",
  "pairing_code": "123456"
}
```

## Endpoints

### Device Status
Get current device status and sensor readings.

#### GET `/status`
**Response:**
```json
{
  "status": "online",
  "timestamp": "2025-11-02T10:30:00Z",
  "water_level": {
    "current": 75.5,
    "unit": "cm",
    "percentage": 85
  },
  "pump": {
    "status": "running",
    "last_started": "2025-11-02T10:15:00Z",
    "runtime_today": 120
  },
  "system": {
    "uptime": 3600,
    "wifi_signal": -45,
    "free_memory": 180000
  }
}
```

### Pump Control
Control pump operations manually or automatically.

#### POST `/pump/control`
**Request:**
```json
{
  "action": "start|stop|auto",
  "duration": 300  // Optional: run time in seconds
}
```

**Response:**
```json
{
  "success": true,
  "message": "Pump started successfully",
  "new_status": "running"
}
```

### Configuration
Get and update device configuration.

#### GET `/config`
**Response:**
```json
{
  "auto_mode": true,
  "water_level_thresholds": {
    "low": 20.0,
    "high": 80.0
  },
  "pump_settings": {
    "max_runtime": 1800,
    "cooldown_period": 300
  },
  "notifications": {
    "low_water": true,
    "pump_failure": true,
    "system_offline": true
  }
}
```

#### PUT `/config`
**Request:**
```json
{
  "auto_mode": false,
  "water_level_thresholds": {
    "low": 25.0,
    "high": 85.0
  }
}
```

### Historical Data
Retrieve historical sensor data and pump activity.

#### GET `/history/water-level`
**Query Parameters:**
- `start`: Start date (ISO 8601)
- `end`: End date (ISO 8601)
- `interval`: Data interval (minute, hour, day)

**Response:**
```json
{
  "data": [
    {
      "timestamp": "2025-11-02T10:00:00Z",
      "level": 72.3,
      "percentage": 81
    },
    {
      "timestamp": "2025-11-02T10:05:00Z",
      "level": 71.8,
      "percentage": 80
    }
  ],
  "total_records": 288
}
```

#### GET `/history/pump-activity`
**Response:**
```json
{
  "activities": [
    {
      "start_time": "2025-11-02T08:15:00Z",
      "end_time": "2025-11-02T08:20:00Z",
      "duration": 300,
      "trigger": "auto",
      "water_level_before": 18.5,
      "water_level_after": 82.3
    }
  ]
}
```

### Scheduling
Manage pump scheduling and automation rules.

#### GET `/schedules`
**Response:**
```json
{
  "schedules": [
    {
      "id": 1,
      "name": "Morning Fill",
      "enabled": true,
      "time": "06:00",
      "days": ["monday", "wednesday", "friday"],
      "duration": 600
    }
  ]
}
```

#### POST `/schedules`
**Request:**
```json
{
  "name": "Evening Top-up",
  "time": "18:00",
  "days": ["daily"],
  "duration": 300,
  "enabled": true
}
```

### Notifications
Manage system notifications and alerts.

#### GET `/notifications`
**Response:**
```json
{
  "notifications": [
    {
      "id": 1,
      "type": "warning",
      "title": "Low Water Level",
      "message": "Water level is below threshold (15%)",
      "timestamp": "2025-11-02T09:45:00Z",
      "read": false
    }
  ]
}
```

#### PUT `/notifications/{id}/read`
Mark notification as read.

## WebSocket API

### Connection
Connect to WebSocket for real-time updates:
```
ws://192.168.1.100:8080/ws
```

### Message Format
```json
{
  "type": "water_level_update",
  "data": {
    "level": 75.5,
    "percentage": 85,
    "timestamp": "2025-11-02T10:30:00Z"
  }
}
```

### Message Types
- `water_level_update`: Real-time water level data
- `pump_status_change`: Pump state changes
- `system_alert`: System alerts and warnings
- `config_update`: Configuration changes

## Error Handling

### HTTP Status Codes
- `200 OK`: Request successful
- `201 Created`: Resource created
- `400 Bad Request`: Invalid request data
- `401 Unauthorized`: Authentication required
- `403 Forbidden`: Access denied
- `404 Not Found`: Resource not found
- `429 Too Many Requests`: Rate limit exceeded
- `500 Internal Server Error`: Server error

### Error Response Format
```json
{
  "error": {
    "code": "INVALID_PARAMETER",
    "message": "Water level threshold must be between 0 and 100",
    "details": {
      "parameter": "water_level_thresholds.low",
      "value": -5
    }
  }
}
```

## Rate Limiting
- 100 requests per minute per API key
- WebSocket: 1 connection per device
- Historical data: 10 requests per minute

## Data Types

### Water Level
```typescript
interface WaterLevel {
  current: number;      // cm
  unit: string;        // "cm" | "inches"
  percentage: number;  // 0-100
}
```

### Pump Status
```typescript
interface PumpStatus {
  status: "running" | "stopped" | "error";
  last_started?: string;    // ISO 8601
  runtime_today: number;   // seconds
}
```

## SDKs and Examples

### JavaScript/TypeScript
```javascript
// Example API call
const response = await fetch('/api/v1/status', {
  headers: {
    'Authorization': 'Bearer YOUR_API_KEY',
    'Content-Type': 'application/json'
  }
});
const data = await response.json();
```

### Flutter/Dart
```dart
// Example API service
class WaterPumpAPI {
  Future<DeviceStatus> getStatus() async {
    final response = await http.get(
      Uri.parse('$baseUrl/status'),
      headers: {'Authorization': 'Bearer $apiKey'},
    );
    return DeviceStatus.fromJson(json.decode(response.body));
  }
}
```

## Testing

### Postman Collection
Import the provided Postman collection for API testing.

### Mock Server
Use the mock server for development and testing:
```bash
npm install -g json-server
json-server --watch api-mock.json --port 8080
```

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| v1.0 | 2025-11-02 | Initial API design |

## Support

For API support and questions:
- GitHub Issues: Technical problems
- Documentation: Check README files
- Team Chat: Quick questions