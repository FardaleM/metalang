<?php
$stdin='';
function stdin_(){
  global $stdin;
  if ( !feof(STDIN)) $stdin.=fgets(STDIN)."\n";
}
function scan($format){
  stdin_();
  global $stdin;
  $out = sscanf($stdin, $format);
  $stdin = substr($stdin, strlen($out[0]));
  return $out;
}
function scantrim(){
  global $stdin;
  while(true){
    $stdin = ltrim($stdin);
    if ($stdin != '' || feof(STDIN)) break;
    stdin_();
  }
}
//  lit un sudoku sur l'entrée standard 

function &read_sudoku() {
    $out0 = array();
    for ($i = 0; $i < 9 * 9; $i++)
    {
        list($k) = scan("%d");
        scantrim();
        $out0[$i] = $k;
    }
    return $out0;
}

//  affiche un sudoku 

function print_sudoku(&$sudoku0) {
    for ($y = 0; $y < 9; $y++)
    {
        for ($x = 0; $x < 9; $x++)
        {
            echo $sudoku0[$x + $y * 9], " ";
            if ($x % 3 == 2)
                echo " ";
        }
        echo "\n";
        if ($y % 3 == 2)
            echo "\n";
    }
    echo "\n";
}

//  dit si les variables sont toutes différentes 

//  dit si les variables sont toutes différentes 

//  dit si le sudoku est terminé de remplir 

function sudoku_done(&$s) {
    for ($i = 0; $i < 81; $i++)
        if ($s[$i] == 0)
            return false;
    return true;
}

//  dit si il y a une erreur dans le sudoku 

