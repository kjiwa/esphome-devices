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
Tie_Width = 3; // Zip tie slot width for the lead tie point (check on a test print; 0 to disable)

/* [Box] */
Wall_Thickness = 1.6; // Side and end wall thickness
Floor_Thickness = 1.2; // Floor thickness
Corner_Radius = 2; // Outside radius of the vertical corners
Board_Clearance = 0.2; // Gap around boards and wiring
Rail_Thickness = 0.8; // Thickness of the two rails that carry the ESP32
Ledge_Width = 1.2; // How far each ledge holds the carrier edge
Nub_Height = 0.8; // Height of the stop nubs above rail and ledge tops
Catch_Reach = 0.5; // How far each rail hook reaches over the carrier edge (check on a test print; 0 to disable)

/* [Lid] */
Lid_Thickness = 1.6; // Lid plate thickness
Lid_Lip_Depth = 2; // How far the lip reaches into the box
Lid_Lip_Thickness = 1.2; // Lip wall thickness
Lid_Clearance = 0.2; // Gap between the lid and the box
Top_Clearance = 0.5; // Gap between the tallest ESP32 part and the lid
Snap_Depth = 0.4; // How far the lid snap bumps stand out of the lip (check on a test print; 0 to disable)
Pry_Width = 6; // Width of the slot that lets a screwdriver lift the lid (check on a test print; 0 to disable)

/* [Preview] */
Show_Lid = false; // Show the lid on the assembly
Show_Section = false; // Cut the assembly lengthwise
Show_Wiring = true; // Show the keep-out volumes, and a translucent lid (hidden when exploded)
Explode = 0; // Distance between exploded layers in mm (0 to disable)

/* [Hidden] */
$fn = 48;
Pitch = 2.54;
Header_Pins = 15;
Carrier_Pins = 5;
Header_Offset = 1.27; // KiCad: pin row offset from the carrier centreline
Edge_Margin = 1.69; // KiCad: pad-free margin along the carrier long edge nearest the pin rows
Converter_Court = 8.275; // KiCad: U_3V3_5V_1 courtyard half-width, wider than both header courtyards (8.12)
J_ESP32_Hole = 5.715; // KiCad: J_ESP32_1 hole row from its carrier end
J_CN105_Hole = 9.525; // KiCad: J_CN105_1 hole row from its carrier end
Nub_Length = 1; // Illustrative: nub length, not checked against a print
Pin_Width = 0.64; // Illustrative: render only
Wire_Radius = 0.35; // Illustrative: render only
Snap_Length = 8; // Illustrative: bump and groove length along the wall
Pry_Height = 0.8; // Illustrative: slot height under the lid plate
Catch_Length = 3; // Illustrative: hook length along the rail
Catch_Tip = 0.4; // Illustrative: hook thickness at its tip
Tie_Block_Length = 4.8; // Illustrative: tie block reach beyond the end wall, short of the lead housing
Tie_Floor = 1; // Illustrative: material between the tie slot and the block top
Tie_Strap = 2.5; // Illustrative: zip tie strap width
Tie_Thickness = 1; // Illustrative: zip tie strap thickness
Tie_Hole_Height = 1.4; // Illustrative: tie slot height
Cable_Fan = 4; // Length over which the CN105 wires gather behind their housings
Module_Width = 13.2; // Illustrative: render only
Module_Base = 0.8; // Illustrative: render only
USB_Width = 7.5; // Illustrative: render only
USB_Length = 5.4; // Illustrative: render only
USB_Height = 2.6; // Illustrative: render only
Converter_Margin = 3.5; // Illustrative: render only
Converter_Half = 5.1; // Illustrative: render only
PAP_Width = 10; // Illustrative: render only, PAP-05V-S housing size
PAP_Height = 5; // Illustrative: render only
PAP_Length = 8; // Illustrative: render only
Jumpers = [ // [carrier pin, ESP32 row side, ESP32 pin index from the antenna end, color]; illustrative pin choice
  [1, 1, 0, "white"],
  [2, -1, 0, "red"],
  [3, -1, 1, "deepskyblue"],
  [4, -1, 5, "yellow"],
  [5, -1, 6, "orange"]
];
Lead_Wires = [[2, "red"], [3, "white"], [4, "yellow"], [5, "orange"]]; // [carrier pin, color]

