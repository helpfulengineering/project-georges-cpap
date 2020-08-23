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

use <../library/connectors/hose/barb.scad>;
use <../library/connectors/bottle/necks_caps.scad>;

$fn=128;  // Face number: 128 for quality, 16 for speed.

difference() {
    union() {
        translate([0,0,12]) 28PCO1881();
        cylinder(12, d=32);
        translate([0, 7, 5.5]) rotate([270,0,0]) barb(10, 25, clearance=15, wall=1.1, barb=0.5);
        translate([0, -7, 5.5]) rotate([90,0,0]) barb(10, 25, clearance=15, wall=1.1, barb=0.5);
    }

    translate([0,8,5.99]) cylinder(8, d1=3.5, d2=5);
    translate([0,6,5.5]) rotate([270,0,0]) cylinder(10, d=7.1);

    translate([0,-16,5.9]) rotate([270,0,0]) cylinder(14, d=7.1);
    translate([0,-4.7,5.99]) cylinder(8, d=4.7);

}
  
