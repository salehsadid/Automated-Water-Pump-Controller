import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/water_level_indicator.dart';
import '../widgets/pump_control_widget.dart';
import '../providers/water_pump_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Start refreshing data when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WaterPumpProvider>().refreshData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Pump Controller'),
        actions: [
          Consumer<WaterPumpProvider>(
            builder: (context, provider, child) {
              return IconButton(
                icon: FaIcon(
                  provider.isConnected
                      ? FontAwesomeIcons.wifi
                      : FontAwesomeIcons.wifiSlash,
                  color: provider.isConnected ? Colors.white : Colors.red,
                ),
                onPressed: () => provider.retryConnection(),
                tooltip: provider.isConnected ? 'Connected' : 'Disconnected - Tap to retry',
              );
            },
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.arrowsRotate),
            onPressed: () => context.read<WaterPumpProvider>().refreshData(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Consumer<WaterPumpProvider>(
        builder: (context, provider, child) {
          return RefreshIndicator(
            onRefresh: () => provider.refreshData(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Connection status banner
                  if (!provider.isConnected || provider.error != null)
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange),
                      ),
                      child: Row(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.exclamationTriangle,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              provider.error ?? 'Disconnected - Using mock data',
                              style: const TextStyle(color: Colors.orange),
                            ),
                          ),
                          if (provider.error != null)
                            TextButton(
                              onPressed: provider.clearError,
                              child: const Text('Dismiss'),
                            ),
                        ],
                      ),
                    ),

                  // Water Level Indicator
                  WaterLevelIndicator(
                    waterLevel: provider.waterLevel,
                    maxLevel: 100.0,
                    isAnimated: true,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Pump Control Widget
                  PumpControlWidget(
                    pumpStatus: provider.pumpStatus,
                    onPumpToggle: (shouldStart) => provider.controlPump(shouldStart),
                    isLoading: provider.isLoading,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // System Info Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'System Information',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                            'Device Status',
                            provider.deviceStatus?.status.toUpperCase() ?? 'UNKNOWN',
                            provider.isConnected ? Colors.green : Colors.red,
                          ),
                          _buildInfoRow(
                            'Last Updated',
                            provider.deviceStatus?.timestamp != null
                                ? _formatDateTime(provider.deviceStatus!.timestamp)
                                : 'Never',
                            Colors.grey,
                          ),
                          _buildInfoRow(
                            'Runtime Today',
                            provider.pumpRuntimeToday,
                            Colors.blue,
                          ),
                          _buildInfoRow(
                            'Last Started',
                            provider.lastStartedTime,
                            Colors.purple,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Quick Actions
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quick Actions',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () => provider.simulateWaterLevelChange(),
                                  icon: const FaIcon(FontAwesomeIcons.flask),
                                  label: const Text('Simulate\nLevel Change'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(16),
                                    backgroundColor: Colors.purple,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () => provider.refreshData(),
                                  icon: provider.isLoading
                                      ? const SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const FaIcon(FontAwesomeIcons.arrowsRotate),
                                  label: const Text('Refresh\nData'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(16),
                                    backgroundColor: Colors.indigo,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<WaterPumpProvider>().refreshData(),
        tooltip: 'Refresh Data',
        child: const FaIcon(FontAwesomeIcons.arrowsRotate),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${dateTime.day}/${dateTime.month} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
}