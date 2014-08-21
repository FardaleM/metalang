#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub max2{
  my($a,
  $b) = @_;
  if ($a > $b) {
  return $a;
  }else{
  return $b;
  }
}

sub primesfactors{
  my($n) = @_;
  my $c = $n + 1;
  my $tab = [];
  foreach my $i (0 .. $c - 1) {
    $tab->[$i] = 0;
    }
  my $d = 2;
  while ($n ne 1 && $d * $d <= $n)
  {
    if ((remainder($n, $d)) eq 0) {
    $tab->[$d] = $tab->[$d] + 1;
    $n = int(($n) / ($d));
    }else{
    $d = $d + 1;
    }
  }
  $tab->[$n] = $tab->[$n] + 1;
  return $tab;
}

my $lim = 20;
my $e = $lim + 1;
my $o = [];
foreach my $m (0 .. $e - 1) {
  $o->[$m] = 0;
  }
foreach my $i (1 .. $lim) {
  my $t = primesfactors($i);
  foreach my $j (1 .. $i) {
    $o->[$j] = max2($o->[$j], $t->[$j]);
    }
  }
my $product = 1;
foreach my $k (1 .. $lim) {
  foreach my $l (1 .. $o->[$k]) {
    $product = $product * $k;
    }
  }
print($product, "\n");


