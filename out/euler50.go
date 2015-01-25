package main
import "fmt"
func min2_(a int, b int) int{
  if a < b {
    return a
  } else {
    return b
  }
}

func eratostene(t []int, max0 int) int{
  var n int = 0
  for i := 2 ; i <= max0 - 1; i++ {
    if t[i] == i {
        n ++;
          if max0 / i > i {
            var j int = i * i
              for j < max0 && j > 0{
                t[j] = 0;
                j += i;
              }
          }
      }
  }
  return n
}

func main() {
  var maximumprimes int = 1000001
  var era []int = make([]int, maximumprimes)
  for j := 0 ; j <= maximumprimes - 1; j++ {
    era[j] = j;
  }
  var nprimes int = eratostene(era, maximumprimes)
  var primes []int = make([]int, nprimes)
  for o := 0 ; o <= nprimes - 1; o++ {
    primes[o] = 0;
  }
  var l int = 0
  for k := 2 ; k <= maximumprimes - 1; k++ {
    if era[k] == k {
        primes[l] = k;
          l ++;
      }
  }
  fmt.Printf("%d == %d\n", l, nprimes);
  var sum []int = make([]int, nprimes)
  for i_ := 0 ; i_ <= nprimes - 1; i_++ {
    sum[i_] = primes[i_];
  }
  var maxl int = 0
  var process bool = true
  var stop int = maximumprimes - 1
  var len int = 1
  var resp int = 1
  for process{
    process = false;
    for i := 0 ; i <= stop; i++ {
      if i + len < nprimes {
          sum[i] = sum[i] + primes[i + len];
            if maximumprimes > sum[i] {
              process = true;
                if era[sum[i]] == sum[i] {
                  maxl = len;
                    resp = sum[i];
                }
            } else {
              var c int = min2_(stop, i)
              stop = c;
            }
        }
    }
    len ++;
  }
  fmt.Printf("%d\n%d\n", resp, maxl);
}

