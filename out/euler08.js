var util = require("util");
var fs = require("fs");
var current_char = null;
function read_char0(){
    var buf = Buffer.alloc(1);
    fs.readSync(process.stdin.fd, buf, 0, 1)[0];
    return buf.toString();
}
function read_char_(){
    if (current_char == null) current_char = read_char0();
    var out = current_char;
    current_char = read_char0();
    return out;
}
var i = 1;
var last = new Array(5);
for (var j = 0; j < 5; j++)
{
    var c = read_char_();
    var d = c.charCodeAt(0) - '0'.charCodeAt(0);
    i *= d;
    last[j] = d;
}
var max0 = i;
var index = 0;
var nskipdiv = 0;
for (var k = 1; k < 996; k++)
{
    var e = read_char_();
    var f = e.charCodeAt(0) - '0'.charCodeAt(0);
    if (f == 0)
    {
        i = 1;
        nskipdiv = 4;
    }
    else
    {
        i *= f;
        if (nskipdiv < 0)
            i = ~~(i / last[index]);
        nskipdiv--;
    }
    last[index] = f;
    index = ~~((index + 1) % 5);
    max0 = Math.max(max0, i);
}
util.print(max0, "\n");

