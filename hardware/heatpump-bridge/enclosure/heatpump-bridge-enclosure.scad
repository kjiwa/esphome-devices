/* [Part] */
Part = "box"; // [box, lid, assembly]

/* [ESP32] */
ESP32_Length = 38.91; // PCB length (drawing)
ESP32_Width = 25.4; // PCB width (drawing)
ESP32_Thickness = 1.6; // PCB thickness (check on a test print)
ESP32_Top_Height = 5; // PCB underside to the tallest part (check on a test print)
ESP32_Top_Width = 14; // Width of the tall parts on top (check on a test print)
Antenna_Overhang = 5.4; // Antenna module beyond the PCB end (drawing)
USB_Overhang = 0.8; // Micro-USB beyond the PCB end (drawing)
Header_Row_Spacing = 22.86; // Distance between the two pin rows (drawing)
Header_Body_Height = 2.5; // Plastic body of the pin header under the PCB (check on a test print)

/* [Carrier] */
Carrier_Length = 35.56; // Carrier board length (KiCad)
Carrier_Width = 17.78; // Carrier board width (KiCad)
Carrier_Thickness = 1.6; // Carrier board thickness (KiCad)
Carrier_Height = 7; // Carrier underside to the top of the converter (check on a test print)
Carrier_Gap = 1; // Converter top to the ESP32 PCB underside (check on a test print)
Pin_Tail = 3; // Pin tails under the carrier (check on a test print)
Right_Angle_Pin_Height = 1.27; // Pin centre above the carrier top (check on a test print)
Plug_Reach = 16; // Header hole centre to the back of the Dupont housing (check on a test print)

/* [Wiring] */
Dupont_Length = 14; // Dupont housing length on the ESP32 pins (check on a test print)
Dupont_Size = 2.54; // Dupont housing width and height (check on a test print)
Wire_Bend = 5; // Space for wires to bend (check on a test print)
Lead_Width = 8; // CN105 lead width (check on a test print)
Lead_Height = 2; // CN105 lead thickness (check on a test print)
Lead_Crush = 0.3; // How far the lid tab squeezes the lead (check on a test print)

/* [Box] */
Wall_Thickness = 1.6; // Side and end wall thickness
Floor_Thickness = 1.2; // Floor thickness
Corner_Radius = 2; // Outside radius of the vertical corners
Board_Clearance = 0.2; // Gap around boards and wiring
Rail_Thickness = 0.8; // Thickness of the two rails that carry the ESP32
Ledge_Width = 1.2; // How far each ledge holds the carrier edge
Nub_Height = 0.8; // Height of the stop nubs above rail and ledge tops

/* [Lid] */
Lid_Thickness = 1.6; // Lid plate thickness
Lid_Lip_Depth = 2; // How far the lip reaches into the box
Lid_Lip_Thickness = 1.2; // Lip wall thickness
Lid_Clearance = 0.2; // Gap between the lid and the box
Top_Clearance = 0.5; // Gap between the tallest ESP32 part and the lid

/* [Preview] */
Show_Lid = false; // Show the lid on the assembly
Show_Section = false; // Cut the assembly lengthwise

/* [Hidden] */
$fn = 48;
Pitch = 2.54;
Header_Pins = 15;
Carrier_Pins = 5;
Header_Offset = 1.27; // KiCad: pin row offset from the carrier centreline
Edge_Margin = 1.69; // KiCad: pad-free margin along the carrier long edge nearest the pin rows
J_ESP32_Hole = 5.715; // KiCad: J_ESP32_1 hole row from its carrier end
J_CN105_Hole = 9.525; // KiCad: J_CN105_1 hole row from its carrier end
Nub_Length = 1;

Carrier_X0 = (ESP32_Length - Carrier_Length) / 2;
Carrier_Z0 = -(Carrier_Gap + Carrier_Height);
Carrier_Top = Carrier_Z0 + Carrier_Thickness;
Carrier_Half = Carrier_Width / 2;
Pin_Z = Carrier_Top + Right_Angle_Pin_Height;
Lead_Bottom = Pin_Z - Lead_Height / 2;
Lead_Top = Pin_Z + Lead_Height / 2;
Plug_Top = Carrier_Top + Dupont_Size;

