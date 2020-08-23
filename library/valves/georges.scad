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
    diameter=[35, 15],
    length=12,
    wall=2,
    barb=[6, 10, 0.66, 5],
    channel=0.4,
    angle=22.5
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
    secant = sqrt(pow(tan(angle), 2) + 1) / tan(angle);
    chamber = (diameter[0] - diameter[1]) / 2 - 2 * wall;

    difference() {
        tube(
            diameter=diameter[0],
            length=length,
            wall=(diameter[1] - diameter[0]) / 2
        );
        translate([0, 0, wall]) {
            tube(
                diameter=diameter[0] - 2 * wall,
                length=chamber,
                wall=-[chamber,  2 * channel * secant]
            );
            translate([0, 0, chamber]) {
                tube(
                    diameter=[diameter[0] - 2 * wall, diameter[1]],
                    length=(chamber + wall) * tan(angle),
                    wall=-[2 * channel, channel]
                );
            }
        }
        translate([0, 2 * wall - diameter[0] / 2, barb[0] / 2 + barb[2]]) rotate([90, 0, 0]) {
            tube(barb[0] + 2 * barb[2] - 2 * wall, barb[1], -(barb[0] / 2 + barb[2] - wall));
        }
    }
    translate([0, wall - diameter[0] / 2, barb[0] / 2 + barb[2]]) rotate([90, 0, 0]) {
        barb(barb[0], barb[1], wall=wall - barb[2], barb=barb[2], clearance=barb[3]);
    }
}
