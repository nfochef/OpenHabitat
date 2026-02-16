# OpenHabitat
OpenHabitat
Open-source IoT system for water quality monitoring in pond ecosystems.
OpenHabitat is a three-tier IoT platform that collects real-time water quality data from pond environments using low-power field devices, long-range wireless communication, and a self-hosted cloud for storage and visualization.
The project targets amphibian habitat monitoring in collaboration with SLU Artdatabanken.


#### The system consists of three layers:

**Field Device** - Arduino Nano 33 BLE with water quality sensors, 16-bit ADC, EEPROM buffering, and LiPo battery. Transmits JSON payloads every ~30 minutes via LoRa.

**Gateway** - Raspberry Pi Zero 2W receives LoRa data, validates and processes measurements, stores locally in InfluxDB (90 days retention), and forwards to cloud via MQTT.

**Self-hosted Cloud** - Mosquitto MQTT broker (TLS on port 8883), Python data store service, TimescaleDB for permanent storage and Grafana for dashboards and alerts.

### C4 Diagrams
<img width="1271" height="2290" alt="C4 Level 1 -3" src="https://github.com/user-attachments/assets/b2b59ba0-27ff-4f3f-a122-c720bb0d8406" />

### Wiring Schematic
<img width="1069" height="553" alt="kopplingsschema" src="https://github.com/user-attachments/assets/c6841524-6b3b-41e9-b03b-1080787a6598" />


