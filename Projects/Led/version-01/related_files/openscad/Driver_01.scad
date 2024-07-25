include <Driver_01.lib>
Convexity = 3;
board_h = 1.500;

// Drawing control
E = 1;
enable_draw_board_outline = E;
enable_draw_holes         = E;
enable_draw_pads          = E;
enable_draw_R0402         = E;
enable_draw_Pad2x2        = E;
enable_draw_CD54          = E;
enable_draw_MSOP_8T       = E;
enable_draw_SMTDIODE      = E;
enable_draw_C0402         = E;
enable_draw_CC0805        = E; 
enable_draw_Package       = 0; // was added to the PCB  
enable_draw_Shield        = 0; // was added to the PCB 


// MODE
MODE = 1;
// 1 - 3D view
// 2 - projection (top)
// 3 - projection (right)
// 4 - projection with mt.holes (right)

if( MODE == 1 )
    OBJ();
else if( MODE == 2 )
    projection(true)
    translate([0,0,-3.89])
    OBJ();
else if( MODE == 3 || MODE == 4 )
    projection(MODE==3?false:true)
    difference()
    {
        rotate([90,0,0])
        OBJ();
        translate([0,0,-30.5])
        cube(50, center=true);
        translate([0,0,30.5])
        cube(50, center=true);
    }

module OBJ() difference()
{
    union()
    {
        translate([0,0,-2])
        Pcb_Driver_01 ();
        rotate([180,0,0])
        Draw_Package ();
    }
    //translate([0,12,-6.1])
    //rotate([180,0,0])
    //Draw_Shield ();
    translate([0,-7.1,-14])
    rotate([90,0,0])
    Draw_Shield ();
}  
                 