Carrier_X0 = (ESP32_Length - Carrier_Length) / 2;
Carrier_Z0 = -(Carrier_Gap + Carrier_Height);
Carrier_Top = Carrier_Z0 + Carrier_Thickness;
Carrier_Half = Carrier_Width / 2;
Pin_Z = Carrier_Top + Right_Angle_Pin_Height;
Lead_Bottom = Pin_Z - Lead_Height / 2;
Lead_Top = Pin_Z + Lead_Height / 2;
Plug_Top = Carrier_Top + Dupont_Size;
Carrier_Lift = Explode;
ESP32_Lift = 2 * Explode;
Lid_Lift = 3 * Explode;

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
Lead_End = Cavity_X1 + Wall_Thickness + 5;
Dupont_Bottom = -(Header_Body_Height + Dupont_Length);
Housing_Gap = Plug_Reach - Dupont_Length;
Block_Half = Lead_Width / 2 + Lid_Clearance;
Tie_X = Cavity_X1 + Wall_Thickness + Tie_Block_Length / 2;
Tie_Z = Lead_Bottom - Tie_Floor - Tie_Hole_Height / 2;
Catch_X = Carrier_X0 + Carrier_Length / 2 - Catch_Length / 2;
Snap_X = (Cavity_X0 + Cavity_X1) / 2 - Snap_Length / 2;
Snap_Z = Lid_Lip_Depth / 2;

assert(Rail_Thickness > 0 && Rail_In + Rail_Thickness <= Row_Y - Dupont_Size / 2,
  "Rails overlap the ESP32 header rows: reduce Rail_Thickness or Board_Clearance");
assert(Ledge_Width > 0 && Ledge_Width < Edge_Margin,
  "Ledge_Width must stay below the carrier pad-free edge margin");
assert(Nub_Height > 0 && Nub_Height < min(ESP32_Thickness, Carrier_Thickness),
  "Nub_Height must stay below both board thicknesses");
assert(Lid_Clearance > 0 && Top_Clearance > 0, "Lid_Clearance and Top_Clearance must be positive");
assert(Corner_Radius > Wall_Thickness, "Corner_Radius must exceed Wall_Thickness");
assert(Explode >= 0, "Explode must be 0 or positive");
assert(Wire_Bend > 2.5, "Wire_Bend must exceed 2.5 for the rendered jumper routing");
assert(Snap_Depth >= 0 && Snap_Depth < Wall_Thickness / 2 && 2 * Snap_Depth < Lid_Lip_Depth,
  "Snap_Depth must be 0 or positive, below half the wall, and the bump (twice as tall) must fit the lip");
assert(Pry_Width >= 0 && Pry_Height > 0 && Pry_Height < Lid_Thickness, "Pry slot must be shallower than the lid plate");
assert(Catch_Reach >= 0 && Carrier_Half - Catch_Reach >= Converter_Court,
  "Catch_Reach would put the hooks over the converter courtyard");
assert(Tie_Width == 0 || (Tie_Width >= Tie_Strap + 0.4 && Tie_Width < Tie_Block_Length - 1.6),
  "Tie_Width must pass the strap with 0.4 mm play and leave 0.8 mm of block each side");
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

module Catches() {
  if (Catch_Reach > 0) {
    tip = Carrier_Half - Catch_Reach;
    z0 = Carrier_Top + Board_Clearance;
    for (s = [-1, 1])
      scale([1, s, 1])
        translate([Catch_X, 0, 0])
          rotate([90, 0, 90])
            linear_extrude(Catch_Length)
              polygon([[Rail_In + 0.1, z0], [tip, z0], [tip, z0 + Catch_Tip],
                [Rail_In + 0.1, z0 + Catch_Tip + Rail_In + 0.1 - tip]]);
  }
}

