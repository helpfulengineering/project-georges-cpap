/*
 * Model: pneumatic CPAP with no moving parts, mask included.
 *
 * Copyright (C) 2020 Helio Machado <0x2b3bfa0@googlemail.com>
 *                    Aleks Clark   <aleks.clark@gmail.com>
 *
 * This code describes open hardware and is licensed under the CERN-OHL-P V2.
 *
 * You may distribute, modify and materialize these designs as long as you do
 * it under the terms of the CERN-OHL-P V2 license (https:/cern.ch/cern-ohl).
 * This documentation is distributed WITHOUT ANY EXPRESS OR IMPLIED WARRANTY,
 * INCLUDING OF MERCHANTABILITY, SATISFACTORY QUALITY AND FITNESS FOR A GIVEN
 * PURPOSE.
 *
 * Please refer to the accompanying CERN-OHL-P V2 license text for a detailed
 * description of the applicable conditions.
 */

use <../library/primitives/tube.scad>;
use <../library/connectors/hose/barb.scad>;
// use <../library/connectors/bottle/necks_caps.scad>;

$fn=128;  // Face number: 128 for quality, 16 for speed.

difference() {
    cylinder(16, d=27);
    translate([0,0,4]) cylinder(12, d1=21, d2=22.5);
    translate([-8,0,4]) rotate([0,90,0]) cylinder(22, d=3.6);
}

translate([13,0,4]) rotate([0,90,0]) barb(6, 15, wall=1.2, clearance=5);
  
