module radiusedblock(xlen,ylen,zlen,radius)
{
    hull()
    {
    translate([radius,radius,radius]) sphere(r=radius, $fn=20);
    translate([xlen + radius , radius , radius]) sphere(r=radius, $fn=20);
    translate([radius , ylen + radius , radius]) sphere(r=radius, $fn=20);    
    translate([xlen + radius , ylen + radius , radius]) sphere(r=radius, $fn=20);
    translate([radius , radius , zlen + radius]) sphere(r=radius, $fn=20);
    translate([xlen + radius , radius , zlen + radius]) sphere(r=radius, $fn=20);
    translate([radius,ylen + radius,zlen + radius]) sphere(r=radius, $fn=20);
    translate([xlen + radius,ylen + radius,zlen + radius]) sphere(r=radius, $fn=20);
    }
}

radiusedblock(10,10,10,1);