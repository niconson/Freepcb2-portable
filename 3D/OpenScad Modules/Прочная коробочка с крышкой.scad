/* LICENSE 

This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) license
https://creativecommons.org/licenses/by-sa/4.0/legalcode  

Author: Christof Dornbierer, christof.dornbierer@gmail.com
Date: 02/19/2021
License: CC BY-SA 4.0

Tips: https://paypal.me/dornies    :-) 
*/


/* USAGE
ruggedBox(....);

Parameters
    length              --> outside length of box without ribs
    width               --> outside width of box without ribs
    height              --> outside height of box 
    fillet              --> fillet radius (default:4)
    shell               --> shell thickness (default: 3)
    rib                 --> rib thickness (default: 10)
    top=false           --> render top or bottom part of box
    clearance=0.3       --> clearance for joints (default: 0.3)
    fillHeight=0        --> fill box up to that height e.g. to allow cut outs (default: 0)

*/


$fn=64;

//outside length without ribs
outSideLength=55;

//outside width without ribs
outSideWidth=55;

//outside height
outSideHeight=50;

//shell thickness
shellThickness=3; // [3:9]

//rib thickness
ribThickness=10; // [6:20]

//fillet radius
filletRadius=4; // [4:20]

//show example
showExample=false;

//show example combined
showExampleCombined=1;


//calculated heights top split box
heiBottom=0.7*outSideHeight;
heiTop=outSideHeight-heiBottom;


//EXAMPLE
if(showExample){
    
         //bottom
        color([0.5,0.5,1])
        translate([0,outSideWidth+4*shellThickness,0])
        ruggedBox(length=outSideLength, width=outSideWidth, height=heiBottom, fillet=filletRadius, shell=shellThickness, rib=ribThickness, top=false, fillHeight=0);
    
        //top
        color([1,1,1])
        translate([0,2*outSideWidth+8*shellThickness,0])
        ruggedBox(length=outSideLength, width=outSideWidth, height=heiTop, fillet=filletRadius, shell=shellThickness, rib=ribThickness, top=true); 
    
}

if(showExampleCombined){
        //bottom
        color([0.5,0.5,1])
        ruggedBox(length=outSideLength, width=outSideWidth, height=heiBottom, fillet=filletRadius, shell=shellThickness, top=false, fillHeight=0);
    
        //top
        color([1,1,1])
        translate([-outSideLength/2-heiTop-shellThickness,0,outSideHeight+outSideLength/2-heiTop+shellThickness])
        rotate([0,270,180])
        ruggedBox(length=outSideLength, width=outSideWidth, height=heiTop, fillet=filletRadius, shell=shellThickness, top=true); 
}



//main module
module ruggedBox(length, width, height, fillet=4, shell=3, rib=10, top=false, clearance=0.3, fillHeight=0){
    union(){
        difference(){
            union(){
                translate([-length/2+fillet+shell, -width/2+fillet+shell,0])
                union(){
                    //lower part
                    minkowski()
                    {
                      cube([length-2*fillet-2*shell,width-2*fillet-2*shell,height-shell]);
                      cylinder(r1=fillet, r2=fillet+shell,h=shell);
                    }

                    //upper part
                    translate([0,0,height-2*shell])
                    minkowski()
                    {
                      cube([length-2*fillet-2*shell,width-2*fillet-2*shell,shell]);
                      cylinder(r1=fillet+shell, r2=fillet+2*shell,h=shell);
                    }
                   
                }
                //ribs
                oneRibY(length, width, height, fillet, shell, rib);
                mirror([1,0,0])oneRibY(length, width, height, fillet, shell, rib);
                oneRibX(length, width, height, fillet, shell, rib);
                mirror([0,1,0])oneRibX(length, width, height, fillet, shell, rib);
                
                //top rabbet
                if(top==true)topRabbet(length, width, height, fillet, shell);
            }

            //inside cut out
            translate([-length/2+fillet+shell, -width/2+fillet+shell,shell+fillHeight])
            minkowski()
            {
              cube([length-2*fillet-2*shell,width-2*fillet-2*shell,height-2*shell+0.1]);
              cylinder(r=fillet, h=shell);
            }
            
            //buttom rabbet cutout
            if(top==false)bottomRabbet(length, width, height, fillet, shell);
                
            //bottom hinge cutout
            if(top==false){
                translate([-length/2-shell,0,height])
                rotate([90,90,0])
                cylinder(d=2*shell+2*clearance, h=width-2*fillet+rib-8*shell+2*clearance, center=true);
                      
            }
            
            //top hinge cutout
            if(top==true){
                translate([-length/2-shell,0,height])
                rotate([90,90,0])
                cylinder(d=2*shell+2*clearance, h=width-2*fillet-rib-8*shell+2*clearance, center=true);
                translate([-length/2-shell,0,height])
                rotate([90,90,0])
                cylinder(d=shell+2*clearance, h=width-2*fillet-6*shell, center=true);
            }

        }

        //bottom hinge
        if(top==false){
            translate([-length/2-shell,0,height])
            rotate([90,90,0])
            cylinder(d=2*shell, h=width-2*fillet-rib-8*shell, center=true);
            
            translate([-length/2-shell,-(width-2*fillet-rib-8.2*shell)/2,height])
            sphere(d=shell);
            
            translate([-length/2-shell,(width-2*fillet-rib-8.2*shell)/2,height])
            sphere(d=shell);
            
            difference(){
                union(){
                    translate([-length/2-shell-0.1*shell,0,height-2.5*shell])
                    cube([1.8*shell,width-2*fillet-rib-8*shell,5*shell], center=true);
                    
                    translate([-length/2-shell,0,height-3*shell])
                    cube([2*shell,width-2*fillet-rib-8*shell,4*shell], center=true);
                }
                
                translate([-length/2-shell,0,height-5*shell])
                rotate([0,-45,0])
                cube([2*shell,width,10*shell], center=true);
            }
        }
        
