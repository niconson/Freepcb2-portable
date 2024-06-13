/*
nashkolxoz.ru
made by Predsedatel
r - радиус скругления;
fn - $fn;
*/
module mink(r, fn) {
  if (fn<41){
    for (i = [0 : $children-1]) {
      minkowski() { children(i); sphere(r, $fn=fn); };
    };
  };
};