$fn=30;


module tube(diameter, length, wall) {
    slope = (diameter[0] == undef) ? 0 : abs(diameter[0] - diameter[1]) / 2;
    secant = sqrt(pow(slope, 2) + pow(length, 2)) / length;
    difference() {
        cylinder(
            h=length,
            r1=((diameter[0] == undef) ? diameter : diameter[0]) / 2,
            r2=((diameter[0] == undef) ? diameter : diameter[1]) / 2
        );
        cylinder(
            h=length,
            r1=((diameter[0] == undef) ? diameter : diameter[0]) / 2
                - secant * ((wall[0] == undef) ? wall : wall[0]),
            r2=((diameter[0] == undef) ? diameter : diameter[1]) / 2
                - secant * ((wall[0] == undef) ? wall : wall[1])
        );
    }
}


module boussignac(
    outer_diameter=45,
    inner_diameter=15,
    connection_diameter=22,
    connection_length=20,
    input_tube=[5, 10],
    length=10,
    channel=0.4,
    angle=40,
    wall=1,
    ) {
    tube(
        connection_diameter,
        connection_length,
        (connection_diameter - inner_diameter) / 2
    );
    mirror([0, 0, 1]) {
        difference() {
            cylinder(r=outer_diameter / 2, h=length);
            cylinder(r=inner_diameter / 2, h=length);
            translate([0, 0, wall]) {
                tube(
                    wall=wall,
                    diameter=outer_diameter - 2 * wall,
                    length=length - 2 * wall
                );
            }
            translate([0, 0, length - 3 * wall]) {
                tube(
                    wall=2 * wall + channel,
                    diameter=outer_diameter - 2 * wall,
                    length=2 * wall
                );
            }
            translate([0, 0, length - (outer_diameter - 2 * wall) * tan(angle) / 4 - wall]) {
                tube(
                    diameter=[inner_diameter, outer_diameter - 2 * wall],
                    length=(outer_diameter - 2 * wall) * tan(angle) / 4,
                    wall=[channel, wall]
                );
            }
            translate([0, -outer_diameter / 2 + 2 * wall, length / 2]) {
                rotate([90, 0, 0]) {
                    tube(input_tube[0], 2 * wall, input_tube[0]);
                }
            } 
        }
        translate([0, -outer_diameter / 2 + wall, length / 2]) {
             rotate([90, 0, 0]) {
                tube(input_tube[0], input_tube[1] + wall, wall);
            }
        }
        for(support = [0:12:360]) {
            rotate([0, 0, support]) {
                translate([inner_diameter / 2 + wall, -wall, length - 3 * wall]) {
                    cube([(outer_diameter - inner_diameter) / 2 - 2 * wall, wall, 2 * wall + channel]);
                }
            }
        }
    }
}



boussignac();
