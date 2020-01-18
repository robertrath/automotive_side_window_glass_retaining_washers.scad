
// Automotive Side Window Glass Retaining Washers
//
// While replacing the passenger window regulator cable, I noticed I had
// damaged and lost some of the protective nylon clamp washers pairs.
// 
// This particular design has been dimensioned to suit Peugeot 307CC rear
// side windows. 

$fn=160;

THICKNESS                 =  2.0; // thickness of washer
GLASS_INSERSION_THICKNESS =  3.0; // glass insertion must be less than glass thickness
OUTER_DIAMETER            = 29.5; // outer dimension of the washers
COMPRESSION_DIAMETER      = 16.5; // a region to allow for washer flex when assembled
COMPRESSION_CLEARANCE     =  0.4; // the clearance to allow for washer flex whan assembled
SCREW_CLEARANCE           =  6.3; // needs to clear the bracket screw
GLASS_CLEARANCE_DIAMETER  =  9.0; // needs to clear the hole in the glass
SCREW_GRIP_INTRUSION      =  0.5; // Used to help the back brack washer grip the screw thread     

translate([-OUTER_DIAMETER/2-1,0,0]) font_nut_washer();
translate([ OUTER_DIAMETER/2+1,0,0]) back_bracket_washer();

module font_nut_washer()
{
  // The front nut washer is positioned onto the screw once the glass and
  // back bracket have beet brought together. The glass and bracket assembly
  // are then bolted onto the regulator assembly during reinstallation.  
  union()
  {
    difference()
    {
      cylinder(d=GLASS_CLEARANCE_DIAMETER,h=GLASS_INSERSION_THICKNESS+THICKNESS);
      cylinder(d=SCREW_CLEARANCE,h=GLASS_INSERSION_THICKNESS+THICKNESS);
    }  
    difference()
    {
      cylinder(d=OUTER_DIAMETER,h=THICKNESS-COMPRESSION_CLEARANCE);
      cylinder(d=SCREW_CLEARANCE,h=THICKNESS-COMPRESSION_CLEARANCE);
    }
    difference()
    {
      cylinder(d=OUTER_DIAMETER,h=THICKNESS);
      cylinder(d=COMPRESSION_DIAMETER,h=THICKNESS);
    }
  }
}  

module back_bracket_washer()
{
  // The back bracket washer is a screw/press interference fit to the back bracket
 //  screws and are designed to hold fast to the back bracket once positioned. 
  union()
  {
    difference()
    {
      cylinder(d=OUTER_DIAMETER, h=THICKNESS);
      cylinder(d=COMPRESSION_DIAMETER, h=THICKNESS);
    }
    difference()
    {
      cylinder(d=OUTER_DIAMETER,h=THICKNESS-COMPRESSION_CLEARANCE);
      cylinder(d=SCREW_CLEARANCE,h=THICKNESS);
    }
    // The interference stubs which help the washer grip the screw are
    // mostly well behaved but you may need to tune the
    // stub width and lenght factors accordingly for large dimensional changes.
    for (i = [0:120:240]) // create 3 interference stubs
    {
      STUB_LENGTH    = SCREW_GRIP_INTRUSION*2;    
      STUB_WIDTH     = SCREW_CLEARANCE/3;
      rotate(a = i, convexity=10)
      translate([SCREW_CLEARANCE/2-SCREW_GRIP_INTRUSION+STUB_LENGTH/2,0,THICKNESS/2-COMPRESSION_CLEARANCE/2])
      {
        cube([STUB_LENGTH,STUB_WIDTH,THICKNESS-COMPRESSION_CLEARANCE],true);
      }    
    }
  }    
}