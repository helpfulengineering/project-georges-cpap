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
use <library/connectors/hose/barb.scad>;

$fn=128;  // Face number: 128 for quality, 16 for speed.

module georges_aleks(
    id=10, 
    channel=0.3,
    channel_length=5,
    deflector_len=5, 
    chamber_height=8,
    chamber_dia=25,
    barb_dia=6,
    wall=1.5,
    barb=1,
    final_width=22.5
) {
    overall_height = wall*2 + chamber_height + channel_length + deflector_len;
    overall_width = chamber_dia + wall*4;
    union() {
        difference() {
            // outer shell
            union() {
                cylinder(4*wall, d=overall_width);
                translate([0,0,4*wall]) cylinder(overall_height - 4*wall, d1=overall_width, d2=final_width);

            }
            
            cylinder(overall_height, d=id);
            
            // chamber
            translate([0,0,wall]) difference() {
                cylinder(chamber_height, d1=chamber_dia + wall*2, d2=id + wall*2 + channel * 2);
                cylinder(chamber_height, d=id + wall*2);
            }

            // channel
            translate([0,0,wall + chamber_height - channel]) difference() {
                cylinder(channel_length, d=id + wall*2 + channel * 2);
                cylinder(channel_length, d=id + wall*2);
            }

            // deflector
            translate([0,0,wall + chamber_height - channel + channel_length]) difference() {
                cylinder(deflector_len, d1=id + wall*2 + channel * 2, d2=id);

            }

            translate([0,id/2 + wall,barb_dia / 2 + barb]) rotate([270,0,0]) cylinder(chamber_dia/2 + wall, d=barb_dia - wall*2);

        }
         translate([0,(overall_width /2) - wall,barb_dia / 2 + barb]) rotate([270,0,0]) barb(barb_dia, 15, clearance=5, wall=wall, barb=barb);
        union() {
            translate([0, 0, overall_height]) ISO5356_1(diameter=22, length=25, type="male");
            translate([0, 0, overall_height]) tube(diameter=22, length=25, wall=-6);
        }
    }
    
    
}

difference() {
    georges_aleks();

    // translate([0, -50, 0]) cube([100,100,100]);
}
