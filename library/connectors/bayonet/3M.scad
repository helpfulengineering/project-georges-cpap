/*
 * Module: bayonet connectors for 3M particle filters.
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

use <tube.scad>;
module 3M_bayonet_male(diameter=21, length=7, wall=1.5, pin=[2, 7, 3.5]) {
    /// Creates a male bayonet connector for 3M particle filters.
    ///
    /// ## Arguments
    /// * `diameter`: outer diameter (excluding the pins).
    /// * `length`: total length.
    /// * `wall`: wall thickness.
    /// * `pin`: [length, width, thickness].
    ///
    /// ## Examples
    /// ```
    /// bayonet(); // 3M standard
    /// ```
    difference() {
        union() {
            cylinder(r=diameter / 2, h=length);
            for(angle = [0:120:360]) {
                rotate([0, 0, angle]) {
                    intersection() {
                        translate([-pin[1] / 2, 0, 0]) {
                            cube([pin[1], diameter, length]);
                        }
                        cylinder(r=diameter / 2 + pin[0], h=pin[2]);
                    }
                }
            }
        }
        cylinder(r=diameter / 2 - wall * 2, h=length);
    }
}
