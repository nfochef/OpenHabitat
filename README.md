## **Purpose:**
Develop and evaluate a complete, open IoT system for monitoring stormwater pond quality.
The system continuously measures pH, dissolved oxygen, turbidity, and temperature,
and transmits the data wirelessly to a self-hosted backend for storage and visualization.
The system is designed to operate fully offline in remote locations without internet access.
All infrastructure runs locally on self-hosted hardware, with no dependency on external cloud services or internet connectivity.

## **Scope:**
The project covers the entire IoT chain, from the field sensor node to data visualization:
- Field node with LoRaWAN communication (868 MHz)
- Self-hosted LoRaWAN network server and MQTT message queue
- Data processing, time-series database, and Grafana dashboard

The system is limited to a single field node located approximately 1-3 Km from
the gateway. A mobile app, cloud hosting, and commercial calibration services are
not included. Data loss during connectivity outages is accepted by design.

## **Deliverables:**
- Functional field unit (sensing + LoRaWAN transmission)
- Self-hosted backend using Docker Compose
- Grafana dashboard for data visualization
- Technical documentation
- Structured GitHub repository containing firmware, configuration, and infrastructure code

## **Design Principles**

**Fully self-hosted** - No external services or cloud dependencies. The entire
pipeline from LoRaWAN network server to dashboard runs on local hardware,
making the system operational in remote locations without internet access.

**Accepted data loss** - The system does not implement offline buffering at the
gateway level. If connectivity between the field device and gateway is lost,
those measurements are discarded. This simplifies the architecture significantly.

**Open-source throughout** - Every component in the stack (ChirpStack, Mosquitto,
TimescaleDB, Grafana) is open-source, ensuring long-term maintainability and
avoiding vendor lock-in.

---
### **System Architecture**
<img width="1332" height="396" alt="GH" src="https://github.com/user-attachments/assets/ffb4e4ed-ba9b-41c1-8b00-7757b2f8a579" />

---
### **C4 Diagrams**
<img width="761" height="912" alt="C4 lvl 1-3" src="https://github.com/user-attachments/assets/a286a569-5aaa-473f-ae53-86a183f4f818" />
---
### **Wiring Schematic**
<img width="999" height="535" alt="kopplingsschema" src="https://github.com/user-attachments/assets/1559f3ec-dded-4ad1-b25b-caa93a9fe0c4" />


---
## **The system consists of three layers:**

**Field Device** - Arduino Nano 33 BLE Rev2 paired with an RFM95W 868 MHz LoRa radio module.
Sensors are read through an ADS1115 16-bit ADC for high-precision analog measurements.
Calibration offsets are stored persistently on an Adafruit I2C EEPROM. Sensor data is
encoded using Cayenne LPP and transmitted via LoRaWAN with OTAA authentication and
AES-128 encryption approximately every 30 minutes from a LiPo battery.

**Gateway** - Raspberry Pi Zero 2W equipped with a Waveshare SX1302 868M HAT,
running as a LoRaWAN UDP packet forwarder. Received packets are forwarded to the
self-hosted ChirpStack LoRaWAN network server over the local network.

**Self-hosted Backend** - All services run on Docker Compose:
- **ChirpStack** - LoRaWAN network server handling device management, OTAA join,
  and downlink/uplink routing
- **Eclipse Mosquitto** - MQTT broker receiving decoded uplinks from ChirpStack
- **Python parser** - Decodes Cayenne LPP payloads and writes structured data
  to the database
- **TimescaleDB** - PostgreSQL-based time-series database for permanent sensor storage
- **Grafana** - Dashboard and alerting for real-time and historical visualization
