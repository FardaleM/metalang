
function f(tuple_){
  var c = tuple_;
  var a = c.tuple_int_int_field_0;
  var b = c.tuple_int_int_field_1;
  var e = {
    tuple_int_int_field_0 : a + 1,
    tuple_int_int_field_1 : b + 1
  };
  return e;
}

var g = {
  tuple_int_int_field_0 : 0,
  tuple_int_int_field_1 : 1
};
var t = f(g);
var d = t;
var a = d.tuple_int_int_field_0;
var b = d.tuple_int_int_field_1;
util.print(a, " -- ", b, "--\n");