Hole_ESP32_X = Carrier_X0 + J_ESP32_Hole;
Hole_CN105_X = Carrier_X0 + Carrier_Length - J_CN105_Hole;
Plug_ESP32_X = Hole_ESP32_X - Plug_Reach;
Plug_CN105_X = Hole_CN105_X + Plug_Reach;

Floor_Top = -(Header_Body_Height + Dupont_Length + Wire_Bend);
Rim_Z = ESP32_Top_Height + Top_Clearance;
Cavity_X0 = Plug_ESP32_X - Wire_Bend - Board_Clearance;
Cavity_X1 = Plug_CN105_X + Board_Clearance;
Cavity_Y = ESP32_Width / 2 + Board_Clearance;

Rail_In = Carrier_Half + Board_Clearance;
Rail_X0 = -Board_Clearance - Nub_Length;
Header_X1 = ESP32_Length / 2 + Header_Pins * Pitch / 2;
Row_Y = Header_Row_Spacing / 2;

assert(Rail_Thickness > 0 && Rail_In + Rail_Thickness <= Row_Y - Dupont_Size / 2,
  "Rails overlap the ESP32 header rows: reduce Rail_Thickness or Board_Clearance");
assert(Ledge_Width > 0 && Ledge_Width < Edge_Margin,
  "Ledge_Width must stay below the carrier pad-free edge margin");
assert(Nub_Height > 0 && Nub_Height < min(ESP32_Thickness, Carrier_Thickness),
  "Nub_Height must stay below both board thicknesses");
assert(Lid_Clearance > 0 && Top_Clearance > 0, "Lid_Clearance and Top_Clearance must be positive");
assert(Corner_Radius > Wall_Thickness, "Corner_Radius must exceed Wall_Thickness");
assert(Lead_Crush > 0 && Lead_Crush < Lead_Height, "Lead_Crush must be between 0 and Lead_Height");

module RoundedRect(x0, x1, y0, y1, r) {
  hull()
    for (x = [x0 + r, x1 - r], y = [y0 + r, y1 - r])
      translate([x, y]) circle(r);
}

module Outline() {
  RoundedRect(Cavity_X0 - Wall_Thickness, Cavity_X1 + Wall_Thickness,
    -Cavity_Y - Wall_Thickness, Cavity_Y + Wall_Thickness, Corner_Radius);
}

module Cavity() {
  RoundedRect(Cavity_X0, Cavity_X1, -Cavity_Y, Cavity_Y, Corner_Radius - Wall_Thickness);
}

module Block(x0, x1, y0, y1, z0, z1) {
  translate([x0, y0, z0]) cube([x1 - x0, y1 - y0, z1 - z0]);
}

module Rails() {
  for (s = [-1, 1])
    scale([1, s, 1]) {
      Block(Rail_X0, Cavity_X1 + Wall_Thickness / 2, Rail_In, Rail_In + Rail_Thickness, Floor_Top - 0.1, 0);
      for (x = [Rail_X0, ESP32_Length + Board_Clearance])
        Block(x, x + Nub_Length, Rail_In, Rail_In + Rail_Thickness, 0, Nub_Height);
    }
}

module Ledges() {
  x0 = Carrier_X0 - Board_Clearance - Nub_Length;
  x1 = Carrier_X0 + Carrier_Length + Board_Clearance + Nub_Length;
  inner = Carrier_Half - Ledge_Width;
  for (s = [-1, 1])
    scale([1, s, 1])
      translate([x0, 0, 0]) {
        rotate([90, 0, 90])
          linear_extrude(x1 - x0)
            polygon([[inner, Carrier_Z0], [Rail_In + 0.1, Carrier_Z0],
              [Rail_In + 0.1, Carrier_Z0 - (Rail_In - inner)]]);
        for (x = [0, x1 - x0 - Nub_Length])
          Block(x, x + Nub_Length, inner, Rail_In, Carrier_Z0, Carrier_Z0 + Nub_Height);
      }
}

module Notch() {
  Block(Cavity_X1 - 0.1, Cavity_X1 + Wall_Thickness + 0.1,
    Header_Offset - Lead_Width / 2 - Lid_Clearance, Header_Offset + Lead_Width / 2 + Lid_Clearance,
    Lead_Bottom, Rim_Z + 1);
}

