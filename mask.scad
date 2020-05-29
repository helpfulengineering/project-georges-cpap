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

use <library/primitives/tube.scad>;
use <library/connectors/conical/ISO5356_1.scad>;
use <library/valves/georges.scad>;
use <library/connectors/hose/barb.scad>;

$fn=128;  // Face number: 128 for quality, 16 for speed.


module valve() {
    georges(
        diameter=[40, 15],
        length=18,
        wall=2,
        barb=[10, 30, 0.66, 20],
        channel=0.4,
        angle=35
    );
}


module mask() {
    difference() {
        union() {
            difference() {
                translate([-110.1, -101.9, 25]) import("library/masks/montana/body.stl");
                translate([-50, -50, -65]) cube([100, 100, 100]);
            }
            translate([0, 0, 35]) rotate([0, 180, 180]) {
                linear_extrude(35, convexity=10, scale=[0.6, 0.6]) {
                    import("library/masks/montana/adaptor.svg", center=true);  
                }
            }
        }
        cylinder(18, d=40);
        cylinder(38, d=15);
        translate([0, -15, 5.66]) rotate([90, 0, 0]) cylinder(35, d=10);
        translate([0, 25, 1]) cylinder(35, d=5);
        translate([0, 26, 3]) rotate([270, 0, 0]) cylinder(35, d1=5);
    }
}


difference() {
    union() {
        mask();
        valve();
        difference() {
            translate([0, 26, 3]) rotate([270,0,0]) barb(6.35, 20, clearance=10, wall=1, barb=0.5);
            translate([0, 25, 1]) cylinder(35, d=5);
        }
    }
    // cut off the bottom of the barb for ease of printing
    translate([0, 0, -1.5]) cube([50, 150, 3], center=true);
}