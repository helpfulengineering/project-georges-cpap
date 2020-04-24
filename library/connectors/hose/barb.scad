/*
 * Module: hose barb fitting.
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

use <../../../library/primitives/tube.scad>;
module barb(diameter, length, clearance=1, barb=1, angle=15, wall=2) {
    /// Creates a hose barb fitting.
    ///
    /// ## Arguments
    /// * `diameter`: tube outer diameter (doesn't count barbs).
    /// * `length`: total barb length (including `clearance`).
    /// * `clearance`: length of the zone without barbs at the start.
    /// * `barb`: extension of the barbs over `diameter`.
    /// * `angle`: angle of the barbs.
    /// * `wall`: tube wall thickness.
    ///
    /// Notes: `wall` and `thickness` can take a single numerical value
    /// or two separate values inside a vector (one for each end); the
    /// sign of `wall` will determine its placement (inside/outside).
    ///
    /// ## Examples
    /// ```
    /// barb(diameter=10, length=20);
    /// ```

    tube(diameter, length, -abs(wall));
    start = length - barb / tan(angle);
    step = - barb / tan(angle);
    end = clearance;
    for(count=[start:step:end]) translate([0, 0, count]) {
        tube(diameter, barb / tan(angle), [barb, 0]);
    }
}
