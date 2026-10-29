# Getting started

Set up your computer once, then follow a device guide. This page covers the
tools, the secrets file, flashing a board and adding it to Home Assistant. It
ends with a glossary of the terms the guides use.

Terms marked with a link, such as [ESPHome](#esphome), are defined in the
[glossary](#glossary) below.

## What you need

- A computer (laptop or desktop) with a terminal. Commands on this page are
  for macOS and Linux shells. Windows is untested here.
- Python 3.12, 3.13 or 3.14. ESPHome 2026.10.1, the version this repository
  pins, does not install on Python 3.15 (pip reports "No matching
  distribution"; checked while writing these docs).
- Git, to download this repository.
- A micro-USB data cable (power-only cables do not work) for the first flash
  of each board.
- A [Home Assistant](#home-assistant) installation on the same network as
  your devices. See the
  [Home Assistant installation guide](https://www.home-assistant.io/installation/).
- A 2.4 GHz Wi-Fi network. Both boards in this repository are ESP32 chips,
  and the
  [ESPHome ESP32 page](https://esphome.io/components/esp32/) lists the
  ESP32-C3 Wi-Fi band as 2.4 GHz.

## Set up the project

Run these commands in a laptop terminal.

```sh
git clone https://github.com/kjiwa/esphome-devices.git
cd esphome-devices
python3.14 -m venv .venv
.venv/bin/pip install -r requirements.txt
cp secrets.example.yaml secrets.yaml
```

- `python3.14` creates a private Python environment in `.venv`. Use
  `python3.12` or `python3.13` if that is what you have installed. Plain
  `python3` works if `python3 --version` prints 3.12, 3.13 or 3.14.
- `requirements.txt` installs ESPHome 2026.10.1: the version this repository
  was checked against.
- `secrets.yaml` is ignored by git. It holds your passwords and keys.

## Fill in the secrets

Open `secrets.yaml` in a text editor and replace every value. Each device
config reads its passwords and keys from this file through `!secret`.

- `wifi_ssid`, `wifi_password`: used by all devices. Your Wi-Fi name and password.
- `heatpump_api_encryption_key`: used by heat pump bridges. Generated, see below.
- `heatpump_ota_password`, `heatpump_ap_password`: used by heat pump bridges. Generated, see below.
- `acurite_api_encryption_key`: used by AcuRite bridge. Generated, see below.
- `acurite_ota_password`, `acurite_ap_password`: used by AcuRite bridge. Generated, see below.

An [API encryption key](#api-encryption-key) is 32 random bytes in base64.
Generate one in a laptop terminal:

```sh
head -c 32 /dev/urandom | base64 | tr '+/' 'ab'
```

An OTA password and a fallback access point password are 20 random letters
and digits. Generate one in a laptop terminal:

```sh
LC_ALL=C tr -dc A-Za-z0-9 < /dev/urandom | head -c 20; echo
```

Paste each output into `secrets.yaml`, one value per key. All heat pump
bridges share one set of three keys. To rotate a value, generate a new one
and flash the device again. A changed OTA password may need a USB flash
first (unverified). A changed API encryption key must also be entered again
in Home Assistant.

## Check a device file

Validate a config without a board attached. Run this in a laptop terminal,
from the repository root:

```sh
.venv/bin/esphome config heatpump-livingroom.yaml
```

It prints the merged configuration and ends without an error when the file
and `secrets.yaml` are valid. The first run downloads the external component
the file names, so it needs internet access.

Validate every device file:

```sh
for f in heatpump-*.yaml acurite-bridge.yaml; do
  .venv/bin/esphome -q config "$f" > /dev/null || break
  echo "valid: $f"
done
```

`-q` hides the merged configuration and the warnings, and still prints
errors. Without it, expect warnings that do not fail the check: ESPHome
recommends encryption over an OTA password, and the AcuRite file warns that
GPIO5 is a strapping pin.

## Flash a board over USB

The first flash of each board goes over USB. Later updates go over Wi-Fi
([OTA](#ota)).

1. Read the power rule in your device guide first. The heat pump bridge must
   have CN105 unplugged while micro-USB is connected.
2. Plug the board into your computer with the micro-USB cable.
3. Run this in a laptop terminal, from the repository root. Replace the file
   name with your device file:

   ```sh
   .venv/bin/esphome run heatpump-livingroom.yaml
   ```

4. Choose the board's serial port when ESPHome asks. The first build
   downloads a toolchain and is slow. When the upload ends, ESPHome starts
   showing the device log. Press Ctrl+C to stop.

On Linux, if no serial port is listed, add your user to the `dialout` group,
then log out and back in. The
[ESPHome install guide](https://esphome.io/guides/installing_esphome/)
describes this.

To update a board that is already on your Wi-Fi, run this in a laptop
terminal:

```sh
.venv/bin/esphome run heatpump-livingroom.yaml --device OTA
```

`--device OTA` selects the network instead of asking for a serial port.

To read the log of a running device over Wi-Fi:

```sh
.venv/bin/esphome logs heatpump-livingroom.yaml
```

## Add a device to Home Assistant

When a flashed device joins your Wi-Fi, Home Assistant offers to set it up.
The
[Home Assistant ESPHome integration page](https://www.home-assistant.io/integrations/esphome/)
and the
[ESPHome getting-started guide](https://esphome.io/guides/getting_started_hassio/)
describe the same flow.

1. In Home Assistant, open Settings, then Devices and services.
2. Find the discovered ESPHome device. It carries the name from the config,
   for example `heatpump-livingroom`. Select it to set it up.
3. Enter the [API encryption key](#api-encryption-key): the value of the
   matching `*_api_encryption_key` line in your `secrets.yaml`.
4. Choose an area if Home Assistant asks, then finish.

If no device is discovered, add it by hand. In Devices and services select
Add Integration, choose ESPHome, and enter the host name `NAME.local`, where
`NAME` is the device name (for example `heatpump-livingroom.local`). The
device's IP address also works. Discovery needs a network that passes mDNS
traffic.

Each device in this repository then appears with its entities. The device
guides say what to expect.

## Next step

- [Heat pump bridge](heat-pump.md)
- [AcuRite bridge](acurite.md)

## Glossary

### ESPHome

Free software that builds firmware for ESP32 and similar chips from a YAML
text file, and connects the result to Home Assistant. See
[esphome.io](https://esphome.io/).

### Home Assistant

Free home automation software that runs on your own hardware. It shows and
controls devices such as the ones built here. See
[home-assistant.io](https://www.home-assistant.io/).

### CN105

The five-pin service connector on the circuit board of many Mitsubishi
indoor heat pump units. It carries power and a serial data link. The
[MitsubishiCN105ESPHome README](https://github.com/echavet/MitsubishiCN105ESPHome)
lists compatible units.

### Logic-level converter

A small board that joins two circuits running at different signal voltages.
The CN105 data lines run at 5 V and the ESP32 pins at 3.3 V, so the heat pump
bridge puts a converter between them.

### OTA

Over the air: sending new firmware to a device over Wi-Fi instead of a USB
cable. It works after the first USB flash.

### Strapping pin

A chip pin whose voltage at power-up selects the boot mode. On the ESP32-C3
these are GPIO2, GPIO8 and GPIO9, per the
[Espressif DevKitM-1 user guide](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32c3/esp32-c3-devkitm-1/user_guide.html).
The heat pump bridge avoids them.

### Baud rate

The speed of a serial link in symbols per second. Both ends must use the same
rate. The heat pump port uses 2400 baud: 2400 symbols per second.

### API encryption key

A 32-byte secret, written in base64, that a device and Home Assistant share.
Home Assistant asks for it once when you add the device. The key is set in
`secrets.yaml`; see the
[ESPHome native API page](https://esphome.io/components/api/).
