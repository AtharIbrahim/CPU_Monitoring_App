import json

import psutil
def get_device_memory():
    device_memory = {}
    # Get RAM information
    ram_info = psutil.virtual_memory()
    device_memory['total_memory'] = ram_info.total
    device_memory['available_memory'] = ram_info.available
    device_memory['used_memory'] = ram_info.used
 # Convert dictionary to JSON
    return json.dumps(device_memory, indent=4)
if __name__ == "__main__":
    # Print the JSON result to stdout
    print(get_device_memory())
