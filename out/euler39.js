var util = require("util");
var t = new Array(1001);
for (var i = 0 ; i < 1001; i++)
  t[i] = 0;
for (var a = 1 ; a <= 1000; a++)
  for (var b = 1 ; b <= 1000; b++)
  {
      var c2 = a * a + b * b;
      var c = Math.floor(Math.sqrt(c2));
      if (c * c == c2)
      {
          var p = a + b + c;
          if (p <= 1000)
            t[p] = t[p] + 1;
      }
}
var j = 0;
for (var k = 1 ; k <= 1000; k++)
  if (t[k] > t[j])
  j = k;
util.print(j);

