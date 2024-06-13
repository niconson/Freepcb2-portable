/*
nashkolxoz.ru
made by Predsedatel
h1 высота шурупа
h2 высота шляпки
h3 высота прорези под шляпку
d1 диаметр резьбы
d2 диаметр шляпки 
*/
module screw(h1, h2, h3, d1, d2){
  union(){
    translate([0, 0, -0.5*(h1-h2)-h2+0.02]) cylinder((h1-h2), 0.5*d1, 0.5*d1, true, $fn=30);
    translate([0, 0, -0.5*h2+0.01]) cylinder(h2, 0.5*d1, 0.5*d2, true, $fn=40);
    translate([0, 0, 0.5*h3]) cylinder(h3, 0.5*d2, 0.5*d2, true, $fn=50);
  };
};