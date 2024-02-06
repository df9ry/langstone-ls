
// Resolution for milling:
$fa            = 1;    // Minimum angle
$fs            = 0.1;  // Minimum size
delta          = 0.001;

ls_d           = 65.00; // Diameter of loudspeaker
ls_hole_d      =  4.25; // Diameter of screw holes
ls_hole_delta  = 52.00; // Length between screw holes
ls_alpha       =  0.80; // Thickness of loudspeaker base

case_thickness =  2.00; // Thickness of material for case
case_rounding  = 10.00; // Rounding of case
case_h         = 27.00; // Inner height of case
case_size      = ls_d + 2 * case_thickness;

cable_d        = 2.50;
cable_offset   = 5.00;

// Delta für die Schraubenlöcher:
module schraubenloecher_plot() {
    xy0 = ls_hole_delta / 2;
    
    translate([ xy0,  xy0])
        circle(d = ls_hole_d);
    translate([ xy0, -xy0])
        circle(d = ls_hole_d);
    translate([-xy0,  xy0])
        circle(d = ls_hole_d);
    translate([-xy0, -xy0])
        circle(d = ls_hole_d);    
}

// 2D Plot des kabeldurchlasses:
module kabel_plot() {
    translate([0, case_size / 2 - cable_offset])
        circle(d = cable_d);
}

// 2D Plot des Gehäuseäußeren:
module base1_plot() {
    xy0 = (case_size - case_rounding) / 2 + case_thickness;

    difference() {
        hull() { 
            translate([ xy0,  xy0])
                circle(d = case_rounding);
            translate([ xy0, -xy0])
                circle(d = case_rounding);
            translate([-xy0,  xy0])
                circle(d = case_rounding);
            translate([-xy0, -xy0])
                circle(d = case_rounding);
        }
        ;
        union() {
            schraubenloecher_plot();
            kabel_plot();
        }
    }
}

// 2D Plot des Gehäuseinneren ohne Löcher:
module base2_plot() {
    size = case_size - 2 * case_thickness;
    xy0 = (size - case_rounding) / 2;
    
    difference() {
        base1_plot();
        hull() { 
            translate([ xy0,  xy0])
                circle(d = case_rounding);
            translate([ xy0, -xy0])
                circle(d = case_rounding);
            translate([-xy0,  xy0])
                circle(d = case_rounding);
            translate([-xy0, -xy0])
                circle(d = case_rounding);
        }
    }
}

module schraubenhuelsen_plot() {
    xy0 = ls_hole_delta / 2;
    
    difference() {
        union() {
            translate([ xy0,  xy0])
                circle(d = ls_hole_d + 2 * case_thickness);
            translate([ xy0, -xy0])
                circle(d = ls_hole_d + 2 * case_thickness);
            translate([-xy0,  xy0])
                circle(d = ls_hole_d + 2 * case_thickness);
            translate([-xy0, -xy0])
                circle(d = ls_hole_d + 2 * case_thickness);    
        }
        schraubenloecher_plot();
    }
}

