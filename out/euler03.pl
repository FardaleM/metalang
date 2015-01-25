#!/usr/bin/perl
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

my $maximum = 1;
my $b0 = 2;
my $a = 408464633;
my $sqrtia = int(sqrt($a));
while ($a ne 1)
{
  my $b = $b0;
  my $found = 0;
  while ($b <= $sqrtia)
  {
    if ((remainder($a, $b)) eq 0) {
      $a = int(($a) / ($b));
      $b0 = $b;
      $b = $a;
      my $e = int(sqrt($a));
      $sqrtia = $e;
      $found = 1;
    }
    $b = $b + 1;
  }
  if (!$found) {
    print($a, "\n");
    $a = 1;
  }
}


