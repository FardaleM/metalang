<?php
function min3_($a, $b, $c){
  return min($a, $b, $c);
}

$e = 2;
$f = 3;
$g = 4;
$d = min($e, $f, $g);
echo $d, " ";
$i = 2;
$j = 4;
$k = 3;
$h = min($i, $j, $k);
echo $h, " ";
$m = 3;
$n = 2;
$o = 4;
$l = min($m, $n, $o);
echo $l, " ";
$q = 3;
$r = 4;
$s = 2;
$p = min($q, $r, $s);
echo $p, " ";
$u = 4;
$v = 2;
$w = 3;
$t = min($u, $v, $w);
echo $t, " ";
$y = 4;
$z = 3;
$ba = 2;
$x = min($y, $z, $ba);
echo $x, "\n";
?>
