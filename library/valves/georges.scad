/*
 * Module: Georges CPAP virtual valve.
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

use <../../library/primitives/tube.scad>;
use <../../library/connectors/hose/barb.scad>;
module georges(
    diameter=[15, 45],
    length=10,
    wall=1,
    barb=[6, 10, 0.66, 5],
    channel=0.4,
    angle=40
) {
    /// Creates a Georges CPAP virtual valve.
    ///
    /// ## Arguments
    /// * `diameter`: [inner, outer].
    /// * `length`: total length.
    /// * `wall`: wall thickness.
    /// * `channel`: channel breadth.
    /// * `angle`: channel angle.
    ///
    /// ## Examples
    /// ```
    /// georges();
    /// ```
    translate([0, 0, length]) mirror([0, 0, 1]) {
        difference() {
            cylinder(r=diameter[1] / 2, h=length);
            cylinder(r=diameter[0] / 2, h=length);
            translate([0, 0, wall]) {
                tube(
                    wall=-wall,
                    diameter=diameter[1] - 2 * wall,
                    length=length - 2 * wall
                );
            }
            translate([0, 0, length - 3 * wall]) {
                tube(
                    wall=-(2 * wall + channel),
                    diameter=diameter[1] - 2 * wall,
                    length=2 * wall
                );
            }
            translate([
                0, 0,
                length - (diameter[1] - 2 * wall) * tan(angle) / 4 - wall
            ]) {
                tube(
                    diameter=[diameter[0], diameter[1] - 2 * wall],
                    length=(diameter[1] - 2 * wall) * tan(angle) / 4,
                    wall=[-channel, -wall]
                );
            }
            difference() {
                translate([0, -diameter[1] / 2 + 2 * wall , length / 2]) {
                    rotate([90, 0, 0]) {
                        barb(barb[0], barb[1], wall=barb[0] / 2, barb=barb[2]);
                    }
                }
                // preserve wall thickness at barb junction
                translate([-barb[0]/2 - 0.1, -diameter[1] / 2 + 1 * wall - 2, length - wall]) cube([barb[0] + 0.2, barb[0], wall]);
                translate([-barb[0]/2 - 0.1, -diameter[1] / 2 + 1 * wall - 2, 0]) cube([barb[0] + 0.2, barb[0], wall]);
            }
        }

        translate([0, -diameter[1] / 2 + wall, length / 2]) {
             rotate([90, 0, 0]) {
                barb(barb[0], barb[1], clearance=barb[3], wall=barb[0] / 8, barb=barb[2]);
            }
        }
        for(support = [0:12:360]) {
            rotate([0, 0, support]) {
                translate([diameter[0] / 2 + wall, -wall, length - 3 * wall - 0.1]) {
                    cube([
                        (diameter[1] - diameter[0]) / 2 - 2 * wall,
                        wall,
                        2 * wall + channel
                    ]);
                }
            }
        }
    }
}
