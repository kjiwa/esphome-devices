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

module CarrierRaised() {
  intersection() {
    translate([0, 0, Board_Clearance + 0.1])
      Block(Carrier_X0, Carrier_X0 + Carrier_Length, -Carrier_Half, Carrier_Half, Carrier_Z0, Carrier_Top);
    Block(Carrier_X0, Carrier_X0 + Carrier_Length, -Carrier_Half, Carrier_Half, Carrier_Top, Carrier_Top + 1);
  }
}

module PryProbe() {
  Block(Cavity_X0 - Wall_Thickness + 0.1, Cavity_X0 - 0.1, -2, 2,
    Rim_Z + 0.1, Rim_Z + Pry_Height - 0.1);
}

module TieBar(grow = 0) {
  Block(Tie_X - (Tie_Strap + grow) / 2, Tie_X + (Tie_Strap + grow) / 2,
    Header_Offset - Block_Half - 1, Header_Offset + Block_Half + 1,
    Tie_Z - (Tie_Thickness + grow) / 2, Tie_Z + (Tie_Thickness + grow) / 2);
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
if (Check == "lid-snap") intersection() { LidSettled(); translate([0, 0, -Settle]) Box(Grooves = false); }
if (Check == "carrier-catch") intersection() { BoxSettled(); CarrierRaised(); }
if (Check == "tie-hole") intersection() { BoxSettled(); TieBar(); }
if (Check == "tie-block") intersection() { BoxSettled(); TieBar(1); }
if (Check == "pry-slot") intersection() { LidSettled(); PryProbe(); }
