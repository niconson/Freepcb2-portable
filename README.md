# Freepcb2-portable

*** 


FreePCB is a free, open-source PCB editor for Microsoft Windows, released under the GNU General Public License. It was designed to be easy to learn and easy to use, yet capable of professional-quality work.

![PCB](https://github.com/Duxah/FreePCB-2/blob/master/pictures/Driver.png)

The latest version 2.4, presented on this site, includes a lightweight generator of simple building objects for the OpenSCAD modeling environment, which now allows you to view the printed circuit board in 3D.

![PCB](https://github.com/Duxah/FreePCB-2/blob/master/pictures/3D.png)

In Freepcb2.4, a 3D part object is created by extruding a figure from a simple polyline drawn in the part footprint editor, but the polyline must be closed, that is, be a contour. Setting the extrusion parameters is carried out through a dialog box called up from the right-click menu on the selected polyline segment.

![PCB](https://github.com/Duxah/FreePCB-2/blob/master/pictures/scad_dlg.png)

The units of measurement used here are those that were set for the entire project in the main program window (before entering the footprint editor). This dialog box contains the values ​​of extrusion, rotation along the axes, and then movement along the axes in space. Please note that the broadcast occurs in the following order:

1) extrusion
2) rotation
3) moving
4) matrix
5) global procedures. These are procedures that are applied simultaneously to all 3D objects in the current footprint so that you can rotate and lift up the finished model along the Z axis. Global procedures do not move the finished model along the X and Y axes, since the program automatically calculates the geometric center of the finished model, consisting from one or many extrusion polylines and places it in place of the centroid. Therefore, no matter where these polyline sketches are located, the object will still end up at the location of the centroid. Thus, you can always freely move the origin of coordinates in the footprint and this will not affect the position of the 3D model in any way (the position of the 3D model can be changed by moving the centroid).

Now, to see what happened, you need to, in the mode when nothing is selected, press the right-click menu and select `Generate OpenSCAD data`. The program will create 3D `.scad` files in the project folder (\related_files\openscad) and open them through OpenSCAD (OpenSCAD must be installed independently, I recommend the 2024 developer version with the ability to switch to the `Manifold` library in the parameters in the `Functions` tab)

![PCB](https://github.com/Duxah/FreePCB-2/blob/master/pictures/scad_1.png)

This was a review of a single PCB part. Now, to view the entire printed circuit board in 3D, exit the footprint editor and in the main window, in the VIEW menu, select `Switch to 3D-model`

[View previous versions on GitHub](https://github.com/Duxah/FreePCB-2)

Contacts: 
- [snapchat](https://www.snapchat.com/add/niconson.com)
- [telegram](https://www.t.me/niconson) 
