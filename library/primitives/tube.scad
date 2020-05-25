/*
 * Module: parametric tube / tapered tube.
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

module tube(diameter, length, wall) {
    /// Creates a tube or a tapered tube.
    ///
    /// ## Arguments
    /// * `diameter`: tube diameter(s).
    /// * `length`: total tube length.
    /// * `wall`: wall thickness(es).
    ///
    /// Notes: `wall` and `thickness` can take a single numerical value
    /// or two separate values inside a vector (one for each end); the
    /// sign of `wall` will determine its placement (inside/outside).
    ///
    /// ## Examples
    /// ```
    /// // Diameters: outer = 6; inner = 4
    /// tube(diameter=4, length=16, wall=1)
    ///
    /// // Diameters: outer = [4, 8]; inner = [2, 6]
    /// tube(diameter=[4, 8], length=16, wall=-1)
    ///
    /// // Diameters: outer = [6, 12]; inner = [4, 8]
    /// tube(diameter=[4, 8], length=16, wall=[1, 2])
    /// ```

    // Get value from number or vector
    function get(variable, position=0) =
        (variable[position] == undef) ? variable : variable[position];

    // Thickness correction for tapered tubes
    slope = abs(get(diameter, 0) - get(diameter, 1)) / 2;
    secant = sqrt(pow(slope, 2) + pow(length, 2)) / length;

    // Wall thicknesses
    wall_a = secant * get(wall, 0);
    wall_b = secant * get(wall, 1);

    // Tube diameter
    diameter_a = get(diameter, 0) + 2 * max(0, wall_a);
    diameter_b = get(diameter, 1) + 2 * max(0, wall_b);

    assert(
        length > 0,
        "tube length must be greater than zero"
    );
    assert(
        (sign(wall_a) || 1) == (sign(wall_b) || 1),
        "walls must be on the same side"
    );
    assert(
        abs(wall_a + wall_b) > 0,
        "wall thickness must not be zero"
    );
    assert(
        diameter_a - 2 * abs(wall_a) >= 0 &&
        diameter_b - 2 * abs(wall_b) >= 0,
        "there must be enough room for the walls"
    );
    assert(
        diameter_b + diameter_a > 0,
        "diameter must not be zero"
    );

    difference() {
        cylinder(
            h=length,
            r1=diameter_a / 2,
            r2=diameter_b / 2
        );
        translate([0,0,-0.1]) {
            cylinder(
                h=length + 0.2,
                r1=diameter_a / 2 - abs(wall_a),
                r2=diameter_b / 2 - abs(wall_b)
            );
        }
        
    }
}
