import 'package:flutter/material.dart';

class BatteryBlock extends StatelessWidget {
  final String percentage, health, ampere, temperature, pluged;
  BatteryBlock({
    super.key,
    required this.ampere,
    required this.health,
    required this.percentage,
    required this.pluged,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    double batteryPercentage =
        double.tryParse(percentage.replaceAll('%', '')) ?? 0.0;
    // Determine the color based on the battery percentage
    Color batteryColor;
    if (batteryPercentage >= 75) {
      batteryColor = const Color.fromARGB(255, 136, 255, 0);
    } else if (batteryPercentage >= 30) {
      batteryColor = Colors.yellow;
    } else {
      batteryColor = Colors.red;
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.battery_6_bar_outlined,
                    size: 20,
                    color: Color.fromARGB(255, 217, 217, 217),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Battery:',
                    style: TextStyle(
                      color: Color.fromARGB(255, 217, 217, 217),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$percentage',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Loading Bar
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // CircularProgressIndicator with a specific size
                    Container(
                      width: 60,
                      height: 60.0,
                      child: CircularProgressIndicator(
                        value: batteryPercentage / 100,
                        color: batteryColor,
                        backgroundColor: Colors.grey,
                        strokeWidth: 4,
                      ),
                    ),
                    // Text inside the CircularProgressIndicator
                    Text(
                      '$percentage',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Health
                    Row(
                      children: [
                        Icon(
                          Icons.health_and_safety_outlined,
                          size: 14,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '$health',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    // Ampere
                    Row(
                      children: [
                        Icon(
                          Icons.power_settings_new_sharp,
                          size: 14,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '$ampere',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    // Temperature
                    Row(
                      children: [
                        Icon(
                          Icons.light_mode,
                          size: 14,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '$temperature',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    // Pluged
                    Row(
                      children: [
                        Icon(
                          Icons.power,
                          size: 14,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '$pluged',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
