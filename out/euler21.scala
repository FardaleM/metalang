object euler21
{
  
  def eratostene(t : Array[Int], max0 : Int): Int = {
    var i: Int=0;
    var n: Int = 0;
    for (i <- 2 to max0 - 1)
      if (t(i) == i)
    {
      n = n + 1;
      var j: Int = i * i;
      while (j < max0 && j > 0)
      {
        t(j) = 0;
        j = j + i;
      }
    }
    return n;
  }
  
  def fillPrimesFactors(t : Array[Int], _n : Int, primes : Array[Int], nprimes : Int): Int = {
    var n = _n;
    var i: Int=0;
    for (i <- 0 to nprimes - 1)
    {
      var d: Int = primes(i);
      while ((n % d) == 0)
      {
        t(d) = t(d) + 1;
        n = n / d;
      }
      if (n == 1)
        return primes(i);
    }
    return n;
  }
  
  def sumdivaux2(t : Array[Int], n : Int, _i : Int): Int = {
    var i = _i;
    while (i < n && t(i) == 0)
      i = i + 1;
    return i;
  }
  
  def sumdivaux(t : Array[Int], n : Int, i : Int): Int = {
    var j: Int=0;
    if (i > n)
      return 1;
    else if (t(i) == 0)
      return sumdivaux(t, n, sumdivaux2(t, n, i + 1));
    else
    {
      var o: Int = sumdivaux(t, n, sumdivaux2(t, n, i + 1));
      var out0: Int = 0;
      var p: Int = i;
      for (j <- 1 to t(i))
      {
        out0 = out0 + p;
        p = p * i;
      }
      return (out0 + 1) * o;
    }
  }
  
  def sumdiv(nprimes : Int, primes : Array[Int], n : Int): Int = {
    var i: Int=0;
    var t :Array[Int] = new Array[Int](n + 1);
    for (i <- 0 to n + 1 - 1)
      t(i) = 0;
    var max0: Int = fillPrimesFactors(t, n, primes, nprimes);
    return sumdivaux(t, max0, 0);
  }
  
  
  def main(args : Array[String])
  {
    var maximumprimes: Int = 1001;
    var era :Array[Int] = new Array[Int](maximumprimes);
    for (j <- 0 to maximumprimes - 1)
      era(j) = j;
    var nprimes: Int = eratostene(era, maximumprimes);
    var primes :Array[Int] = new Array[Int](nprimes);
    for (o <- 0 to nprimes - 1)
      primes(o) = 0;
    var l: Int = 0;
    for (k <- 2 to maximumprimes - 1)
      if (era(k) == k)
    {
      primes(l) = k;
      l = l + 1;
    }
    printf("%d == %d\n", l, nprimes);
    var sum: Int = 0;
    for (n <- 2 to 1000)
    {
      var other: Int = sumdiv(nprimes, primes, n) - n;
      if (other > n)
      {
        var othersum: Int = sumdiv(nprimes, primes, other) - other;
        if (othersum == n)
        {
          printf("%d & %d\n", other, n);
          sum = sum + other + n;
        }
      }
    }
    printf("\n%d\n", sum);
  }
  
}

