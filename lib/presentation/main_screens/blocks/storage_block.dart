import 'package:flutter/material.dart';

class StorageBlock extends StatelessWidget {
  final String total;
  final String used;
  const StorageBlock({
    super.key,
    required this.total,
    required this.used,
  });

  @override
  Widget build(BuildContext context) {
    // Convert storage values from GB to double for calculation
    double totalStorage = double.parse(total.replaceAll(' GB', '')) *
        1024 *
        1024 *
        1024; // Convert GB to bytes
    double usedStorage = double.parse(used.replaceAll(' GB', '')) *
        1024 *
        1024 *
        1024; // Convert GB to bytes

    // Calculate storage percentage
    double storagePercentage = (usedStorage / totalStorage) * 100;
    int storagePercentageInt = storagePercentage.toInt();

    Color storageColor;
    if (storagePercentageInt >= 75) {
      storageColor =
          const Color.fromARGB(255, 136, 255, 0); // High battery (Green)
    } else if (storagePercentageInt >= 30) {
      storageColor = Colors.yellow; // Medium battery (Yellow)
    } else {
      storageColor = Colors.red; // Low battery (Red)
    }
    return Container(
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
                  Icons.storage,
                  size: 20,
                  color: Color.fromARGB(255, 217, 217, 217),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Storage:',
                  style: TextStyle(
                    color: Color.fromARGB(255, 217, 217, 217),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '$total',
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
          // Loading Bar
          Stack(
            alignment: Alignment.center,
            children: [
              // CircularProgressIndicator with a specific size
              Container(
                width: 60,
                height: 60.0,
                child: CircularProgressIndicator(
                  value: storagePercentageInt / 100,
                  color: storageColor,
                  backgroundColor: Colors.grey,
                  strokeWidth: 3,
                ),
              ),
              // Text inside the CircularProgressIndicator
              Text(
                '${storagePercentageInt ?? '68'}%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Storage',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            "$used / $total",
            style: const TextStyle(color: Colors.grey, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
