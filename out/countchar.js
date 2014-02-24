
var util = require("util");
var fs = require("fs");
var current_char = null;
var read_char0 = function(){
    return fs.readSync(process.stdin.fd, 1)[0];
}
var read_char_ = function(){
    if (current_char == null) current_char = read_char0();
    var out = current_char;
    current_char = read_char0();
    return out;
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


function nth(tab, tofind, len){
  var out_ = 0;
  for (var i = 0 ; i <= len - 1; i++)
    if (tab[i] == tofind)
    out_ ++;
  return out_;
}

var len = 0;
len=read_int_();
stdinsep();
var tofind = '\000';
tofind=read_char_();
stdinsep();
var tab = new Array(len);
for (var i = 0 ; i <= len - 1; i++)
{
  var tmp = '\000';
  tmp=read_char_();
  tab[i] = tmp;
}
var result = nth(tab, tofind, len);
util.print(result);


