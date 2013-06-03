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
angle = 25;

shelfthickness = 12.7; // 0.5 in in mm

module triangle(size=sidelength, height=1) {
  // extrudes a right triangle of given size and thickness
  linear_extrude(height=height, center=true)
  polygon(points = [[0, 0], [size, 0], [0, size]], paths = [[0, 1, 2]]);
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
P = 5;            // padding for outer edges
E = screwlength - shelfthickness;


//translate([S/4, S/4, 0]) // viewing position
difference() {
  translate([S+P, S+P, 0])
    scale(-1)
    triangle(sidelength + P*4, thickness);

  triangle(S-P, 50);
  translate([S/2, -S/2, 0])  triangle(size=S/2-P, height=50);
  translate([-S/2, S/2, 0])  triangle(size=S/2-P, height=50);
  translate([S/2, S/2, 0]) triangle(size=S/2-P, height=50);

  rotate(90, [0, 1, 0])
    translate([0, -(S-20), S+5-E])
    countersink();

  rotate(-90, [1, 0, 0])
    translate([-(S-20), 0, S+5-E])
    countersink();


  rotate(90, [0, 1, 0])
    translate([0, (S-25), S+5])
    rotate(-angle, [0, 1, 0])
    translate([0, 0, -E*cos(angle)])
    countersink();

  rotate(-90, [1, 0, 0])
    translate([S-25, 0, S+5])
    rotate(angle, [1, 0, 0])
    translate([0, 0, -E*cos(angle)])
    countersink();

  translate([S/4, 0, 0])
  rotate(45, [0, 1, 0])
  cube(size=[15,250,15], center=true);
  translate([-(S/4+10), 0, 0])
  rotate(45, [0, 1, 0])
  cube(size=[15,250,15], center=true);
  translate([0, S/4, 0])
  rotate(45, [1, 0, 0])
  cube(size=[250,15,15], center=true);
  translate([0, -(S/4+10), 0])
  rotate(45, [1, 0, 0])
  cube(size=[250,15,15], center=true);

}
