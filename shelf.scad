/*
  Shelf bracket based on Sierpinkski's triangle.

  This bracket is designed for use with 1.5" screws and a drill.
  In particular, the mounting holes are countersunk such that 1.5"
  screws will not stick through a ~0.5 in shelf when tightened.
  Also, the holes near the apex are diagonally countersunk so as
  to be accessible from the side. This means that you need to install
  pairs of brackets in opposite 'handed-ness' for maximum lateral
  stability.

*/

sidelength = 200;
thickness = 30;

screwlength = 38.1; // 1.5 inches in mm
screwhead = 5.5;
screwshaft = 2.5;   // penis.

module triangle(size=sidelength, height=1) {
  // extrudes a right triangle of given size and thickness
  linear_extrude(height=height, center=true)
  polygon(points = [[0, 0], [-size, 0], [0, -size]], paths = [[0, 1, 2]]);
}

module countersink() {
  // The thinner cylinder can be used to show how far your
  // screw will penetrate.
  union() {
    translate([0, 0, -screwlength])
      cylinder(r=screwhead, h=screwlength);
    #cylinder(r=screwshaft, h=screwlength);
  }
}

S = sidelength/2; // precompute this oft-used value
P = 10;            // padding for outer edges


translate([S/4, S/4, 0]) // viewing position
difference() {
  difference() {
    translate([-(S+P/2), -(S+P/2), 0])
      scale(-1)
      triangle(sidelength + P*2, 30);
    triangle(S, 50);
    translate([S/2, -S/2, 0])triangle(size=S/2, height=50);
    translate([-S/2, S/2, 0])triangle(size=S/2, height=50);
    translate([-S/2, -S/2, 0])triangle(size=S/2, height=50);
  }

  rotate(-90, [0, 1, 0])
    translate([0, S-15, S-15])
    countersink();

  rotate(90, [1, 0, 0])
    translate([S-15, 0, S-15])
    countersink();

  translate([-S+15, -S+30, -10])
    rotate(-65, [0, 1, 0])
    translate([0, 0, 5])
    countersink();

  translate([-S+30, -S+15, -10])
    rotate(65, [1, 0, 0])
    translate([0, 0, 5])
    countersink();
}
