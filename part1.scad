include <base.scad>

module part1_plot() {
    difference() {
        base1_plot();
        {
            schraubenloecher_plot();
            circle(d = ls_d);
        }
    }
}

module part1() {
    linear_extrude(case_thickness)
        part1_plot();
}

module print1() {
    part1();
}

print1();