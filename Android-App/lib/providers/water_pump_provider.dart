import 'dart:async';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/pump_control_widget.dart';

class WaterPumpProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  // State variables
  DeviceStatus? _deviceStatus;
  bool _isLoading = false;
  bool _isConnected = false;
  String? _error;
  Timer? _refreshTimer;

  // Getters
  DeviceStatus? get deviceStatus => _deviceStatus;
  bool get isLoading => _isLoading;
  bool get isConnected => _isConnected;
  String? get error => _error;
  
  // Water level getters
  double get waterLevel => _deviceStatus?.waterLevel.current ?? 0.0;
  double get waterLevelPercentage => _deviceStatus?.waterLevel.percentage ?? 0.0;
  
  // Pump status getters
  PumpStatus get pumpStatus {
    if (_deviceStatus == null) return PumpStatus.connecting;
    
    switch (_deviceStatus!.pump.status) {
      case 'running':
        return PumpStatus.running;
      case 'stopped':
        return PumpStatus.stopped;
      case 'error':
        return PumpStatus.error;
      default:
        return PumpStatus.connecting;
    }
  }

  String get pumpRuntimeToday {
    if (_deviceStatus?.pump.runtimeToday == null) return '0h 0m';
    
    final seconds = _deviceStatus!.pump.runtimeToday;
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    
    return '${hours}h ${minutes}m';
  }

  String get lastStartedTime {
    if (_deviceStatus?.pump.lastStarted == null) return 'Never';
    
    final now = DateTime.now();
    final lastStarted = _deviceStatus!.pump.lastStarted!;
    final difference = now.difference(lastStarted);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  WaterPumpProvider() {
    _initializeProvider();
  }

  void _initializeProvider() {
    // Start with mock data for development
    _deviceStatus = DeviceStatus.mock();
    _isConnected = true;
    notifyListeners();
    
    // Start periodic refresh
    startPeriodicRefresh();
    
    // Try to connect to real device
    refreshData();
  }

  // Start periodic data refresh
  void startPeriodicRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => refreshData(),
    );
  }

  // Stop periodic refresh
  void stopPeriodicRefresh() {
    _refreshTimer?.cancel();
  }

  // Refresh device status
  Future<void> refreshData() async {
    try {
      _error = null;
      
      // Don't show loading for periodic refreshes
      if (_deviceStatus == null) {
        _isLoading = true;
        notifyListeners();
      }

      final status = await _apiService.getDeviceStatus();
      
      _deviceStatus = status;
      _isConnected = true;
      _isLoading = false;
      
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isConnected = false;
      _isLoading = false;
      
      // Keep using mock data if connection fails
      if (_deviceStatus == null) {
        _deviceStatus = DeviceStatus.mock();
      }
      
      notifyListeners();
      
      // Log error for debugging
      debugPrint('Error refreshing data: $e');
    }
  }

  // Control pump (start/stop)
  Future<void> controlPump(bool shouldStart) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final action = shouldStart ? 'start' : 'stop';
      final response = await _apiService.controlPump(action: action);

      if (response.success) {
        // Update local status immediately for better UX
        if (_deviceStatus != null) {
          final updatedPump = PumpInfo(
            status: response.newStatus,
            lastStarted: shouldStart ? DateTime.now() : _deviceStatus!.pump.lastStarted,
            runtimeToday: _deviceStatus!.pump.runtimeToday,
          );
          
          _deviceStatus = DeviceStatus(
            status: _deviceStatus!.status,
            timestamp: DateTime.now(),
            waterLevel: _deviceStatus!.waterLevel,
            pump: updatedPump,
            system: _deviceStatus!.system,
          );
        }
        
        // Refresh data after a short delay to get updated info
        Future.delayed(const Duration(seconds: 1), () => refreshData());
      } else {
        _error = response.message;
      }
    } catch (e) {
      _error = 'Failed to control pump: $e';
      debugPrint('Error controlling pump: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate water level changes for demo purposes
  void simulateWaterLevelChange() {
    if (_deviceStatus != null) {
      // Generate random water level between 10-90
      final random = (10 + (80 * (DateTime.now().millisecondsSinceEpoch % 1000) / 1000));
      final newLevel = WaterLevel(
        current: random,
        unit: 'cm',
        percentage: (random / 100) * 100,
      );
      
      _deviceStatus = DeviceStatus(
        status: _deviceStatus!.status,
        timestamp: DateTime.now(),
        waterLevel: newLevel,
        pump: _deviceStatus!.pump,
        system: _deviceStatus!.system,
      );
      
      notifyListeners();
    }
  }

  // Clear error message
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Retry connection
  Future<void> retryConnection() async {
    await refreshData();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _apiService.dispose();
    super.dispose();
  }
}