include <base.scad>

module part2() {
    union() {
        union() {
            linear_extrude(case_h + delta)
                base2_plot();
            translate([0, 0, ls_alpha])
                linear_extrude(case_h - ls_alpha)
                    schraubenhuelsen_plot();
        }
        translate([0, 0, case_h]) {
            linear_extrude(case_thickness)
                base1_plot();
        }
    }
}

module print2() {
    translate([0, 0, case_h + case_thickness])
        rotate([180, 0, 0])
            part2();
}

print2();
