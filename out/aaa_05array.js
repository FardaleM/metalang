var util = require("util");
function id(b){
    return b;
}
function g(t, index){
    t[index] = false;
}
var j = 0;
var a = new Array(5);
for (var i = 0; i < 5; i++)
{
    util.print(i);
    j += i;
    a[i] = ~~(i % 2) == 0;
}
util.print(j, " ");
if (a[0])
    util.print("True");
else
    util.print("False");
util.print("\n");
g(id(a), 0);
if (a[0])
    util.print("True");
else
    util.print("False");
util.print("\n");

