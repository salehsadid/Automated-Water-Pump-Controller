# Bill of Materials (BOM)

## Automated Water Pump Controller

**Project Version**: v1.0  
**Date**: November 2025  
**Currency**: USD  

---

## Main Components

| Ref | Qty | Part Number | Description | Manufacturer | Supplier | Unit Price | Total Price | Notes |
|-----|-----|-------------|-------------|--------------|----------|------------|-------------|-------|
| U1 | 1 | ESP32-WROOM-32 | WiFi + Bluetooth MCU | Espressif | Digikey | $4.50 | $4.50 | Main controller |
| U2 | 1 | AMS1117-3V3 | 3.3V Linear Regulator | AMS | Digikey | $0.30 | $0.30 | Power regulation |
| U3 | 1 | HC-SR04 | Ultrasonic Distance Sensor | Generic | Amazon | $2.00 | $2.00 | Water level sensing |
| K1 | 1 | SRD-05VDC-SL-C | 5V Relay Module | Songle | Amazon | $1.50 | $1.50 | Pump control |

## Passive Components

| Ref | Qty | Value | Package | Description | Supplier | Unit Price | Total Price |
|-----|-----|-------|---------|-------------|----------|------------|-------------|
| R1,R2 | 2 | 10kΩ | 0805 | Pull-up resistors | Digikey | $0.01 | $0.02 |
| R3 | 1 | 330Ω | 0805 | LED current limiting | Digikey | $0.01 | $0.01 |
| R4 | 1 | 1kΩ | 0805 | General purpose | Digikey | $0.01 | $0.01 |
| C1,C2 | 2 | 100nF | 0805 | Decoupling capacitors | Digikey | $0.02 | $0.04 |
| C3 | 1 | 1000µF | Through-hole | Power supply filtering | Digikey | $0.50 | $0.50 |
| C4 | 1 | 22µF | 0805 | Voltage regulator | Digikey | $0.10 | $0.10 |

## Connectors & Mechanical

| Ref | Qty | Part Number | Description | Supplier | Unit Price | Total Price |
|-----|-----|-------------|-------------|----------|------------|-------------|
| J1 | 1 | DC-005-2.0 | 2.1mm DC Power Jack | Amazon | $0.50 | $0.50 |
| J2 | 1 | PH254-4P | 4-pin Terminal Block | Amazon | $0.30 | $0.30 |
| J3 | 1 | PH254-2P | 2-pin Terminal Block | Amazon | $0.20 | $0.20 |
| SW1 | 1 | B3F-1000 | Tactile Push Button | Omron | Digikey | $0.25 | $0.25 |
| LED1 | 1 | - | 3mm Green LED | Generic | Amazon | $0.05 | $0.05 |
| LED2 | 1 | - | 3mm Red LED | Generic | Amazon | $0.05 | $0.05 |

## Protection & Safety

| Ref | Qty | Part Number | Description | Supplier | Unit Price | Total Price |
|-----|-----|-------------|-------------|----------|------------|-------------|
| F1 | 1 | 1206L050YR | 0.5A PTC Fuse | Littelfuse | Digikey | $0.20 | $0.20 |
| D1 | 1 | 1N4007 | Flyback Diode | Generic | Digikey | $0.05 | $0.05 |
| D2 | 1 | 1N5819 | Schottky Diode | Generic | Digikey | $0.10 | $0.10 |

## Additional Hardware

| Item | Qty | Description | Supplier | Unit Price | Total Price |
|------|-----|-------------|----------|------------|-------------|
| PCB | 1 | Custom PCB (2-layer) | JLCPCB | $2.00 | $2.00 |
| Enclosure | 1 | IP65 Plastic Box | Amazon | $8.00 | $8.00 |
| Standoffs | 4 | M3x10mm Nylon | Amazon | $0.10 | $0.40 |
| Screws | 4 | M3x6mm | Amazon | $0.05 | $0.20 |
| Wire | 1m | 22AWG Stranded | Amazon | $0.50 | $0.50 |

---

## Cost Summary

| Category | Subtotal |
|----------|----------|
| Main Components | $8.30 |
| Passive Components | $0.68 |
| Connectors & Mechanical | $1.35 |
| Protection & Safety | $0.35 |
| Additional Hardware | $11.10 |
| **Total** | **$21.78** |

## Procurement Notes

### Preferred Suppliers
1. **Digikey** - Electronic components, fast shipping
2. **Amazon** - Mechanical parts, modules
3. **JLCPCB** - PCB fabrication
4. **AliExpress** - Alternative for generic components (longer shipping)

### Minimum Order Quantities
- Most electronic components: No minimum
- PCB: 5 pieces minimum at JLCPCB
- Some connectors may have 10-piece minimums

### Lead Times
- Digikey: 1-3 days
- Amazon: 1-2 days  
- JLCPCB: 7-10 days
- AliExpress: 2-4 weeks

### Alternative Parts
- ESP32: Can substitute with ESP32-DevKit or Arduino Nano 33 IoT
- Ultrasonic sensor: Can use JSN-SR04T for waterproof version
- Relay: Any 5V relay with appropriate current rating

### Design Considerations
- All components rated for at least 5V operation
- Temperature range: -10°C to +60°C
- IP65 rating for outdoor installation
- Surge protection included

---

**Last Updated**: November 2025  
**Prepared By**: Hardware Team  
**Approved By**: Project Lead