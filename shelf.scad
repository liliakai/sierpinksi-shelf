/* Sierpinkski's shelf bracket */
sidelength = 200;
thickness = 30;
S = sidelength/2;

module triangle(size=sidelength, height=1) {
  // extrudes a right triangle of given size and thickness
  linear_extrude(height=height,center=true)
  polygon(points = [[0,0], [-size,0], [0,-size]],
          paths = [[0,1,2]]);
}

module countersink() {
 union() {
   cylinder(r=2.5, h=38.1*2, center=true);
   cylinder(r=5.5, h=38.1);
 }
}

translate([S/4,S/4,0]) difference() {
  union() {
    difference() {
      union() {
        cube(size=[sidelength+10,sidelength+10,30],center=true);

        translate([10,0,0])
          cube(size=[sidelength+10,sidelength+10,30],center=true);
        translate([0,10,0])
          cube(size=[sidelength+10,sidelength+10,30],center=true);
      }
      translate([S+20,S+20,0]) triangle(sidelength+30, 50);
      rotate(180,[0,0,1])translate([S,S,0])triangle(sidelength, 50);
    }

    difference() {
      cube(size=[sidelength,sidelength,thickness],center=true);
      translate([S+1,S+1,0])triangle(height=50);
      translate([0,0,0])triangle(size=S,height=50);
      translate([S/2,-S/2,0])triangle(size=S/2,height=50);
      translate([-S/2,S/2,0])triangle(size=S/2,height=50);
      translate([-S/2,-S/2,0])triangle(size=S/2,height=50);
    }
  }
  rotate(-90,[0,1,0])
    translate([0,S-15,S-15])
    scale(-1)
    countersink();

  rotate(90,[1,0,0])
    translate([S-15,0,S-15])
    scale(-1)
    countersink();

  translate([-S+15,-S+30,-10])
    rotate(-65,[0,1,0])
    translate([0,0,5])
    scale(-1)
    countersink();

  translate([-S+30,-S+15,-10])
    rotate(65,[1,0,0])
    translate([0,0,5])
    scale(-1)
    countersink();
}
