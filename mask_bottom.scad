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

module valve() {
  intersection(){
      georges(
          diameter=[15, 45],
          length=10,
          wall=1,
          barb=[5, 30, 0.66, 20],
          channel=0.4,
          angle=40
      );
      translate([0,0,10]) {
          mirror([0, 0, 1]) {
              ISO5356_1(diameter=15, type="female", wall=45);
          }
      }
  }

  union() {
      translate([0,0,10]) ISO5356_1(diameter=22, length=25, type="male");
      translate([0,0,10]) tube(diameter=21, length=25, wall=-2.9);
  }  
}



module mask_body() {
    union() {
      translate([-110,-101.9,34.99]) import("deps/MontanaMasks_top.stl");
      translate([0,0,35]) rotate([0,180,180]) linear_extrude(35, convexity=10, scale=[0.6,0.6]) import("deps/MontanaMasks_adaptor_slice.svg", center=true);  
    }
    
}

module sliced_mask() {
    difference() {
        mask_body();
        translate([0,0,-0.05]) cylinder(10, d=44.99);
        translate([0,0,-0.05]) cylinder(36, d=21.8);
        translate([0,-15,5]) rotate([90,0,0]) cylinder(35, d=4.9);
    }
}
sliced_mask();
valve();
// difference() {
    
//     translate([0,0,-0.05]) cylinder(10, d=44.99);
//     translate([0,0,-0.05]) cylinder(35, d=21.8);
//     translate([0,-15,5]) rotate([90,0,0]) cylinder(35, d=4.9);
// }

// translate([0,-15,5]) rotate([90,0,0]) cylinder(35, d=4.9);
