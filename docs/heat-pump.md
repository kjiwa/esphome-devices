# Heat pump controller

Connect a Mitsubishi indoor heat pump unit to [Home Assistant](getting-started.md#home-assistant)
with a prebuilt Serin Labs ESP32 controller that plugs into the unit's
[CN105](getting-started.md#cn105) port.

<img src="images/heatpump-system.svg" alt="Block diagram: the heat pump CN105 port connects through a cable to the Serin controller, which reaches Home Assistant over Wi-Fi" width="420">

The heat pump talks to the controller over the cable, and the controller talks
to Home Assistant over Wi-Fi.

## Status and audience

Status: installed in three units on one outdoor unit and running. Measured
there: the log reports `Cycle ended in 1.0 seconds` with no timeout at
`update_interval: 2s`, and the Wi-Fi signal reads -51 to -79 dBm with the cover
on. The room thermometer feed has run on one unit, including the fall back to
the unit's own sensor when Home Assistant stopped. The firmware component is
third-party; see [Supported units](#supported-units).

This guide is for someone comfortable opening an indoor unit's cover. You do
not need to have used ESPHome before. Read [Getting started](getting-started.md)
first.

## Supported units

The firmware is
[echavet/MitsubishiCN105ESPHome](https://github.com/echavet/MitsubishiCN105ESPHome)
(BSD 2-Clause license). Its README says indoor units with a CN105 header are
generally compatible and links a list of supported models. Its README also
carries a "use at your own risk" notice: the protocol is reverse engineered
and not every unit supports every feature.

Where CN105 sits on the indoor unit's circuit board varies by model. Check
your unit's service documentation or the model list the README links. This
repository has run on two MSZ-GS09NA units and one MSZ-12NA unit. On the
12NA the Function Settings (`hardware_settings`) read zero over CN105, so they
are not supported there. The compressor frequency and ISEE sensors never
reported a value on these units, so the config leaves them out.

## Safety

The indoor unit runs on mains voltage.

1. Turn the indoor unit off at its circuit breaker before you open the
   panel.
2. Leave it off while you plug or unplug the cable.
3. Close the panel before you restore power.

If you are not comfortable working inside the unit, ask a qualified
technician. Connecting third-party hardware may affect your warranty
(unverified; check your terms).

## Parts

- **[Serin Labs CN105 ESP32 Controller](https://serin-labs.com/controller.html)**: quantity 1 per unit. It ships with a CN105-to-Grove cable, in 20 cm or 50 cm. Serin recommends 20 cm for wall units and cassettes, where the board tucks inside, and 50 cm for metal-bodied ducted air handlers. It ships unflashed. The board is an M5Stack NanoC6 (ESP32-C6), which this repository's config targets with the board, flash and framework settings from Serin's [ESP32-C6 board file](https://github.com/serin-labs/serin-cn105/blob/main/esphome/common/esp32c6.yaml).
- **A USB-C data cable**: for flashing. Power-only cables do not work.

The cable has no level shifting. The CN105 data lines run at 5 V and the
ESP32 pins at 3.3 V, which is outside the chip's rating, and the firmware
README advises a level shifter. Users report direct connections working: five
boards for about two years ([echavet discussion
348](https://github.com/echavet/MitsubishiCN105ESPHome/discussions/348)) and
two boards for over a year ([dpmworld issue 3](https://github.com/dpmworld/Mitsubishi-MSZ-HJ25VA-Home-Assistant-Integration/issues/3)).
No failures are reported there, but these are anecdotes, and Serin's pages
do not mention protection (unverified). A failure would likely stop the
controller talking to the unit.

## Flash the firmware

Flash with this repository's device file, not Serin's web flasher, so your
secrets and the room temperature feed apply. This replaces Serin's
firmware, so Serin's web flasher, Serin Link pairing, web server and Bluetooth
proxy are not included. Serin's vertical and horizontal vane selects are not in
`packages/heatpump.yaml` either.

1. Complete [Getting started](getting-started.md), including the secrets
   file.
2. Pick the device file for your room: `heatpump-livingroom.yaml`,
   `heatpump-kidsroom.yaml` or `heatpump-masterbedroom.yaml`. To add a room,
   copy one file and change its `name` and `area` lines. Every file includes
   [`packages/heatpump.yaml`](../packages/heatpump.yaml), which holds the
   settings that all rooms share.
3. Connect USB-C to the controller. The CN105 cable stays disconnected.
4. Run this in a laptop terminal, from the repository root:

   ```sh
   .venv/bin/esphome run heatpump-livingroom.yaml
   ```

5. Choose the serial port when asked. The log shows the device joining Wi-Fi.
6. Add the device in Home Assistant as described in
   [Getting started](getting-started.md#add-a-device-to-home-assistant). Use
   the value of `heatpump_api_encryption_key` as the key.
7. Unplug USB-C.

The serial speed to the heat pump is 2400 baud: the
[baud rate](getting-started.md#baud-rate) the CN105 port uses.

If the board does not show up as a serial port, try another USB-C data cable
before anything else.

## The power rule

<img src="images/heatpump-power.svg" alt="Power rule diagram: USB-C is for the bench only, the CN105 cable powers the controller when installed, and the two must never be connected at the same time" width="420">

Never connect both at once.

Serin's [setup guide](https://serin-labs.com/esphome/setup.html) says to
disconnect USB before connecting CN105. So:

- Flash over USB-C with the CN105 cable disconnected.
- Unplug USB-C before you connect the CN105 cable.
- To flash over USB again, disconnect the CN105 cable first.
- Update later over Wi-Fi ([OTA](getting-started.md#ota)).

## Install

1. Turn the indoor unit off at the breaker.
2. Take off the front cover and find CN105 on the control board.
3. Plug the cable into CN105 and the other end into the controller.
4. Place the controller in the right-hand cavity of the unit. No drilling is
   expected (unverified until the first install).
5. Close the cover, then restore power.
6. Wait for the device to come online in Home Assistant.

## Check it worked

A working controller shows these:

- A climate entity named after the device, for example "Heat Pump (Living
  Room)". The firmware authors say you should be able to change modes and
  temperature setpoints from it.
- Diagnostic sensors on the same device: Uptime, Wi-Fi signal, Outside air
  temperature, Input power, Energy, Runtime hours, Stage, Sub mode and Error
  code. Each unit's Input power and Energy are its own, not the whole outdoor
  unit's. Error code read `Error 0x80 sub 0x00` on all three units with
  nothing wrong; its meaning is unverified.
- A Room thermometer switch and a Room thermometer in use sensor; see
  [Use a room thermometer](#use-a-room-thermometer).
- A Wi-Fi signal that holds with the cover on and with it off. If it drops out
  with the cover on, reposition the controller inside the cavity.
- With the log open (run this in a laptop terminal), lines like
  `Cycle ended in 1.2 seconds (with timeout?: NO)`:

  ```sh
  .venv/bin/esphome logs heatpump-livingroom.yaml
  ```

If `with timeout?: YES` appears, see [Troubleshooting](#troubleshooting).

## Tune the update interval

`update_interval: 2s` in [`packages/heatpump.yaml`](../packages/heatpump.yaml)
sets how often the firmware polls the heat pump: 2 seconds. The firmware
authors say it should not go below the cycle time the log reports. They give
a worked example: a 1.2 second cycle suits about 1.5 seconds. The comment in
the file recommends values between 1 and 4 seconds.

Edit the value, then flash again over Wi-Fi with this command in a laptop
terminal:

```sh
.venv/bin/esphome run heatpump-livingroom.yaml --device OTA
```

## Use a room thermometer

The heat pump regulates to its own sensor, which sits in the indoor unit and
reads a few degrees off the room: on the installed units it read 3.3 to 4.7 °F
below a wall thermometer. The firmware can take a temperature from Home
Assistant instead, so the number on the remote means the temperature a room
thermometer reads. Home Assistant only supplies a reading. Mode, setpoint, fan
and power stay with the remote.

1. In Home Assistant, add a template sensor named after the entity in the
   room's device file (`room_temperature_entity`), here for a living room,
   with your thermometer's entity and the longest gap you accept:

   ```yaml
   template:
     - sensor:
         - name: Heatpump Livingroom Room Temperature
           unique_id: heatpump_livingroom_room_temperature
           device_class: temperature
           state_class: measurement
           unit_of_measurement: °F
           state: "{{ states('sensor.living_room_temperature') }}"
           availability: >-
             {{ has_value('sensor.living_room_temperature')
                and now() - states.sensor.living_room_temperature.last_reported
                    < timedelta(hours=3) }}
   ```

2. Flash the device again over Wi-Fi, as in
   [Tune the update interval](#tune-the-update-interval).
3. Switch Room thermometer on and set the remote to the temperature you want
   in the same minute. The switch is off after a flash until you turn it on,
   and it keeps its state across restarts. Switching it off returns the unit
   to its own sensor at once. Room thermometer in use turns on when the unit
   confirms it follows the feed.

The device sends a reading once a minute, and nothing for a non-numeric state
or a reading outside 1 to 40 °C. The unit falls back to its own sensor, so the
remote keeps working, in every case below. The first four wait for the 10
minute timeout:

```mermaid
flowchart TD
  sw{"Room thermometer on?"}
  ha{"Controller connected to Home Assistant?"}
  fresh{"Thermometer reported recently, reading in range?"}
  own["Unit uses its own sensor"]
  feed["Unit regulates to the thermometer"]
  sw -- no --> own
  sw -- yes --> ha
  ha -- no --> own
  ha -- yes --> fresh
  fresh -- no --> own
  fresh -- yes --> feed
```

If the ESP32 itself is down, the unit receives no updates and reverts by
itself (a firmware source comment says so; unverified on hardware). A client
such as `esphome logs` counts as a connection to Home Assistant, so a fall back
test needs the log closed.

Home Assistant is assumed to use °F. For °C, change `(x - 32) * (5.0 / 9.0)`
to `x` in [`packages/heatpump.yaml`](../packages/heatpump.yaml).

## Troubleshooting

These entries come from the firmware's documentation and from reading the
configuration, except where the text reports a measurement.

### Device not in Home Assistant

**Likely cause:** The controller did not join Wi-Fi: wrong SSID or password in `secrets.yaml`, or a 5 GHz-only network. Or discovery is blocked.

**Fix:** Flash over USB, with the CN105 cable disconnected, and read the log. Correct `secrets.yaml`. Or add the device by hand with its `.local` name or IP address.

### Device in Home Assistant but no climate entity

**Likely cause:** The firmware on the board is not the heat pump config, or the entity is hidden.

**Fix:** Open the device page in Home Assistant. If only Uptime and Wi-Fi signal show, flash a `heatpump-*.yaml` file again.

### Log shows `with timeout?: YES`

**Likely cause:** No answer from the heat pump: a loose cable, or a unit without CN105 support. A cold-boot UART issue is also described in the firmware README.

**Fix:** Reseat the cable at both ends with the unit off at the breaker. Read the WARNING at the top of the [firmware README](https://github.com/echavet/MitsubishiCN105ESPHome).

### Weak or dropping Wi-Fi

**Likely cause:** Metal parts inside the unit may shield the controller. One MSZ-GL18NA owner reported dropouts with the board inside the unit.

**Fix:** Read the Wi-Fi signal sensor with the cover on and off, then reposition the controller inside the cavity.

### Wi-Fi fallback access point appears

**Likely cause:** The controller cannot join your Wi-Fi, so it starts its own network named after the device, for example `heatpump-livingroom`.

**Fix:** Connect with the value of `heatpump_ap_password` and set up Wi-Fi again, or correct `secrets.yaml` and flash over USB with the CN105 cable disconnected.

For `pip` errors on Python 3.15, see [Set up the project](getting-started.md#set-up-the-project).

## Credits

- Firmware: [echavet/MitsubishiCN105ESPHome](https://github.com/echavet/MitsubishiCN105ESPHome),
  BSD 2-Clause, built on the
  [SwiCago/HeatPump](https://github.com/SwiCago/HeatPump) library.
- Controller hardware and board settings: [Serin Labs](https://serin-labs.com/controller.html)
  and [serin-labs/serin-cn105](https://github.com/serin-labs/serin-cn105)
  (MIT).

These are external projects. This repository only configures them.

## Next step

- [AcuRite bridge](acurite.md)
