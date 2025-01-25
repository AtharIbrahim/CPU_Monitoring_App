import json
import psutil

def get_battery_details():
    battery_details = {}
    # Get battery status
    battery = psutil.sensors_battery()

    if battery is not None:
        battery_details['percentage'] = battery.percent
        battery_details['plugged'] = battery.power_plugged
        battery_details['capacity'] = "N/A"
        battery_details['health'] = "Good"  # psutil does not provide health information directly
        battery_details['temperature'] = "N/A"  # psutil does not provide temperature information directly
    else:
        battery_details['error'] = "Battery information not available."
    
    # Convert dictionary to JSON and ensure the percentage is returned as a string
    return json.dumps(battery_details, indent=4)

if __name__ == "__main__":
    # Print the JSON result to stdout
    print(get_battery_details())
