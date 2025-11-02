# Wiring Diagrams

This directory contains wiring diagrams and connection schematics for the Automated Water Pump Controller.

## Diagram Types

### System Overview
- Complete system wiring diagram
- Power distribution
- Communication connections
- Safety circuits

### Component Connections
- Microcontroller pinout
- Sensor connections
- Relay wiring
- Power supply connections

### Installation Diagrams
- Field installation guide
- Pump connection diagram
- Sensor placement
- Enclosure mounting

## File Formats

- **PNG/JPG**: For easy viewing and documentation
- **SVG**: For scalable diagrams
- **PDF**: For printing and formal documentation
- **DWG/DXF**: CAD format for technical drawings

## Naming Convention

Use the following naming convention for diagram files:
```
[System]-[Component]-[Version].[extension]

Examples:
- WaterPump-System-Overview-v1.0.png
- ESP32-Pinout-Diagram-v1.0.pdf
- Sensor-Installation-Guide-v1.0.svg
```

## Standard Symbols

Use standard electrical symbols for consistency:
- Resistor: Rectangle with value
- Capacitor: Two parallel lines
- Diode: Triangle with line
- Ground: Standard ground symbol
- Power: VCC/VDD labels
- Connections: Solid dots for connections

## Color Coding

### Wire Colors
- **Red**: +5V, +12V power
- **Black**: Ground (GND)
- **Blue**: Data/Signal lines
- **Green**: Control signals
- **Yellow**: Analog inputs
- **White**: Digital I/O

### Component Colors
- **Red**: Power components
- **Blue**: Digital components
- **Green**: Analog components
- **Orange**: Safety/Protection

## Safety Warnings

Include appropriate safety warnings on diagrams:
- High voltage warnings
- Polarity warnings
- Water/moisture warnings
- ESD precautions

## Diagram Checklist

Before finalizing any wiring diagram:
- [ ] All connections labeled
- [ ] Wire colors specified
- [ ] Pin numbers included
- [ ] Component values shown
- [ ] Safety warnings added
- [ ] Scale and dimensions noted
- [ ] Revision information included

## Tools Used

- **KiCad**: For electrical schematics
- **Fritzing**: For breadboard diagrams
- **Draw.io**: For system diagrams
- **Visio**: For professional diagrams

## Review Process

1. Technical review by hardware team
2. Safety review by project lead
3. Documentation review for clarity
4. Final approval before release

## Version Control

- Use semantic versioning (v1.0, v1.1, etc.)
- Document changes in revision notes
- Keep previous versions for reference
- Update related documentation