# esphome-devices
ESPHome device configurations and KiCad boards for Home Assistant.

## Setup
Requires Python 3.12 to 3.14 (ESPHome 2026.10 does not support 3.15).

```sh
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt
cp secrets.example.yaml secrets.yaml
```

Validate, compile, upload and watch a device:

```sh
.venv/bin/esphome config heatpump-livingroom.yaml
.venv/bin/esphome compile heatpump-livingroom.yaml
.venv/bin/esphome upload heatpump-livingroom.yaml
.venv/bin/esphome logs heatpump-livingroom.yaml
```

## Secrets
`secrets.yaml` is git-ignored. Fill each value in `secrets.yaml`:

| Key | Generate with |
| --- | --- |
| `wifi_ssid`, `wifi_password` | Your network |
| `heatpump_api_encryption_key` | `head -c 32 /dev/urandom \| base64 \| tr '+/' 'ab'` |
| `heatpump_ota_password` | `head /dev/urandom \| tr -dc A-Za-z0-9 \| head -c 20` |
| `heatpump_ap_password` | `head /dev/urandom \| tr -dc A-Za-z0-9 \| head -c 20` |

To rotate a value, regenerate it and re-flash over OTA.

## Devices
| File | Device | Area |
| --- | --- | --- |
| `heatpump-livingroom.yaml` | Mitsubishi heat pump bridge | Living Room |
| `heatpump-kidsroom.yaml` | Mitsubishi heat pump bridge | Kid's Room |
| `heatpump-masterbedroom.yaml` | Mitsubishi heat pump bridge | Master Bedroom |

All three include `packages/heatpump.yaml` and set `name` and `area`. The firmware uses
[echavet/MitsubishiCN105ESPHome](https://github.com/echavet/MitsubishiCN105ESPHome).

## Heat pump bridge
The CN105 port is 5 V serial. A SparkFun BOB-12009 level converter on the carrier board sits
between it and the ESP32-C3 (SparkFun WRL-18036, an ESP32-C3-DevKitM-1 V1).
See the [DevKitM-1 user guide](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32c3/esp32-c3-devkitm-1/user_guide.html).

| CN105 pin | Signal | Wire | Carrier J_CN105_1 | Carrier J_ESP32_1 | ESP32-C3 |
| --- | --- | --- | --- | --- | --- |
| 1 | 12V | | 1 | | |
| 2 | GND | Red | 2 | 2 | GND |
| 3 | 5V | White | 3 | 1 | 5V |
| 4 | TX | Yellow | 4 | 4 (RX) | GPIO4 (RX) |
| 5 | RX | Orange | 5 | 5 (TX) | GPIO5 (TX) |

J_ESP32_1 pin 3 carries 3V3 from the ESP32 to the converter. Pins J_ESP32_1 4 and 5 go through
the converter to J_CN105_1 pins 4 and 5.

GPIO20 and GPIO21 are not used: they are UART0, shared with the USB-UART bridge and the boot log.
Logs over micro-USB use `logger: hardware_uart: UART0`.

### Cables
- CN105 to J_CN105_1: JST PAP-05V-S housing (2.0 mm pitch) to Dupont lead. Pin 1 (12V) goes on the
  square pad marked "1". Check continuity with a meter before the first power-up.
- J_ESP32_1 to the ESP32: female-to-female Dupont jumpers, re-housed.

### Power
The bridge draws power from CN105 through the ESP32 5V pin. Never connect micro-USB while the
bridge is connected to CN105: micro-USB, 5V and 3V3 are mutually exclusive power sources.
Flash over USB with CN105 disconnected, then use OTA.

### Tuning
Set `update_interval` in `packages/heatpump.yaml` from the `Cycle ended in` lines in the logs.

## Hardware
`hardware/heatpump-bridge` holds the KiCad 10.0 project for the carrier board: a SparkFun BOB-12009 level converter and two 1x5 headers. The `BOB-12009` symbol and footprint are project-local. Everything under `hardware/` is MIT licensed.
