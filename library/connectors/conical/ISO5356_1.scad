/*
 * Module: ISO 5356-1 conical connectors for respiratory equipment.
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
module ISO5356_1(diameter=22, length=25, wall=1, type="male") {
    /// Creates ISO 5356-1 conical connectors for respiratory equipment.
    ///
    /// ## Arguments
    /// * `diameter`: standard diameter.
    /// * `length`: total length.
    /// * `wall`: wall thickness.
    /// * `type`: gender of the connector.
    ///
    /// ## Examples
    /// ```
    /// ISO5356_1(diameter=22, length=25, wall=1, type="male");
    /// ISO5356_1(15, type="female");
    /// ```
    ///
    /// ## Sizes
    /// * 8.5 mm
    /// * 11.5 mm
    /// * 15 mm
    /// * 22 mm
    /// * 23 mm
    /// * 30 mm
    ///
    /// ## Uses
    /// * 8.5 mm and 11.5 mm: neonatal and paediatric breathing systems.
    /// * 15 mm and 22 mm: general use in breathing systems.
    /// * 23 mm: vaporizers; not for breathing systems.
    /// * 30 mm: anaesthetic gas scavenging systems.

    module connector(table) {
        base = (
            (type == "female")
            ? table[0] - table[5] * table[2]
            : table[0]
        );
        tip = (
            (type == "male")
            ? table[0] - table[5] * table[2]
            : table[0] + table[5] * (table[3] - table[1])
        );
        assert(
            length >= table[3],
            "tapered length must be equal or superior to the standard minimum"
        );
        assert(
            type == "female" ||
            tip - 2 * wall >= table[6],
            "wall thickness must not exceed the standard"
        );
        translate([0, 0, length - max(table[2], table[4])]) tube(
            wall=((type == "male") ? -wall : +wall),
            length=max(table[2], table[4]),
            diameter=[base, tip]
        );
        tube(
            wall=((type == "male") ? -wall : +wall),
            length=length - max(table[2], table[4]),
            diameter=base
        );
    }

    assert(type == "male" || type == "female");

    if(diameter == 8.5) {
        connector([8.45, 6, 6.4, 8.9, 8, 1 / 19, 6.25, 6.0]);
    } else if(diameter == 11.5) {
        connector([11.50, 10, 13.5, 16, 15, 1 / 40, 9.15, 6.85]);
    } else if(diameter == 15) {
        connector([15.47, 10, 16, 16, 14.5, 1 / 40, 12.5, 7.80]);
    } else if(diameter == 22) {
        connector([22.37, 15, 21, 21, 15, 1 / 40, 19.3, 9.75]);
    } else if(diameter == 23) {
        connector([23.175, 13, 18, 18, 15, 1 / 36, 20.25, 10]);
    } else if(diameter == 30) {
        connector([30.9, 14, 18, 18, 14, 1 / 20, 27.0, 12.0]);
    } else {
        assert(false, "unknown diameter");
    }
}
