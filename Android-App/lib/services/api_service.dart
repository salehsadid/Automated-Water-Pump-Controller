import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.1.100:8080/api/v1';
  static const String apiKey = 'your-api-key-here'; // Replace with actual API key
  
  final http.Client _client = http.Client();
  
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  // Get device status including water level and pump status
  Future<DeviceStatus> getDeviceStatus() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/status'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return DeviceStatus.fromJson(data);
      } else {
        throw ApiException('Failed to get device status: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  // Control pump (start/stop)
  Future<PumpControlResponse> controlPump({
    required String action, // 'start', 'stop', or 'auto'
    int? duration, // Optional duration in seconds
  }) async {
    try {
      final body = {
        'action': action,
        if (duration != null) 'duration': duration,
      };

      final response = await _client.post(
        Uri.parse('$baseUrl/pump/control'),
        headers: _headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return PumpControlResponse.fromJson(data);
      } else {
        throw ApiException('Failed to control pump: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  // Get device configuration
  Future<DeviceConfig> getConfig() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/config'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return DeviceConfig.fromJson(data);
      } else {
        throw ApiException('Failed to get config: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}

// Data models
class DeviceStatus {
  final String status;
  final DateTime timestamp;
  final WaterLevel waterLevel;
  final PumpInfo pump;
  final SystemInfo system;

  DeviceStatus({
    required this.status,
    required this.timestamp,
    required this.waterLevel,
    required this.pump,
    required this.system,
  });

  factory DeviceStatus.fromJson(Map<String, dynamic> json) {
    return DeviceStatus(
      status: json['status'],
      timestamp: DateTime.parse(json['timestamp']),
      waterLevel: WaterLevel.fromJson(json['water_level']),
      pump: PumpInfo.fromJson(json['pump']),
      system: SystemInfo.fromJson(json['system']),
    );
  }

  // Mock data for testing
  factory DeviceStatus.mock() {
    return DeviceStatus(
      status: 'online',
      timestamp: DateTime.now(),
      waterLevel: WaterLevel.mock(),
      pump: PumpInfo.mock(),
      system: SystemInfo.mock(),
    );
  }
}

class WaterLevel {
  final double current;
  final String unit;
  final double percentage;

  WaterLevel({
    required this.current,
    required this.unit,
    required this.percentage,
  });

  factory WaterLevel.fromJson(Map<String, dynamic> json) {
    return WaterLevel(
      current: json['current'].toDouble(),
      unit: json['unit'],
      percentage: json['percentage'].toDouble(),
    );
  }

  factory WaterLevel.mock() {
    return WaterLevel(
      current: 75.5,
      unit: 'cm',
      percentage: 85.0,
    );
  }
}

class PumpInfo {
  final String status;
  final DateTime? lastStarted;
  final int runtimeToday;

  PumpInfo({
    required this.status,
    this.lastStarted,
    required this.runtimeToday,
  });

  factory PumpInfo.fromJson(Map<String, dynamic> json) {
    return PumpInfo(
      status: json['status'],
      lastStarted: json['last_started'] != null 
          ? DateTime.parse(json['last_started'])
          : null,
      runtimeToday: json['runtime_today'],
    );
  }

  factory PumpInfo.mock() {
    return PumpInfo(
      status: 'stopped',
      lastStarted: DateTime.now().subtract(const Duration(hours: 2)),
      runtimeToday: 9000, // 2.5 hours in seconds
    );
  }
}

class SystemInfo {
  final int uptime;
  final int wifiSignal;
  final int freeMemory;

  SystemInfo({
    required this.uptime,
    required this.wifiSignal,
    required this.freeMemory,
  });

  factory SystemInfo.fromJson(Map<String, dynamic> json) {
    return SystemInfo(
      uptime: json['uptime'],
      wifiSignal: json['wifi_signal'],
      freeMemory: json['free_memory'],
    );
  }

  factory SystemInfo.mock() {
    return SystemInfo(
      uptime: 3600,
      wifiSignal: -45,
      freeMemory: 180000,
    );
  }
}

class PumpControlResponse {
  final bool success;
  final String message;
  final String newStatus;

  PumpControlResponse({
    required this.success,
    required this.message,
    required this.newStatus,
  });

  factory PumpControlResponse.fromJson(Map<String, dynamic> json) {
    return PumpControlResponse(
      success: json['success'],
      message: json['message'],
      newStatus: json['new_status'],
    );
  }
}

class DeviceConfig {
  final bool autoMode;
  final WaterLevelThresholds waterLevelThresholds;
  final PumpSettings pumpSettings;
  final NotificationSettings notifications;

  DeviceConfig({
    required this.autoMode,
    required this.waterLevelThresholds,
    required this.pumpSettings,
    required this.notifications,
  });

  factory DeviceConfig.fromJson(Map<String, dynamic> json) {
    return DeviceConfig(
      autoMode: json['auto_mode'],
      waterLevelThresholds: WaterLevelThresholds.fromJson(json['water_level_thresholds']),
      pumpSettings: PumpSettings.fromJson(json['pump_settings']),
      notifications: NotificationSettings.fromJson(json['notifications']),
    );
  }
}

class WaterLevelThresholds {
  final double low;
  final double high;

  WaterLevelThresholds({required this.low, required this.high});

  factory WaterLevelThresholds.fromJson(Map<String, dynamic> json) {
    return WaterLevelThresholds(
      low: json['low'].toDouble(),
      high: json['high'].toDouble(),
    );
  }
}

class PumpSettings {
  final int maxRuntime;
  final int cooldownPeriod;

  PumpSettings({required this.maxRuntime, required this.cooldownPeriod});

  factory PumpSettings.fromJson(Map<String, dynamic> json) {
    return PumpSettings(
      maxRuntime: json['max_runtime'],
      cooldownPeriod: json['cooldown_period'],
    );
  }
}

class NotificationSettings {
  final bool lowWater;
  final bool pumpFailure;
  final bool systemOffline;

  NotificationSettings({
    required this.lowWater,
    required this.pumpFailure,
    required this.systemOffline,
  });

  factory NotificationSettings.fromJson(Map<String, dynamic> json) {
    return NotificationSettings(
      lowWater: json['low_water'],
      pumpFailure: json['pump_failure'],
      systemOffline: json['system_offline'],
    );
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}