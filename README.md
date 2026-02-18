# OpenHabitat
OpenHabitat
Open-source IoT system for water quality monitoring in pond ecosystems.
OpenHabitat is a three-tier IoT platform that collects real-time water quality data from pond environments using low-power field devices, long-range wireless communication, and a self-hosted cloud for storage and visualization.
The project targets amphibian habitat monitoring in collaboration with SLU Artdatabanken.


#### The system consists of three layers:

**Field Device** - Arduino Nano 33 BLE with water quality sensors, 16-bit ADC, EEPROM buffering, and LiPo battery. Transmits JSON payloads every ~30 minutes via LoRa.

**Gateway** - Raspberry Pi Zero 2W receives LoRa data, validates and processes measurements, stores locally in InfluxDB (90 days retention), and forwards to cloud via MQTT.

**Self-hosted Cloud** - Mosquitto MQTT broker (TLS on port 8883), Python data store service, TimescaleDB for permanent storage and Grafana for dashboards and alerts.

### **System Architecture**
<img width="690" height="1005" alt="Openhabitat" src="https://github.com/user-attachments/assets/70db3c27-c870-4e20-b921-3b9cdccaff06" />

### **C4 Diagrams**
<img width="1388" height="3096" alt="Group 47" src="https://github.com/user-attachments/assets/89d93769-d7a9-451a-8697-b9485d6c8fd6" />

### **Wiring Schematic**
<img width="999" height="535" alt="kopplingsschema" src="https://github.com/user-attachments/assets/1559f3ec-dded-4ad1-b25b-caa93a9fe0c4" />



### Monitored Parameters
The system measures four water quality indicators: pH and dissolved oxygen (DO) via analog probes on the ADS1115 16-bit ADC and turbidity also through the ADS1115, 
temperature using a DS18B20 sensor over OneWire, and light level via an analog/I2C light sensor.



### Communication
Field devices transmit JSON payloads to the gateway over LoRa at 868 MHz via STHLM-MESH, with a range of 1–3 km, 125 kHz bandwidth, and ACK confirmation. 
The gateway forwards validated data to the cloud using MQTT with QoS 1 through a Mosquitto broker secured with TLS on port 8883.
Grafana queries the cloud database over PostgreSQL, connecting directly to TimescaleDB for time-series visualization.

### Tech Stack
The field device runs C++ on an Arduino Nano 33 BLE with an ADS1115 ADC, EEPROM for buffering, and a LoRa radio, powered by a 2000 mAh LiPo battery. 
The gateway is a Raspberry Pi Zero 2W running Python, with InfluxDB for local storage and a LoRa receiver. 
The cloud is self-hosted using Docker with Mosquitto as MQTT broker, TimescaleDB for permanent time-series storage, Grafana for dashboards, and a Python data store service.
