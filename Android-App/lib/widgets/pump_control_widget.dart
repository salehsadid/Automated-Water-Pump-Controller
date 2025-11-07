import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum PumpStatus { running, stopped, error, connecting }

class PumpControlWidget extends StatefulWidget {
  final PumpStatus pumpStatus;
  final Function(bool) onPumpToggle;
  final bool isLoading;

  const PumpControlWidget({
    super.key,
    required this.pumpStatus,
    required this.onPumpToggle,
    this.isLoading = false,
  });

  @override
  State<PumpControlWidget> createState() => _PumpControlWidgetState();
}

class _PumpControlWidgetState extends State<PumpControlWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    if (widget.pumpStatus == PumpStatus.running) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(PumpControlWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pumpStatus == PumpStatus.running) {
      _pulseController.repeat(reverse: true);
    } else {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Color _getStatusColor() {
    switch (widget.pumpStatus) {
      case PumpStatus.running:
        return Colors.green;
      case PumpStatus.stopped:
        return Colors.grey;
      case PumpStatus.error:
        return Colors.red;
      case PumpStatus.connecting:
        return Colors.orange;
    }
  }

  IconData _getStatusIcon() {
    switch (widget.pumpStatus) {
      case PumpStatus.running:
        return FontAwesomeIcons.play;
      case PumpStatus.stopped:
        return FontAwesomeIcons.stop;
      case PumpStatus.error:
        return FontAwesomeIcons.exclamationTriangle;
      case PumpStatus.connecting:
        return FontAwesomeIcons.spinner;
    }
  }

  String _getStatusText() {
    switch (widget.pumpStatus) {
      case PumpStatus.running:
        return 'RUNNING';
      case PumpStatus.stopped:
        return 'STOPPED';
      case PumpStatus.error:
        return 'ERROR';
      case PumpStatus.connecting:
        return 'CONNECTING';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Pump Control',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            // Status indicator
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: widget.pumpStatus == PumpStatus.running
                      ? _pulseAnimation.value
                      : 1.0,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _getStatusColor().withOpacity(0.2),
                      border: Border.all(
                        color: _getStatusColor(),
                        width: 4,
                      ),
                    ),
                    child: Center(
                      child: widget.pumpStatus == PumpStatus.connecting
                          ? const CircularProgressIndicator()
                          : FaIcon(
                              _getStatusIcon(),
                              size: 48,
                              color: _getStatusColor(),
                            ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              _getStatusText(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _getStatusColor(),
              ),
            ),
            const SizedBox(height: 32),
            // Control buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Start button
                ElevatedButton.icon(
                  onPressed: widget.isLoading ||
                          widget.pumpStatus == PumpStatus.connecting
                      ? null
                      : () => widget.onPumpToggle(true),
                  icon: widget.isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const FaIcon(FontAwesomeIcons.play, size: 16),
                  label: const Text('START'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(100, 48),
                  ),
                ),
                // Stop button
                ElevatedButton.icon(
                  onPressed: widget.isLoading ||
                          widget.pumpStatus == PumpStatus.connecting
                      ? null
                      : () => widget.onPumpToggle(false),
                  icon: widget.isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const FaIcon(FontAwesomeIcons.stop, size: 16),
                  label: const Text('STOP'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(100, 48),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Additional info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Runtime Today:'),
                      Text(
                        '2h 30m', // This would come from the provider
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Last Started:'),
                      Text(
                        '10:30 AM', // This would come from the provider
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}