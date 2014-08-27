var util = require("util");
var fs = require("fs");
var current_char = null;
var read_char0 = function(){
    return fs.readSync(process.stdin.fd, 1)[0];
}
var stdinsep = function(){
    if (current_char == null) current_char = read_char0();
    while (current_char == '\n' || current_char == ' ' || current_char == '\t')
        current_char = read_char0();
}
var read_int_ = function(){
    if (current_char == null) current_char = read_char0();
    var sign = 1;
    if (current_char == '-'){
        current_char = read_char0();
        sign = -1;
    }
    var out = 0;
    while (true){
        if (current_char.charCodeAt(0) >= '0'.charCodeAt(0) && current_char.charCodeAt(0) <= '9'.charCodeAt(0)){
            out = out * 10 + current_char.charCodeAt(0) - '0'.charCodeAt(0);
            current_char = read_char0();
        }else{
            return out * sign;
        }
    }
}
function devine_(nombre, tab, len){
  var min_ = tab[0];
  var max_ = tab[1];
  for (var i = 2 ; i <= len - 1; i++)
  {
    if (tab[i] > max_ || tab[i] < min_)
      return 0;
    if (tab[i] < nombre)
      min_ = tab[i];
    if (tab[i] > nombre)
      max_ = tab[i];
    if (tab[i] == nombre && len != i + 1)
      return 0;
  }
  return 1;
}

nombre=read_int_();
stdinsep();
len=read_int_();
stdinsep();
var tab = new Array(len);
for (var i = 0 ; i <= len - 1; i++)
{
  tmp=read_int_();
  stdinsep();
  tab[i] = tmp;
}
var a = devine_(nombre, tab, len);
if (a)
  util.print("True");
else
  util.print("False");

