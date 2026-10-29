# esphome-devices

[ESPHome](docs/getting-started.md#esphome) configurations and a KiCad board
for devices that report to
[Home Assistant](docs/getting-started.md#home-assistant). Everything needed to
connect a Mitsubishi heat pump, or to run an AcuRite 433 MHz sensor bridge, is
in this repository or linked from it.

<img src="docs/images/heatpump-system.svg" alt="Block diagram: a heat pump CN105 port connects through a cable and a carrier board to an ESP32, which reaches Home Assistant over Wi-Fi" width="420">

The heat pump bridge: the unit's [CN105](docs/getting-started.md#cn105) port,
a carrier board, an ESP32 and Wi-Fi to Home Assistant.

## Devices

| Device | Status | Guide |
| --- | --- | --- |
| Mitsubishi heat pump bridge | Assembled, bench test pending | [Heat pump bridge](docs/heat-pump.md) |
| AcuRite 433 MHz sensor bridge | In daily use; this repository's config not yet flashed to the live unit | [AcuRite bridge](docs/acurite.md) |

## Quick start

1. Read [Getting started](docs/getting-started.md): install the tools, then
   create your `secrets.yaml`.
2. Open the guide for your device: [heat pump](docs/heat-pump.md) or
   [AcuRite](docs/acurite.md). Build the hardware and check it before power.
3. Flash the board and add it to Home Assistant, as the guide describes.

## Repository map

| Path | Contents |
| --- | --- |
| `heatpump-*.yaml` | One ESPHome file per heat pump (living room, kid's room, master bedroom) |
| `packages/heatpump.yaml` | Settings shared by every heat pump file |
| `acurite-bridge.yaml` | The AcuRite bridge |
| `secrets.example.yaml` | Template for the git-ignored `secrets.yaml` |
| `docs/` | The guides and their images |
| `hardware/heatpump-bridge/` | KiCad project, [board README](hardware/heatpump-bridge/README.md) and fabrication zip |
| `Makefile` | `make images`, `make fab`, `make check` for the generated files |
| `requirements.txt` | Pins the ESPHome version |

## Credits

These are external projects; this repository configures and wires them.

- Heat pump firmware: [echavet/MitsubishiCN105ESPHome](https://github.com/echavet/MitsubishiCN105ESPHome)
  (BSD 2-Clause).
- AcuRite decoder: [swoboda1337/acurite-esphome](https://github.com/swoboda1337/acurite-esphome)
  (no license file, so its terms are unstated).
- Heat pump ESP32 board: [Espressif ESP32-C3-DevKitM-1](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32c3/esp32-c3-devkitm-1/user_guide.html),
  sold by [SparkFun](https://www.sparkfun.com/products/18036) as WRL-18036. SparkFun also makes the
  [BOB-12009 level converter](https://www.sparkfun.com/products/12009).
- AcuRite board: [LILYGO](https://github.com/Xinyuan-LilyGO/LilyGo-LoRa-Series) T3 V1.6.1.

## License

MIT. See [LICENSE](LICENSE). The licenses of the external projects above
apply to them, not to this repository.
