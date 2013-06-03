/* Sierpinkski's shelf bracket */
s = 200;
thickness = 30;

module triangle(size=s,height=1) {
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
module slidehole() {
 union() {
   cylinder(r=2.5, h=20);
   translate([-2.5,0,0])cube(size=[5,5,20]);
   translate([0,10,0])cylinder(r=5.5, h=20);
 }
}
translate([s/2,s/2,0])
difference() {
  union() {
    difference() {
      union() {
        cube(size=[s+10,s+10,30],center=true);
        translate([10,0,0])cube(size=[s+10,s+10,30],center=true);
        translate([0,10,0])cube(size=[s+10,s+10,30],center=true);
      }
      translate([s/2+20,s/2+20,0])triangle(s+30, 50);
      rotate(180,[0,0,1])translate([s/2,s/2,0])triangle(s-0, 50);
      
    }

    difference() {
      cube(size=[s,s,thickness],center=true);
      translate([s/2+1,s/2+1,0])triangle(height=50);
      translate([0,0,0])triangle(size=s/2,height=50);
      translate([s/4,-s/4,0])triangle(size=s/4,height=50);
      translate([-s/4,s/4,0])triangle(size=s/4,height=50);
      translate([-s/4,-s/4,0])triangle(size=s/4,height=50);
    }
  }
  rotate(-90,[0,1,0])translate([0,s/2-15,s/2-15])scale(-1)countersink();
  rotate(90,[1,0,0])translate([s/2-15,0,s/2-15])scale(-1)countersink();

/*
  rotate(-90,[0,1,0])translate([0,-s/2+10,s/2-10])slidehole();
  rotate(90,[1,0,0])rotate(-90, [0,0,1])translate([0,-s/2+10,s/2-10])slidehole();
  */

  //rotate(-90,[0,1,0])translate([15,-s/2+31,s/2-35])rotate(-20,[0,1.0])countersink();
  //rotate(90,[1,0,0])translate([-s/2+35,15,s/2-31])rotate(20,[1,0.0])countersink();
  /*
  translate([-s/2+15,-s/2+15,-10])
    rotate(-70,[0,1,0])
    scale(-1)countersink();
  translate([-s/2+15,-s/2+15,10])
    rotate(-70,[1,0,0])
    countersink();
    */
  translate([-s/2+15,-s/2+30,-10])
    rotate(-65,[0,1,0])
  translate([0,0,5])
    scale(-1)countersink();
  translate([-s/2+30,-s/2+15,-10])
  rotate(65,[1,0,0])
  translate([0,0,5])
    scale(-1)
    countersink();
}
