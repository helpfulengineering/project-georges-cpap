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

$fn=128;  // Face number: 128 for quality, 16 for speed.

union() {
    difference() {
        union() {
            rotate([90,0,0]) barb(10, 20, clearance=10, wall=1.2, barb=0.5);
            rotate([-90,0,0]) barb(10, 20, clearance=10, wall=1.2, barb=0.5);
        }

        cylinder(10, d=10);
    }

    difference() {
        barb(10, 20, clearance=10, wall=1.2, barb=0.5);
        translate([0, 5,0]) rotate([90,0,0]) cylinder(10, d=7.6);
    }
}
    
