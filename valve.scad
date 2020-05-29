/*
 * Model: pneumatic CPAP with no moving parts.
 * Copyright (C) 2020 Helio Machado <0x2b3bfa0@googlemail.com>
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

$fn=128;  // Face number: 128 for quality, 16 for speed.


intersection(){
    georges(
        diameter=[35, 15],
        length=12,
        wall=2,
        barb=[6, 10, 0.66, 5],
        channel=0.4,
        angle=22.5
    );
    translate([0, 0, 12]) {
        mirror([0, 0, 1]) {
            ISO5356_1(diameter=15, type="female", wall=45);
        }
    }
}

union() {
    translate([0, 0, 12]) ISO5356_1(diameter=22, length=25, type="male");
    translate([0, 0, 12]) tube(diameter=21, length=25, wall=-2.9);
}