        //top hinge
        if(top==true){  
            topHingeSide(length, width, height, fillet, shell, clearance, rib);
            mirror([0,1,0])topHingeSide(length, width, height, fillet, shell, clearance, rib);
        }
        
        //top snap lid
        if(top==true){  
            difference(){
                union(){
                    translate([length/2+1.5*shell,0,height])
                    cube([shell,width-2*fillet-rib-8*shell-clearance,6*shell], center=true);
                    
                    translate([length/2+0.5*shell,0,height-2*shell])
                    cube([shell,width-2*fillet-rib-8*shell,4*shell], center=true);
                    
                    translate([length/2+1.1*shell,0,height+1.5*shell+2*clearance])
                    rotate([90,90,0])
                    cylinder(d=shell, h=width-2*fillet-rib-8*shell-clearance, center=true);
                }
                
                translate([length/2+shell,0,height-4*shell])
                rotate([0,45,0])
                cube([2*shell,width,10*shell], center=true);
                
                translate([length/2+shell,(width-2*fillet-rib-8*shell)/2,height+4*shell])
                rotate([45,0,0])
                cube([10*shell,3*shell,10*shell], center=true);
                
                translate([length/2+shell,-(width-2*fillet-rib-8*shell)/2,height+4*shell])
                rotate([-45,0,0])
                cube([10*shell,3*shell,10*shell], center=true);

                  
                translate([length/2+shell,0,height+4.8*shell])
                rotate([0,45,0])
                cube([3*shell,width,10*shell], center=true);
            }

        }
    } 
}


//helper module for top hinge
module topHingeSide(length, width, height, fillet, shell, clearance,rib){
        difference(){
            union(){
                translate([-length/2-shell,(width/2-fillet-4*shell+0.5*clearance),height])
                rotate([90,90,0])
                cylinder(d=2*shell, h=rib-clearance, center=true);
                
                translate([-length/2-shell,(width/2-fillet-4*shell+0.5*clearance),height-2*shell])
                cube([2*shell,rib-clearance,4*shell], center=true);
                
            }
            
            translate([-length/2-shell,(width-2*fillet-rib-8*shell)/2,height])
            sphere(d=shell);
            
            translate([-length/2-shell,(width-2*fillet-rib-8.3*shell+clearance)/2,height])
            rotate([0,-90,0])cylinder(h=shell+0.1, d=shell);
                                            
            translate([-length/2-shell,0,height-4*shell])
            rotate([0,-45,0])
            cube([2*shell,width,10*shell], center=true);
        }

}

//helper module for bottom rabbet
module bottomRabbet(length, width, height, fillet, shell){
    translate([-length/2+fillet+shell, -width/2+fillet+shell,height-shell/8*7])
    difference(){
        minkowski()
        {
            cube([length-2*fillet-2*shell,width-2*fillet-2*shell,shell/3*2]);
            cylinder(r1=fillet+1.1*shell, r2=fillet+1.5*shell, h=shell/3);
        }
        minkowski()
        {
            cube([length-2*fillet-2*shell,width-2*fillet-2*shell,0.001]);
            cylinder(r1=fillet+0.9*shell,r2=fillet+0.5*shell, h=shell/3);
        }
        minkowski()
        {
            cube([length-2*fillet-2*shell,width-2*fillet-2*shell,shell/2+0.001]);
            cylinder(r=fillet+0.5*shell, h=shell/2);
        }
    }
}

//helper module for top rabbet
module topRabbet(length, width, height, fillet, shell){
    translate([-length/2+fillet+shell, -width/2+fillet+shell,height])
    difference(){
        minkowski()
        {
            cube([length-2*fillet-2*shell,width-2*fillet-2*shell,0.001]);
            cylinder(r1=fillet+1.5*shell,r2=fillet+1.1*shell, h=shell/2);
        }
        minkowski()
        {
            translate([0,0,-0.001])cube([length-2*fillet-2*shell,width-2*fillet-2*shell,0.105]);
            cylinder(r1=fillet+0.5*shell,r2=fillet+0.9*shell, h=shell/2);
        }
    }
}

//helper module for ribs
module oneRibY(length, width, height, fillet, shell, rib){
    intersection(){
        translate([-length/2+fillet+shell, -width/2+fillet+shell,0])
        minkowski()
        {
          cube([length-2*fillet-2*shell,width-2*fillet-2*shell,height-shell]);
          cylinder(r1=fillet+shell, r2=fillet+2*shell,h=shell);
        }

        translate([length/2-fillet-4*shell,0,1])
        cube([rib, 2*width, 2*height], center=true);
    }
}

//helper module for ribs
module oneRibX(length, width, height, fillet, shell, rib){
    intersection(){
        translate([-length/2+fillet+shell, -width/2+fillet+shell,0])
        minkowski()
        {
          cube([length-2*fillet-2*shell,width-2*fillet-2*shell,height-shell]);
          cylinder(r1=fillet+shell, r2=fillet+2*shell,h=shell);
        }

        translate([0,width/2-fillet-4*shell,1])
        cube([2*length, rib, 2*height], center=true);
    }
}







