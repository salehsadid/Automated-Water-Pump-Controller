import 'package:flutter/material.dart';

class WaterLevelIndicator extends StatefulWidget {
  final double waterLevel;
  final double maxLevel;
  final bool isAnimated;

  const WaterLevelIndicator({
    super.key,
    required this.waterLevel,
    this.maxLevel = 100.0,
    this.isAnimated = true,
  });

  @override
  State<WaterLevelIndicator> createState() => _WaterLevelIndicatorState();
}

class _WaterLevelIndicatorState extends State<WaterLevelIndicator>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.waterLevel / widget.maxLevel,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.isAnimated) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(WaterLevelIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.waterLevel != widget.waterLevel) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: widget.waterLevel / widget.maxLevel,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getWaterColor(double percentage) {
    if (percentage < 0.2) {
      return Colors.red;
    } else if (percentage < 0.4) {
      return Colors.orange;
    } else if (percentage < 0.7) {
      return Colors.yellow.shade700;
    } else {
      return Colors.green;
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
              'Water Level',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 200,
              height: 200,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final percentage = _animation.value;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background circle
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 4,
                          ),
                        ),
                      ),
                      // Water level circle
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              _getWaterColor(percentage).withOpacity(0.8),
                              _getWaterColor(percentage),
                            ],
                          ),
                        ),
                        child: ClipOval(
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 200 * percentage,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        _getWaterColor(percentage).withOpacity(0.6),
                                        _getWaterColor(percentage),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Percentage text
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${(percentage * 100).toInt()}%',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 3,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${widget.waterLevel.toStringAsFixed(1)} cm',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 3,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Status indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatusIndicator(
                  'Low',
                  widget.waterLevel < 20,
                  Colors.red,
                ),
                _buildStatusIndicator(
                  'Normal',
                  widget.waterLevel >= 20 && widget.waterLevel <= 80,
                  Colors.green,
                ),
                _buildStatusIndicator(
                  'High',
                  widget.waterLevel > 80,
                  Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String label, bool isActive, Color color) {
    return Column(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? color : Colors.grey.shade300,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? color : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}