module Box() {
  difference() {
    translate([0, 0, Floor_Top - Floor_Thickness])
      linear_extrude(Rim_Z - Floor_Top + Floor_Thickness) Outline();
    translate([0, 0, Floor_Top]) linear_extrude(Rim_Z - Floor_Top + 1) Cavity();
    Notch();
  }
  Rails();
  Ledges();
}

module Lid() {
  tab_bottom = Lead_Top - Lead_Crush;
  linear_extrude(Lid_Thickness) Outline();
  translate([0, 0, Lid_Thickness])
    linear_extrude(Lid_Lip_Depth)
      difference() {
        offset(delta = -Lid_Clearance) Cavity();
        offset(delta = -Lid_Clearance - Lid_Lip_Thickness) Cavity();
      }
  Block(Cavity_X1, Cavity_X1 + Wall_Thickness,
    Header_Offset - Lead_Width / 2, Header_Offset + Lead_Width / 2,
    Lid_Thickness, Lid_Thickness + Rim_Z - tab_bottom);
}

module LidAssembled() {
  translate([0, 0, Rim_Z + Lid_Thickness]) mirror([0, 0, 1]) Lid();
}

module Boards() {
  Block(0, ESP32_Length, -ESP32_Width / 2, ESP32_Width / 2, 0, ESP32_Thickness);
  Block(-Antenna_Overhang, ESP32_Length + USB_Overhang, -ESP32_Top_Width / 2, ESP32_Top_Width / 2,
    ESP32_Thickness, ESP32_Top_Height);
  for (s = [-1, 1])
    Block(ESP32_Length / 2 - Header_Pins * Pitch / 2, Header_X1,
      s * Row_Y - Dupont_Size / 2, s * Row_Y + Dupont_Size / 2, -Header_Body_Height, 0);
  Block(Carrier_X0, Carrier_X0 + Carrier_Length, -Carrier_Half, Carrier_Half,
    Carrier_Z0, -Carrier_Gap);
}

module LeadPath() {
  Block(Plug_CN105_X, Cavity_X1 + Wall_Thickness + 5,
    Header_Offset - Lead_Width / 2, Header_Offset + Lead_Width / 2, Lead_Bottom, Lead_Top);
}

module PlugKeepOut(x0, x1) {
  Block(x0, x1, Header_Offset - Carrier_Pins * Pitch / 2, Header_Offset + Carrier_Pins * Pitch / 2,
    Carrier_Top, Plug_Top);
}

module TailKeepOut(x) {
  reach = (Carrier_Pins - 1) * Pitch / 2 + 0.32;
  Block(x - 0.32, x + 0.32, Header_Offset - reach, Header_Offset + reach,
    Carrier_Z0 - Pin_Tail, Carrier_Z0);
}

module KeepOuts(Lead = true) {
  for (s = [-1, 1])
    Block(Rail_X0, Header_X1, s * Row_Y - Dupont_Size / 2, s * Row_Y + Dupont_Size / 2,
      Floor_Top, -Header_Body_Height);
  Block(Cavity_X0 + Board_Clearance, Rail_X0 - Board_Clearance, -ESP32_Width / 2, ESP32_Width / 2, Floor_Top, Plug_Top);
  PlugKeepOut(Plug_ESP32_X, Hole_ESP32_X);
  PlugKeepOut(Hole_CN105_X, Plug_CN105_X);
  TailKeepOut(Hole_ESP32_X);
  TailKeepOut(Hole_CN105_X);
  if (Lead) LeadPath();
}

module Assembly() {
  difference() {
    union() {
      color("lightgray") Box();
      color("seagreen") Boards();
      color("orangered", 0.35) KeepOuts();
      if (Show_Lid) color("steelblue", 0.6) LidAssembled();
    }
    if (Show_Section) translate([-100, -200, -100]) cube(200);
  }
}

if (Part == "box") translate([0, 0, -(Floor_Top - Floor_Thickness)]) Box();
if (Part == "lid") Lid();
if (Part == "assembly") Assembly();