function sudoku_error(&$s) {
    $out1 = false;
    for ($x = 0; $x < 9; $x++)
        $out1 = $out1 || $s[$x] != 0 && $s[$x] == $s[$x + 9] || $s[$x] != 0 && $s[$x] == $s[$x + 9 * 2] || $s[$x + 9] != 0 && $s[$x + 9] == $s[$x + 9 * 2] || $s[$x] != 0 && $s[$x] == $s[$x + 9 * 3] || $s[$x + 9] != 0 && $s[$x + 9] == $s[$x + 9 * 3] || $s[$x + 9 * 2] != 0 && $s[$x + 9 * 2] == $s[$x + 9 * 3] || $s[$x] != 0 && $s[$x] == $s[$x + 9 * 4] || $s[$x + 9] != 0 && $s[$x + 9] == $s[$x + 9 * 4] || $s[$x + 9 * 2] != 0 && $s[$x + 9 * 2] == $s[$x + 9 * 4] || $s[$x + 9 * 3] != 0 && $s[$x + 9 * 3] == $s[$x + 9 * 4] || $s[$x] != 0 && $s[$x] == $s[$x + 9 * 5] || $s[$x + 9] != 0 && $s[$x + 9] == $s[$x + 9 * 5] || $s[$x + 9 * 2] != 0 && $s[$x + 9 * 2] == $s[$x + 9 * 5] || $s[$x + 9 * 3] != 0 && $s[$x + 9 * 3] == $s[$x + 9 * 5] || $s[$x + 9 * 4] != 0 && $s[$x + 9 * 4] == $s[$x + 9 * 5] || $s[$x] != 0 && $s[$x] == $s[$x + 9 * 6] || $s[$x + 9] != 0 && $s[$x + 9] == $s[$x + 9 * 6] || $s[$x + 9 * 2] != 0 && $s[$x + 9 * 2] == $s[$x + 9 * 6] || $s[$x + 9 * 3] != 0 && $s[$x + 9 * 3] == $s[$x + 9 * 6] || $s[$x + 9 * 4] != 0 && $s[$x + 9 * 4] == $s[$x + 9 * 6] || $s[$x + 9 * 5] != 0 && $s[$x + 9 * 5] == $s[$x + 9 * 6] || $s[$x] != 0 && $s[$x] == $s[$x + 9 * 7] || $s[$x + 9] != 0 && $s[$x + 9] == $s[$x + 9 * 7] || $s[$x + 9 * 2] != 0 && $s[$x + 9 * 2] == $s[$x + 9 * 7] || $s[$x + 9 * 3] != 0 && $s[$x + 9 * 3] == $s[$x + 9 * 7] || $s[$x + 9 * 4] != 0 && $s[$x + 9 * 4] == $s[$x + 9 * 7] || $s[$x + 9 * 5] != 0 && $s[$x + 9 * 5] == $s[$x + 9 * 7] || $s[$x + 9 * 6] != 0 && $s[$x + 9 * 6] == $s[$x + 9 * 7] || $s[$x] != 0 && $s[$x] == $s[$x + 9 * 8] || $s[$x + 9] != 0 && $s[$x + 9] == $s[$x + 9 * 8] || $s[$x + 9 * 2] != 0 && $s[$x + 9 * 2] == $s[$x + 9 * 8] || $s[$x + 9 * 3] != 0 && $s[$x + 9 * 3] == $s[$x + 9 * 8] || $s[$x + 9 * 4] != 0 && $s[$x + 9 * 4] == $s[$x + 9 * 8] || $s[$x + 9 * 5] != 0 && $s[$x + 9 * 5] == $s[$x + 9 * 8] || $s[$x + 9 * 6] != 0 && $s[$x + 9 * 6] == $s[$x + 9 * 8] || $s[$x + 9 * 7] != 0 && $s[$x + 9 * 7] == $s[$x + 9 * 8];
    $out2 = false;
    for ($x = 0; $x < 9; $x++)
        $out2 = $out2 || $s[$x * 9] != 0 && $s[$x * 9] == $s[$x * 9 + 1] || $s[$x * 9] != 0 && $s[$x * 9] == $s[$x * 9 + 2] || $s[$x * 9 + 1] != 0 && $s[$x * 9 + 1] == $s[$x * 9 + 2] || $s[$x * 9] != 0 && $s[$x * 9] == $s[$x * 9 + 3] || $s[$x * 9 + 1] != 0 && $s[$x * 9 + 1] == $s[$x * 9 + 3] || $s[$x * 9 + 2] != 0 && $s[$x * 9 + 2] == $s[$x * 9 + 3] || $s[$x * 9] != 0 && $s[$x * 9] == $s[$x * 9 + 4] || $s[$x * 9 + 1] != 0 && $s[$x * 9 + 1] == $s[$x * 9 + 4] || $s[$x * 9 + 2] != 0 && $s[$x * 9 + 2] == $s[$x * 9 + 4] || $s[$x * 9 + 3] != 0 && $s[$x * 9 + 3] == $s[$x * 9 + 4] || $s[$x * 9] != 0 && $s[$x * 9] == $s[$x * 9 + 5] || $s[$x * 9 + 1] != 0 && $s[$x * 9 + 1] == $s[$x * 9 + 5] || $s[$x * 9 + 2] != 0 && $s[$x * 9 + 2] == $s[$x * 9 + 5] || $s[$x * 9 + 3] != 0 && $s[$x * 9 + 3] == $s[$x * 9 + 5] || $s[$x * 9 + 4] != 0 && $s[$x * 9 + 4] == $s[$x * 9 + 5] || $s[$x * 9] != 0 && $s[$x * 9] == $s[$x * 9 + 6] || $s[$x * 9 + 1] != 0 && $s[$x * 9 + 1] == $s[$x * 9 + 6] || $s[$x * 9 + 2] != 0 && $s[$x * 9 + 2] == $s[$x * 9 + 6] || $s[$x * 9 + 3] != 0 && $s[$x * 9 + 3] == $s[$x * 9 + 6] || $s[$x * 9 + 4] != 0 && $s[$x * 9 + 4] == $s[$x * 9 + 6] || $s[$x * 9 + 5] != 0 && $s[$x * 9 + 5] == $s[$x * 9 + 6] || $s[$x * 9] != 0 && $s[$x * 9] == $s[$x * 9 + 7] || $s[$x * 9 + 1] != 0 && $s[$x * 9 + 1] == $s[$x * 9 + 7] || $s[$x * 9 + 2] != 0 && $s[$x * 9 + 2] == $s[$x * 9 + 7] || $s[$x * 9 + 3] != 0 && $s[$x * 9 + 3] == $s[$x * 9 + 7] || $s[$x * 9 + 4] != 0 && $s[$x * 9 + 4] == $s[$x * 9 + 7] || $s[$x * 9 + 5] != 0 && $s[$x * 9 + 5] == $s[$x * 9 + 7] || $s[$x * 9 + 6] != 0 && $s[$x * 9 + 6] == $s[$x * 9 + 7] || $s[$x * 9] != 0 && $s[$x * 9] == $s[$x * 9 + 8] || $s[$x * 9 + 1] != 0 && $s[$x * 9 + 1] == $s[$x * 9 + 8] || $s[$x * 9 + 2] != 0 && $s[$x * 9 + 2] == $s[$x * 9 + 8] || $s[$x * 9 + 3] != 0 && $s[$x * 9 + 3] == $s[$x * 9 + 8] || $s[$x * 9 + 4] != 0 && $s[$x * 9 + 4] == $s[$x * 9 + 8] || $s[$x * 9 + 5] != 0 && $s[$x * 9 + 5] == $s[$x * 9 + 8] || $s[$x * 9 + 6] != 0 && $s[$x * 9 + 6] == $s[$x * 9 + 8] || $s[$x * 9 + 7] != 0 && $s[$x * 9 + 7] == $s[$x * 9 + 8];
    $out3 = false;
    for ($x = 0; $x < 9; $x++)
        $out3 = $out3 || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3] == $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 1] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3] == $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 2] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 1] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 1] == $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 2] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3] == $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 1] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 1] == $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 2] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 2] == $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3] == $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 1] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 1] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 1] == $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 1] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 2] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 2] == $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 1] || $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3] != 0 && $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3] == $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 1] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3] == $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 2] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 1] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 1] == $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 2] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 2] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 2] == $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 2] || $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3] != 0 && $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3] == $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 2] || $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 1] != 0 && $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 1] == $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 2] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 1] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 1] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 2] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 2] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3] || $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3] != 0 && $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3] || $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 1] != 0 && $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 1] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3] || $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 2] != 0 && $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 2] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3 + 1] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 1] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 1] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3 + 1] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 2] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 2] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3 + 1] || $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3] != 0 && $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3 + 1] || $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 1] != 0 && $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 1] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3 + 1] || $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 2] != 0 && $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 2] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3 + 1] || $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3] != 0 && $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3 + 1] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3 + 2] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 1] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 1] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3 + 2] || $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 2] != 0 && $s[($x % 3) * 3 * 9 + intval($x / 3) * 3 + 2] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3 + 2] || $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3] != 0 && $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3 + 2] || $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 1] != 0 && $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 1] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3 + 2] || $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 2] != 0 && $s[(($x % 3) * 3 + 1) * 9 + intval($x / 3) * 3 + 2] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3 + 2] || $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3] != 0 && $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3 + 2] || $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3 + 1] != 0 && $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3 + 1] == $s[(($x % 3) * 3 + 2) * 9 + intval($x / 3) * 3 + 2];
    return $out1 || $out2 || $out3;
}

//  résout le sudoku

function solve(&$sudoku0) {
    if (sudoku_error($sudoku0))
        return false;
    if (sudoku_done($sudoku0))
        return true;
    for ($i = 0; $i < 81; $i++)
        if ($sudoku0[$i] == 0)
        {
            for ($p = 1; $p < 10; $p++)
            {
                $sudoku0[$i] = $p;
                if (solve($sudoku0))
                    return true;
            }
            $sudoku0[$i] = 0;
            return false;
        }
    return false;
}
$sudoku0 = read_sudoku();
print_sudoku($sudoku0);
if (solve($sudoku0))
    print_sudoku($sudoku0);
else
    echo "no solution\n";

