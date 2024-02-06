include <base.scad>

height   =  2.50;
n_holes  = 32;
hole_fac =  0.70; // 0..1
d_hole   = ls_d / n_holes * hole_fac;

module part3_base() {
    xy0 = (case_size - case_rounding) / 2 + case_thickness;

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

module holes_plot(d, n) {
    step = 2 / n;
    
    for (y_stroke = [-1: step: +1]) {
        a = asin(y_stroke);
        y = y_stroke * d / 2; 
        
        for (x_stroke = [-1: step: +1]) {
           x_stroke_max = abs(cos(a));
           x_stroke_min = -x_stroke_max;
            
           if ((x_stroke > x_stroke_min) && 
               (x_stroke < x_stroke_max))
           { 
                translate([x_stroke * d / 2, y])
                    circle(d = d_hole);
                    //square(size = d_hole, center = true);
           }
        }
    } 
}

module schraube_diff() {
    d1  = 3.25;
    d2  = 6.00;
    h1  = height / 3 * 2;
    h2  = height / 3;

    translate([0, 0, -delta])
        cylinder(h = h1 + delta, d = d1);
    translate([0, 0, h1 - delta])
        cylinder(h = h2 + 3*delta, d = d2);
}

module schrauben_diff() {
    xy0 = ls_hole_delta / 2;
    
    translate([ xy0,  xy0, -delta]) schraube_diff();
    translate([ xy0, -xy0, -delta]) schraube_diff();
    translate([-xy0,  xy0, -delta]) schraube_diff();
    translate([-xy0, -xy0, -delta]) schraube_diff();
}

module holes_diff(d, n) {
    translate([0, 0, -delta])
        linear_extrude(height + 2*delta)
            holes_plot(d, n);
    schrauben_diff();
}

module part3() {
    scale = ls_d / case_size;
    
    difference() {
        linear_extrude(height, scale = scale) part3_base();
        holes_diff(ls_d, n_holes);
    }
}

//print();
part3();