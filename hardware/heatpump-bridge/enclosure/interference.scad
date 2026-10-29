include <heatpump-bridge-enclosure.scad>

Part = "none";
Check = "";

// Parts rest on each other with coplanar faces; the offsets keep float noise out of the intersections.
Settle = 0.01;

module BoxSettled() { translate([0, 0, -Settle]) Box(); }
module LidSettled() { translate([0, 0, Settle]) LidAssembled(); }

module Slab(x0, z, length) {
  translate([x0, -ESP32_Width / 2, z - 0.2]) cube([length, ESP32_Width, 0.2]);
}

module NotchPlane() {
  x = Cavity_X1 + Wall_Thickness / 2;
  Block(x - 0.1, x + 0.1, Header_Offset - Lead_Width / 2 - 1, Header_Offset + Lead_Width / 2 + 1,
    Lead_Bottom - 1, Lead_Top + 1);
}

if (Check == "box-boards") intersection() { BoxSettled(); Boards(); }
if (Check == "box-keepouts") intersection() { BoxSettled(); KeepOuts(); }
if (Check == "lid-box") intersection() { LidSettled(); BoxSettled(); }
if (Check == "lid-boards") intersection() { LidSettled(); Boards(); }
if (Check == "lid-keepouts") intersection() { LidSettled(); KeepOuts(Lead = false); }
if (Check == "lid-lead") intersection() { LidSettled(); LeadPath(); }
if (Check == "rail-support") intersection() { BoxSettled(); Slab(0, 0, ESP32_Length); }
if (Check == "ledge-support") intersection() { BoxSettled(); Slab(Carrier_X0, Carrier_Z0, Carrier_Length); }
if (Check == "box-detail") intersection() { BoxSettled(); Detail(); }
if (Check == "lid-detail") intersection() { LidSettled(); Detail(Lead = false); }
if (Check == "lead-notch") intersection() { Detail(); NotchPlane(); }
