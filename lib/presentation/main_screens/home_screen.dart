import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:monitoring_app/presentation/main_screens/blocks/battery_block.dart';
import 'package:monitoring_app/presentation/main_screens/blocks/memory_block.dart';
import 'package:monitoring_app/presentation/main_screens/blocks/storage_block.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variables
  Timer? _timer;
  String? _deviceName;
  String? _totalMemory;
  String? _avaliableMemory;
  String? _batteryHealth;
  String? _batteryCapacity;
  String? _batteryPercentage;
  String? _batteryStatus;
  String? _batteryTemperature;

  // Initial
  @override
  void initState() {
    super.initState();
    fetchEveryBlock();
    // Set up a timer to fetch device info every 1 seconds
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      fetchEveryBlock();
    });
  }

  // Dispose
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Fetch Every Block Data
  Future<void> fetchEveryBlock() async {
    // fetch Device Name
    fetchPythonData('./assets/python/device_name.py').then((result) {
      setState(() {
        _deviceName = result['device_name'] ?? 'Unknown';
      });
    });
    // fetch Ram / Memory
    fetchPythonData('./assets/python/memory_info.py').then((result) {
      setState(() {
        _totalMemory = result['total_memory'] != null
            ? ((result['total_memory'] / (1024 * 1024)).toStringAsFixed(4))
                    .substring(0, 4) +
                " MB"
            : 'Unknown';
        _avaliableMemory = result['available_memory'] != null
            ? ((result['available_memory'] / (1024 * 1024)).toStringAsFixed(4))
                    .substring(0, 4) +
                " MB"
            : 'Unknown';
      });
    });
    // fetch Battery Details
    fetchPythonData('./assets/python/battery_details.py').then((result) {
      setState(() {
        _batteryPercentage =
            result['percentage']?.toString() ?? 'Unknown'; // Ensure String type
        _batteryHealth = result['health'] ?? 'Good';
        _batteryCapacity = result['capacity'] ?? 'Unknown';
        _batteryTemperature = result['temperature'] ?? 'Unknown';
        _batteryStatus = result['plugged'] ? 'Charging' : 'UnPlugged';
      });
    });
  }

  // Main Function for fetch
  Future<Map<String, dynamic>> fetchPythonData(String scriptPath) async {
    try {
      // Run the Python script
      final process = await Process.start('python', [scriptPath]);

      // Capture the standard output
      final output = await process.stdout.transform(utf8.decoder).join();

      // Capture the standard error
      final errors = await process.stderr.transform(utf8.decoder).join();

      // Check for errors
      if (errors.isNotEmpty) {
        print('Python Error: $errors');
        return {};
      }

      // Decode the output as a JSON-like map and return
      return json.decode(output) as Map<String, dynamic>;
    } catch (e) {
      print('Error running Python script: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Device Info Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: const AssetImage('assets/images/bg.jpeg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.1),
                      BlendMode.lighten,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Device Name
                    Text(
                      _deviceName ?? 'Samsung Galaxy S9+',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              // All CPU Blocks
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Column 1
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Memory Block
                        MemoryBlock(
                          avaliable: _avaliableMemory ?? '6,123 MB',
                          total: _totalMemory ?? '8,102 MB',
                        ),
                        // Storage Block
                        // StorageBlock(
                        //   total: '256GB',
                        //   used: '123GB',
                        // ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16),
                  // Column 2
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Battery Block
                        BatteryBlock(
                          ampere: _batteryCapacity ?? 'unknown',
                          health: _batteryHealth ?? 'Good',
                          percentage: '${_batteryPercentage ?? '68'}%',
                          pluged: _batteryStatus ?? 'none',
                          temperature: _batteryTemperature ?? '1oC',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
