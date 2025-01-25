import platform
import json
def get_device_name():
    device_name = {}
      # Get system platform (e.g., Windows, Linux, Darwin for Mac)
    device_name['platform'] = platform.system()

    # Get device name based on the platform
    device_name['device_name'] = platform.node()  # Returns the machine name for all platforms
 # Convert dictionary to JSON
    return json.dumps(device_name, indent=4)
if __name__ == "__main__":
    # Print the JSON result to stdout
    print(get_device_name())