module SnapProfile(y, z) {
  polygon([[y - 0.1, z - Snap_Depth - 0.1], [y + Snap_Depth, z], [y - 0.1, z + Snap_Depth + 0.1]]);
}

module Snaps(y, z) {
  if (Snap_Depth > 0)
    for (s = [-1, 1])
      scale([1, s, 1])
        translate([Snap_X, 0, 0])
          rotate([90, 0, 90])
            linear_extrude(Snap_Length) SnapProfile(y, z);
}

module TieBlock() {
  if (Tie_Width > 0) {
    depth = Tie_Floor + Tie_Hole_Height + 1;
    x0 = Cavity_X1 + Wall_Thickness;
    difference() {
      translate([x0 - 0.1, Header_Offset + Block_Half, Lead_Bottom])
        rotate([90, 0, 0])
          linear_extrude(2 * Block_Half)
            polygon([[0, 0], [Tie_Block_Length + 0.1, 0], [Tie_Block_Length + 0.1, -depth],
              [0, -depth - Tie_Block_Length]]);
      Block(Tie_X - Tie_Width / 2, Tie_X + Tie_Width / 2, Header_Offset - Block_Half - 1,
        Header_Offset + Block_Half + 1, Tie_Z - Tie_Hole_Height / 2, Tie_Z + Tie_Hole_Height / 2);
    }
  }
}

module Notch() {
  Block(Cavity_X1 - 0.1, Cavity_X1 + Wall_Thickness + 0.1,
    Header_Offset - Lead_Width / 2 - Lid_Clearance, Header_Offset + Lead_Width / 2 + Lid_Clearance,
    Lead_Bottom, Rim_Z + 1);
}

module Box(Grooves = true) {
  difference() {
    translate([0, 0, Floor_Top - Floor_Thickness])
      linear_extrude(Rim_Z - Floor_Top + Floor_Thickness) Outline();
    translate([0, 0, Floor_Top]) linear_extrude(Rim_Z - Floor_Top + 1) Cavity();
    Notch();
    if (Grooves) Snaps(Cavity_Y, Rim_Z - Snap_Z);
  }
  Rails();
  Ledges();
  Catches();
  TieBlock();
}

module PrySlot() {
  if (Pry_Width > 0)
    Block(Cavity_X0 - Wall_Thickness - 0.1, Cavity_X0, -Pry_Width / 2, Pry_Width / 2,
      Lid_Thickness - Pry_Height, Lid_Thickness + 0.1);
}

module Lid() {
  tab_bottom = Lead_Top - Lead_Crush;
  difference() {
    linear_extrude(Lid_Thickness) Outline();
    PrySlot();
  }
  Snaps(Cavity_Y - Lid_Clearance, Lid_Thickness + Snap_Z);
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
  Block(Carrier_X0, Carrier_X0 + Carrier_Length, -Carrier_Half, Carrier_Half, Carrier_Z0, Carrier_Top);
  Block(Carrier_X0, Carrier_X0 + Carrier_Length, -Converter_Court, Converter_Court, Carrier_Top, -Carrier_Gap);
}

