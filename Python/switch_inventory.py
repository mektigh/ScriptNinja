import csv
from netmiko import ConnectHandler

# Define switch details
switches = [
    {"name": "Ruckus1", "ip": "192.168.1.1", "username": "admin", "password": "password", "device_type": "ruckus_fastiron"},
    {"name": "Ruckus2", "ip": "192.168.1.2", "username": "admin", "password": "password", "device_type": "ruckus_fastiron"},
    {"name": "HP1", "ip": "192.168.1.3", "username": "admin", "password": "password", "device_type": "hp_procurve"},
    {"name": "HP2", "ip": "192.168.1.4", "username": "admin", "password": "password", "device_type": "hp_procurve"},
    {"name": "Aruba1", "ip": "192.168.1.5", "username": "admin", "password": "password", "device_type": "aruba_os"}
]

# Commands for each switch type
commands = {
    "ruckus_fastiron": ["show vlan brief", "show running-config interface", "show interface status"],
    "hp_procurve": ["show vlan", "show run", "show interfaces status"],
    "aruba_os": ["show vlan", "show configuration", "show interface status"]
}

# Parse function for each switch type
def parse_output(device_type, outputs):
    parsed_data = []
    if device_type == "ruckus_fastiron":
        # Parse Ruckus-specific output
        for line in outputs[0].splitlines()[3:]:
            if line.strip():
                columns = line.split()
                vlan_id = columns[0]
                vlan_name = columns[1]
                ports = columns[2:]
                for port in ports:
                    parsed_data.append({
                        "Switch Name": "",
                        "Port Name": port,
                        "VLAN ID": vlan_id,
                        "VLAN Name": vlan_name,
                        "Mode": "Access/Trunk",  # Requires additional parsing
                        "Tagged/Untagged": "Tagged/Untagged",  # Requires additional parsing
                        "Description": "N/A",  # Requires additional parsing
                        "Status": "Up/Down"  # Requires parsing 'show interface status'
                    })
    elif device_type == "hp_procurve":
        # Parse HP-specific output (example for brevity)
        for line in outputs[0].splitlines()[3:]:
            # Implement parsing logic for HP
            pass
    elif device_type == "aruba_os":
        # Parse Aruba-specific output (example for brevity)
        for line in outputs[0].splitlines()[3:]:
            # Implement parsing logic for Aruba
            pass
    return parsed_data

# Collect data from all switches
all_data = []
for switch in switches:
    connection = ConnectHandler(
        ip=switch["ip"],
        username=switch["username"],
        password=switch["password"],
        device_type=switch["device_type"]
    )
    outputs = [connection.send_command(cmd) for cmd in commands[switch["device_type"]]]
    connection.disconnect()

    # Parse the output
    parsed_data = parse_output(switch["device_type"], outputs)
    for entry in parsed_data:
        entry["Switch Name"] = switch["name"]  # Add switch name to each entry
    all_data.extend(parsed_data)

# Save data to CSV
with open("switch_ports_inventory.csv", "w", newline="") as csvfile:
    fieldnames = ["Switch Name", "Port Name", "VLAN ID", "VLAN Name", "Mode", "Tagged/Untagged", "Description", "Status"]
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(all_data)

print("Port and VLAN information saved to 'switch_ports_inventory.csv'")
