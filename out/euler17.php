<?php
echo 3 + 16, "\n";
$one_to_nine = 3 + 33;
echo $one_to_nine, "\n";
$one_to_ten = $one_to_nine + 3;
$one_to_twenty = $one_to_ten + 73;
$one_to_thirty = $one_to_twenty + 6 * 9 + $one_to_nine + 6;
$one_to_forty = $one_to_thirty + 6 * 9 + $one_to_nine + 5;
$one_to_fifty = $one_to_forty + 5 * 9 + $one_to_nine + 5;
$one_to_sixty = $one_to_fifty + 5 * 9 + $one_to_nine + 5;
$one_to_seventy = $one_to_sixty + 5 * 9 + $one_to_nine + 7;
$one_to_eighty = $one_to_seventy + 7 * 9 + $one_to_nine + 6;
$one_to_ninety = $one_to_eighty + 6 * 9 + $one_to_nine + 6;
$one_to_ninety_nine = $one_to_ninety + 6 * 9 + $one_to_nine;
echo $one_to_ninety_nine, "\n", 100 * $one_to_nine + $one_to_ninety_nine * 10 + 10 * 9 * 99 + 7 * 9 + 11, "\n";