module LeadPath() {
  Block(Plug_CN105_X, Lead_End,
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

function PinY(pin) = Header_Offset + (pin - 3) * Pitch;
function EspPinX(index) = ESP32_Length / 2 - Header_Pins * Pitch / 2 + (index + 0.5) * Pitch;

function JumperPath(pin, side, index) = let(
  k = pin - 1, y = PinY(pin), row_y = side * Row_Y, x = EspPinX(index),
  bend_x = Plug_ESP32_X - 1 - 0.8 * k, low = Dupont_Bottom - 1.4 - (Wire_Bend - 2.5) / 3 * max(k - 1, 0)
) [
  [Plug_ESP32_X, y, Pin_Z + Carrier_Lift],
  [bend_x, y, Pin_Z + Carrier_Lift],
  [bend_x, y, low + Carrier_Lift],
  [bend_x, row_y, low + ESP32_Lift],
  [x, row_y, low + ESP32_Lift],
  [x, row_y, Dupont_Bottom + ESP32_Lift]
];

module Wire(points) {
  for (i = [0 : len(points) - 2])
    hull() {
      translate(points[i]) sphere(Wire_Radius, $fn = 12);
      translate(points[i + 1]) sphere(Wire_Radius, $fn = 12);
    }
}

module Jumpers() {
  for (j = Jumpers) Tint(j[3]) Wire(JumperPath(j[0], j[1], j[2]));
}

module Housing(x0, x1, y) {
  Block(x0, x1, y - (Dupont_Size - 0.1) / 2, y + (Dupont_Size - 0.1) / 2, Carrier_Top, Plug_Top);
}

module HeaderPins(hole_x, toward) {
  Block(hole_x - Pin_Width / 2, hole_x + Pin_Width / 2, Header_Offset - Carrier_Pins * Pitch / 2,
    Header_Offset + Carrier_Pins * Pitch / 2, Carrier_Z0 - Pin_Tail, Carrier_Top);
  for (pin = [1 : Carrier_Pins])
    Block(min(hole_x, hole_x + toward * 8), max(hole_x, hole_x + toward * 8),
      PinY(pin) - Pin_Width / 2, PinY(pin) + Pin_Width / 2, Pin_Z - Pin_Width / 2, Pin_Z + Pin_Width / 2);
}

module RightAngleBody(hole_x) {
  Block(hole_x - Pitch / 2, hole_x + Pitch / 2, Header_Offset - Carrier_Pins * Pitch / 2,
    Header_Offset + Carrier_Pins * Pitch / 2, Carrier_Top, Plug_Top);
}

module CableFan(pin, index) {
  y = PinY(pin);
  strip = Lead_Width / 4;
  center = Header_Offset + (index - 1.5) * strip;
  hull() {
    Block(Plug_CN105_X - Cable_Fan - 0.1, Plug_CN105_X - Cable_Fan, y - 0.4, y + 0.4, Pin_Z - 0.4, Pin_Z + 0.4);
    Block(Plug_CN105_X, Plug_CN105_X + 0.1, center - strip / 2, center + strip / 2, Lead_Bottom, Lead_Top);
  }
  Block(Plug_CN105_X, Lead_End + 1, center - strip / 2, center + strip / 2, Lead_Bottom, Lead_Top);
}

module CarrierDetail(Lead) {
  translate([0, 0, Carrier_Lift]) {
    Tint("forestgreen") Block(Carrier_X0, Carrier_X0 + Carrier_Length, -Carrier_Half, Carrier_Half,
      Carrier_Z0, Carrier_Top);
    Tint("royalblue") Block(Hole_ESP32_X + Converter_Margin, Hole_CN105_X - Converter_Margin,
      -Converter_Half, Converter_Half, Carrier_Top, -Carrier_Gap);
    Tint("black") {
      RightAngleBody(Hole_ESP32_X);
      RightAngleBody(Hole_CN105_X);
    }
    Tint("gold") {
      HeaderPins(Hole_ESP32_X, -1);
      HeaderPins(Hole_CN105_X, 1);
    }
    Tint("dimgray")
      for (pin = [1 : Carrier_Pins])
        Housing(Plug_ESP32_X, Hole_ESP32_X - Housing_Gap, PinY(pin));
    Tint("dimgray")
      for (w = Lead_Wires)
        Housing(Hole_CN105_X + Housing_Gap, Plug_CN105_X - Cable_Fan, PinY(w[0]));
    if (Lead) {
      for (i = [0 : len(Lead_Wires) - 1]) Tint(Lead_Wires[i][1]) CableFan(Lead_Wires[i][0], i);
      Tint("beige")
        Block(Lead_End, Lead_End + PAP_Length, Header_Offset - PAP_Width / 2, Header_Offset + PAP_Width / 2,
          Pin_Z - PAP_Height / 2, Pin_Z + PAP_Height / 2);
    }
  }
}

module ESP32Detail() {
  translate([0, 0, ESP32_Lift]) {
    Tint("seagreen") Block(0, ESP32_Length, -ESP32_Width / 2, ESP32_Width / 2, 0, ESP32_Thickness);
    Tint("dimgray") Block(-Antenna_Overhang, ESP32_Length / 3, -Module_Width / 2, Module_Width / 2,
      ESP32_Thickness, ESP32_Thickness + Module_Base);
    Tint("silver") {
      Block(0, ESP32_Length / 3, -Module_Width / 2, Module_Width / 2,
        ESP32_Thickness + Module_Base, ESP32_Top_Height);
      Block(ESP32_Length + USB_Overhang - USB_Length, ESP32_Length + USB_Overhang, -USB_Width / 2, USB_Width / 2,
        ESP32_Thickness, ESP32_Thickness + USB_Height);
    }
    for (s = [-1, 1]) {
      Tint("black")
        Block(ESP32_Length / 2 - Header_Pins * Pitch / 2, Header_X1, s * Row_Y - Dupont_Size / 2,
          s * Row_Y + Dupont_Size / 2, -Header_Body_Height, 0);
      Tint("gold")
        for (i = [0 : Header_Pins - 1])
          Block(EspPinX(i) - Pin_Width / 2, EspPinX(i) + Pin_Width / 2, s * Row_Y - Pin_Width / 2,
            s * Row_Y + Pin_Width / 2, -Header_Body_Height - Pin_Tail,
            ESP32_Thickness + 0.6);
    }
    Tint("dimgray")
      for (j = Jumpers)
        Block(EspPinX(j[2]) - (Dupont_Size - 0.1) / 2, EspPinX(j[2]) + (Dupont_Size - 0.1) / 2,
          j[1] * Row_Y - Dupont_Size / 2, j[1] * Row_Y + Dupont_Size / 2, Dupont_Bottom, -Header_Body_Height);
  }
}

module ZipTie() {
  t = Tie_Thickness;
  inner = Block_Half + 0.05;
  outer = inner + t;
  top = Lead_Top + t;
  c = Header_Offset;
  Tint("black") {
    Block(Tie_X - Tie_Strap / 2, Tie_X + Tie_Strap / 2, c - outer, c + outer, Tie_Z - t / 2, Tie_Z + t / 2);
    Block(Tie_X - Tie_Strap / 2, Tie_X + Tie_Strap / 2, c - outer, c + outer, Lead_Top, top);
    for (s = [-1, 1])
      Block(Tie_X - Tie_Strap / 2, Tie_X + Tie_Strap / 2, c + min(s * inner, s * outer),
        c + max(s * inner, s * outer), Tie_Z - t / 2, top);
  }
}

module Detail(Lead = true) {
  ESP32Detail();
  CarrierDetail(Lead);
  Jumpers();
  if (Lead && Tie_Width > 0) ZipTie();
}

module Tint(c, a = 1) {
  color(c, a)
    if (Show_Section) difference() { children(); translate([-100, -200, -100]) cube(200); }
    else children();
}

module Assembly() {
  Tint("lightgray") Box();
  Detail();
  if (Show_Wiring && Explode == 0) Tint("orangered", 0.35) KeepOuts();
  if (Show_Lid)
    translate([0, 0, Lid_Lift])
      Tint(Show_Wiring ? "steelblue" : "darkgray", Show_Wiring ? 0.6 : 1) LidAssembled();
}

if (Part == "box") translate([0, 0, -(Floor_Top - Floor_Thickness)]) Box();
if (Part == "lid") Lid();
if (Part == "assembly") Assembly();
